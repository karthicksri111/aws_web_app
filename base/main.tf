provider "aws" {
  region         = var.region
  assume_role {
    role_arn     = "arn:aws:iam::${local.account_id}:role/Terraform_Role" 
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
    tags = {
    Name = "igw1"
  }
}

resource "aws_subnet" "subnet_a" {
  vpc_id     = aws_vpc.vpc1.id
  cidr_block = var.subnet_a_cidr
    tags = {
    Name = "subnet_a"
  }
}
resource "aws_subnet" "subnet_b" {
  vpc_id     = aws_vpc.vpc1.id
  cidr_block = var.subnet_b_cidr
      tags = {
    Name = "subnet_b"
  }
}
resource "aws_subnet" "subnet_c" {
  vpc_id     = aws_vpc.vpc1.id
  cidr_block = var.subnet_c_cidr
      tags = {
    Name = "subnet_c"
  }
}
resource "aws_subnet" "subnet_d" {
  vpc_id     = aws_vpc.vpc1.id
  cidr_block = var.subnet_d_cidr
      tags = {
    Name = "subnet_d"
  }
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.vpc1.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw1.id
  }
      tags = {
    Name = "public"
  }
}
resource "aws_route_table" "pvt" {
  vpc_id = aws_vpc.vpc1.id
  
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.ngw1.id
  }
      tags = {
    Name = "pvt"
  }
}

resource "aws_eip" "eip1" {
  domain = "vpc"
  tags = {
    Name = "eip1"
	}
}

resource "aws_nat_gateway" "ngw1" {
  allocation_id = aws_eip.eip1.id
  subnet_id = aws_subnet.subnet_b.id
      tags = {
    Name = "ngw1"
  }
}