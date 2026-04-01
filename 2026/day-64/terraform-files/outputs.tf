output "vpc_id" {

  value = aws_vpc.main.id
}

output "subnet_id" {

  value = aws_subnet.this.id
}

output "instance_id" {

  value = aws_instance.this.id
}

output "instance_public_ip" {

  value = aws_instance.this.public_ip
}

output "instance_public_dns" {

  value = aws_instance.this.public_dns
}

output "security_group_id" {

  value = aws_security_group.this.id
}

output "ami" {

  value = aws_instance.this.ami
}

output "available_zone" {

  value = aws_subnet.this.availability_zone
}

output "vpc_name" {
  value = aws_vpc.main.tags_all["Name"]
}
output "subnet_name" {
  value = aws_subnet.this.tags_all["Name"]
}