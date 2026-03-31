#---------- VIRTUAL PRIVATE CLOUD (VPC) ---------------#
resource "aws_vpc" "main" {
  cidr_block = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = merge({
    Name        = "${var.project_name}-VPC"
    Environment = var.environment
  }, var.extra_tags)
} 

resource "aws_subnet" "this" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.subnet_cidr
  map_public_ip_on_launch = true

  tags = merge({
    Name        = "${var.project_name}-Public-Subnet"
    Environment = var.environment
  }, var.extra_tags)
}

resource "aws_internet_gateway" "this" {
  vpc_id = aws_vpc.main.id

 tags = merge({
    Name        = "${var.project_name}-internet-gateway"
    Environment = var.environment
  }, var.extra_tags)
}

resource "aws_route_table" "route_table" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.this.id
  }

   tags = merge({
    Name        = "${var.project_name}-route-table"
    Environment = var.environment
  }, var.extra_tags)
}

resource "aws_route_table_association" "route_table_association" {
  subnet_id      = aws_subnet.this.id
  route_table_id = aws_route_table.route_table.id

}

#-------- SECURITY GROUP -------------------#

resource "aws_security_group" "this" {

  vpc_id      = aws_vpc.main.id
  description = "This is inbound and outbound rules of your instance"
   tags = merge({
    Name        = "${var.project_name}-SG"
    Environment = var.environment
  }, var.extra_tags)
}

resource "aws_vpc_security_group_ingress_rule" "allow_ports" {
  for_each = toset([for p in var.allowed_ports : tostring(p)])
  security_group_id = aws_security_group.this.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = tonumber(each.value)
  ip_protocol       = "tcp"
  to_port           = tonumber(each.value)
}

resource "aws_vpc_security_group_egress_rule" "allow_outbound_traffic" {
  security_group_id = aws_security_group.this.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
}

#------------ AWS EC2 INSTANCE ----------#

resource "aws_instance" "this" {

  #ami                         = "ami-07062e2a343acc423" #us-east-2
  ami                         = "ami-09e981c4823691af6" #us-east-2
  instance_type               = var.instance_type
  subnet_id                   = aws_subnet.this.id
  vpc_security_group_ids      = [aws_security_group.this.id]
  associate_public_ip_address = true
  lifecycle {
    create_before_destroy = true
  }

  tags = merge({
    Name        = "${var.project_name}-Server"
    Environment = var.environment
  }, var.extra_tags)

}

#---------- S3 BUCKET -------------#

resource "aws_s3_bucket" "app_log_bucket" {

  depends_on = [aws_instance.this]
  tags = merge({
    Name        = "${var.project_name}-app-log"
    Environment = var.environment
  }, var.extra_tags)
}
