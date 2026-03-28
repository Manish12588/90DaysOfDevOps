provider "aws" {

  region = "us-west-2"
}

resource "aws_s3_bucket" "s3_bucket" {
  bucket = "terraweek-manish-2026"

}

resource "aws_key_pair" "terra_key_pair" {
  key_name = "terra-challange-key"
  #public_key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILvAi7s3BmiO8GeJL+0vJUwkLwYlp+HEANB+kM3dvTYR ubuntu@ip-172-31-45-223"
  public_key = file("terra-challange-key.pub")
}

resource "aws_default_vpc" "default" {}

resource "aws_security_group" "terra_security_group" {

  name        = "terra-security-group"
  vpc_id      = aws_default_vpc.default.id ## we are getting the vpc_id from above created resources and it's called interpolation
  description = "This is inbound and outbound rules of your instance"
}

resource "aws_vpc_security_group_ingress_rule" "security_inbound_rule" {
  security_group_id = aws_security_group.terra_security_group.id
  cidr_ipv4         = aws_default_vpc.default.cidr_block
  from_port         = 80
  ip_protocol       = "tcp"
  to_port           = 80
}

resource "aws_vpc_security_group_ingress_rule" "security_outbound_rule" {
  security_group_id = aws_security_group.terra_security_group.id
  cidr_ipv4         = aws_default_vpc.default.cidr_block
  from_port         = 22
  ip_protocol       = "tcp"
  to_port           = 22
}

resource "aws_instance" "terra_ec2_instance" {

  ami           = "ami-0d76b909de1a0595d"
  instance_type = "t3.micro"
  key_name      = aws_key_pair.terra_key_pair.key_name

  vpc_security_group_ids = [aws_security_group.terra_security_group.id]


  #Root Storage
  root_block_device {
    volume_size = 10
    volume_type = "gp3"
  }

  tags = {
    Name = "TerraWeek-Day1"
  }
}