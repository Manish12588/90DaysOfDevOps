resource "aws_vpc" "main" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "terraweek-vpc"
  }
}

resource "aws_subnet" "this" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "us-west-2a"
  map_public_ip_on_launch = true
  tags = {
    Name = "terraweek-public-subnet"
  }
}

resource "aws_internet_gateway" "this" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "terraweek-igw"
  }
}

# ============== LOCALS =========================================#
locals {
  common_tags = {
    Project     = "TerraWeek"
    Environment = "dev"
    ManagedBy   = "Terraform"
  }
}

#=================================================================#

#============== DATA =============================================#

data "aws_ami" "amazon_linux" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
}
#===================================================================#

#=========== MODULE CALLING ========================================#

module "web_sg" {
  source        = "./modules/security-group"
  vpc_id        = aws_vpc.main.id
  sg_name       = "terraweek-web-sg"
  ingress_ports = [22, 80, 443]
  tags          = local.common_tags
}

module "web_server" {
  source             = "./modules/ec2-instance"
  ami_id             = data.aws_ami.amazon_linux.id
  instance_type      = "t3.micro"
  subnet_id          = aws_subnet.this.id
  security_group_ids = [module.web_sg.sg_id]
  instance_name      = "terraweek-web"
  tags               = local.common_tags
}

module "api_server" {
  source             = "./modules/ec2-instance"
  ami_id             = data.aws_ami.amazon_linux.id
  instance_type      = "t3.micro"
  subnet_id          = aws_subnet.this.id
  security_group_ids = [module.web_sg.sg_id]
  instance_name      = "terraweek-api"
  tags               = local.common_tags
}

#====================================================================#

#====================================================================#
resource "null_resource" "wait_for_ips" {
  depends_on = [module.web_server, module.api_server]

  provisioner "local-exec" {
    interpreter = ["PowerShell", "-Command"]
    command     = <<EOT
      $webId = "${module.web_server.instance_id}"
      $apiId = "${module.api_server.instance_id}"

      Write-Host "Waiting for public IPs to be assigned..."

      while ($true) {
        $webIp = aws ec2 describe-instances `
          --instance-ids $webId `
          --query "Reservations[0].Instances[0].PublicIpAddress" `
          --output text

        $apiIp = aws ec2 describe-instances `
          --instance-ids $apiId `
          --query "Reservations[0].Instances[0].PublicIpAddress" `
          --output text

        if ($webIp -ne "None" -and $apiIp -ne "None") {
          Write-Host "Web Server IP: $webIp"
          Write-Host "API Server IP: $apiIp"
          break
        }

        Write-Host "IPs not ready yet... retrying in 5 seconds"
        Start-Sleep -Seconds 5
      }
    EOT
  }
}
#====================================================================#
