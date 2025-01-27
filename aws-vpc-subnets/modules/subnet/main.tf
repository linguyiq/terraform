resource "aws_internet_gateway" "dev-igw" {
  vpc_id = var.vpc_id
  tags =  {
    Name = "${var.env_prefix}-igw"
  }
}

resource "aws_default_route_table" "df-rtb" {
  default_route_table_id = var.default_route_table_id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.dev-igw.id
  }
  tags =  {
    Name = "${var.env_prefix}-df-rtb"
  }
}

resource "aws_route_table_association" "dev-rtb-subnet-1" {
  subnet_id = aws_subnet.dev-subnet-1.id
  route_table_id = aws_default_route_table.df-rtb.id
}

resource "aws_route_table_association" "dev-rtb-subnet-2" {
  subnet_id = aws_subnet.dev-subnet-2.id
  route_table_id = aws_default_route_table.df-rtb.id
}

resource "aws_route_table_association" "dev-rtb-subnet-3" {
  subnet_id = aws_subnet.dev-subnet-3.id
  route_table_id = aws_default_route_table.df-rtb.id
}

resource "aws_subnet" "dev-subnet-1" {
  vpc_id = var.vpc_id
  cidr_block = var.subnet_1_cidr_block
  availability_zone = var.az_subnet_1
  tags =  {
    Name = "${var.env_prefix}-subnet-1"
  }
} 

resource "aws_subnet" "dev-subnet-2" {
  vpc_id = var.vpc_id
  cidr_block = var.subnet_2_cidr_block
  availability_zone = var.az_subnet_2
  tags =  {
    Name = "${var.env_prefix}-subnet-2"
  }
}

resource "aws_subnet" "dev-subnet-3" {
  vpc_id = var.vpc_id
  cidr_block = var.subnet_3_cidr_block
  availability_zone = var.az_subnet_3
  tags =  {
      Name = "${var.env_prefix}-subnet-3"
  }
}