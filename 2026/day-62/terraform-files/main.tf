resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "TerraWeek-VPC"
  }
}

resource "aws_subnet" "this" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.0.1.0/24"
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
    subnet_id = aws_subnet.this.id
    route_table_id = aws_route_table.route_table.id
  
}
