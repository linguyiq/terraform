provider "aws" {
  region = var.aws_region
}

resource "aws_vpc" "dev-vpc" {
  cidr_block = var.vpc_cidr_block
  tags =  {
    Name = "Development_01"
  }
}

resource "aws_subnet" "dev-subnet-1" {
  vpc_id = aws_vpc.dev-vpc.id
  cidr_block = var.subnet_1_cidr_block
  availability_zone = "us-east-1d"
  tags =  {
    Name = "subnet-dev-1"
  }
}

data "aws_vpc" "existing-vpc"{
  cidr_block = var.vpc_cidr_block
}

resource "aws_subnet" "dev-subnet-2" {
  vpc_id = data.aws_vpc.existing-vpc.id
  cidr_block = var.subnet_2_cidr_block
  availability_zone = "us-east-1e"
  tags =  {
    Name = "subnet-dev-2"
  }
}

resource "aws_subnet" "dev-subnet-3" {
  vpc_id = data.aws_vpc.existing-vpc.id
  cidr_block = var.subnet_3_cidr_block
  availability_zone = "us-east-1f"
  tags =  {
      Name = "subnet-dev-3"
  }
}

output "dev-vpc-id" {
  value = aws_vpc.dev-vpc.id
}

output "dev-subnet-1-id" {
  value = aws_subnet.dev-subnet-1.id
}

output "dev-subnet-2-id" {
  value = aws_subnet.dev-subnet-2.id
}

output "dev-subnet-3-id" {
  value = aws_subnet.dev-subnet-3.id
}