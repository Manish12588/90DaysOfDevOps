#---------- VIRTUAL PRIVATE CLOUD (VPC) ---------------#
resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "TerraWeek-VPC"
  }
}

resource "aws_subnet" "this" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = true
  tags = {
    Name = "TerraWeek-Public-Subnet"
  }
}

resource "aws_internet_gateway" "this" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "Terraweek-internet-gateway"
  }
}

resource "aws_route_table" "route_table" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.this.id
  }
  tags = {
    Name = "Terraweek-route-table"
  }
}

resource "aws_route_table_association" "route_table_association" {
  subnet_id      = aws_subnet.this.id
  route_table_id = aws_route_table.route_table.id

}

#-------- SECURITY GROUP -------------------#

resource "aws_security_group" "this" {

  vpc_id      = aws_vpc.main.id
  description = "This is inbound and outbound rules of your instance"
  tags = {
    Name = "TerraWeek-SG"
  }
}

resource "aws_vpc_security_group_ingress_rule" "allow_ssh" {
  security_group_id = aws_security_group.this.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 22
  ip_protocol       = "tcp"
  to_port           = 22
}

resource "aws_vpc_security_group_ingress_rule" "allow_http" {
  security_group_id = aws_security_group.this.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 80
  ip_protocol       = "tcp"
  to_port           = 80
}

resource "aws_vpc_security_group_egress_rule" "allow_outbound_traffic" {
  security_group_id = aws_security_group.this.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
}

#------------ AWS EC2 INSTANCE ----------#

resource "aws_instance" "name" {

  ami = "ami-07062e2a343acc423"  #us-east-2
  instance_type = "t3.micro"
  subnet_id = aws_subnet.this.id
  vpc_security_group_ids = [aws_security_group.this.id]
  associate_public_ip_address = true

  tags = {
    Name = "TerraWeek-Server"
  }

}
