variable "region" {

  description = "Variable holds the region of EC2 Instance."
  default     = "ap-south-1"
  type        = string
}

variable "cluster_name" {

  description = "Variable holds the EKS cluster name"
  default     = "terraweek-eks"
  type        = string
}

variable "cluster_version" {

  description = "Variable holds the EKS cluster version"
  default     = "1.31"
  type        = string
}

variable "node_instance_type" {

  description = "Variable holds the instance type of node"
  default     = "t3.medium"
  type        = string
}

variable "node_desired_count" {

  description = "Variable holds the instance type of node"
  default     = 2
  type        = number
}

variable "vpc_cidr" {

  description = "Variable holds the cidr of vpc"
  default     = "10.0.0.0/16"
  type        = string
}
