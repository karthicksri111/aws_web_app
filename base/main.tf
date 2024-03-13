provider "aws" {
  region         = var.region
  assume_role {
    role_arn     = "arn:aws:iam::${local.account_id):role/Terraform_Admin_User" 
	}
}

resource "aws_vpc" "vpc1" {
  cidr_block       = var.vpc_cidr
  instance_tenancy = "default"
  tags = {
    Name = "vpc1"
  }
}

resource "aws_internet_gateway" "igw1" {
  vpc_id = aws_vpc.vpc1.id
}

resource "aws_subnet" "subnet_a" {
  vpc_id     = aws_vpc.vpc1.id
  cidr_block = var.subnet_a_cidr
}
resource "aws_subnet" "subnet_b" {
  vpc_id     = aws_vpc.vpc1.id
  cidr_block = var.subnet_b_cidr
}
resource "aws_subnet" "subnet_c" {
  vpc_id     = aws_vpc.vpc1.id
  cidr_block = var.subnet_c_cidr
}
resource "aws_subnet" "subnet_d" {
  vpc_id     = aws_vpc.vpc1.id
  cidr_block = var.subnet_d_cidr
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.vpc1.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw1.id
  }
}
resource "aws_route_table" "private" {
  vpc_id = aws_vpc.vpc1.id
  
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.ngw1.id
  }
}

resource "aws_nat_gateway" "ngw1" {
  subnet_id = aws_subnet.subnet_b.id
}