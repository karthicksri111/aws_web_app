variable "region" {
  description = "The name of the target AWS region"
  type = string
  default = "us-east-1"
}

variable "vpc_cidr" {
  type = string
  default = "10.0.0.0/16"
}

variable "subnet_a_cidr" {
  type = string
  default = "10.0.1.0/24"
}

variable "subnet_b_cidr" {
  type = string
  default = "10.0.2.0/24"
}

variable "subnet_c_cidr" {
  type = string
  default = "10.0.3.0/24"
}

variable "subnet_d_cidr" {
  type = string
  default = "10.0.4.0/24"
}

