provider "aws" {
  region = var.aws_region
}

resource "aws_vpc" "dev-vpc" {
  cidr_block = var.vpc_cidr_block
  tags =  {
    Name = var.env_prefix
  }
}

resource "aws_subnet" "dev-subnet-1" {
  vpc_id = aws_vpc.dev-vpc.id
  cidr_block = var.subnet_1_cidr_block
  availability_zone = var.az_subnet_1
  tags =  {
    Name = "${var.env_prefix}-subnet-1"
  }
}

data "aws_vpc" "existing-vpc"{
  cidr_block = var.vpc_cidr_block
}

resource "aws_subnet" "dev-subnet-2" {
  vpc_id = data.aws_vpc.existing-vpc.id
  cidr_block = var.subnet_2_cidr_block
  availability_zone = var.az_subnet_2
  tags =  {
    Name = "${var.env_prefix}-subnet-2"
  }
}

resource "aws_subnet" "dev-subnet-3" {
  vpc_id = data.aws_vpc.existing-vpc.id
  cidr_block = var.subnet_3_cidr_block
  availability_zone = var.az_subnet_3
  tags =  {
      Name = "${var.env_prefix}-subnet-3"
  }
}

# output "${var.env_prefix}-vpc-id" {
#   value = aws_vpc.dev-vpc.id
# }

# output "${var.env_prefix}-subnet-1-id" {
#   value = aws_subnet.dev-subnet-1.id
# }

# output "${var.env_prefix}-subnet-2-id" {
#   value = aws_subnet.dev-subnet-2.id
# }

# output "${var.env_prefix}-subnet-3-id" {
#   value = aws_subnet.dev-subnet-3.id
# }