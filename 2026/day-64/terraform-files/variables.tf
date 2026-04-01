variable "region" {

  description = "Variable holds the region of EC2 Instance."
  default     = "us-east-2"
  type        = string
}

variable "vpc_cidr" {

  description = "Variable holds vpc cidr."
  default     = "10.0.0.0/16"
  type        = string
}

variable "subnet_cidr" {

  description = "Variable holds subnet cidr."
  default     = "10.0.1.0/24"
  type        = string
}

variable "instance_type" {

  description = "Variable holds type of ec2 instance."
  default     = "t3.micro"
  type        = string
}

variable "project_name" {

  description = "Variable holds project name"
  type        = string
}


variable "environment" {

  description = "Variable holds environment."
  default     = "dev"
  type        = string
}

variable "allowed_ports" {

  description = "Variable holds the list of allowed ports"
  default     = [22, 80, 443]
  type        = list(number)
}

variable "extra_tags" {

  description = "Variable holds extra tags"
  default     = {}
  type        = map(string)
}
