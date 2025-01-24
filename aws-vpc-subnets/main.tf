provider "aws" {
  region = var.aws_region
}

resource "aws_vpc" "dev-vpc" {
  cidr_block = var.vpc_cidr_block
  tags =  {
    Name = var.env_prefix
  }
}

resource "aws_internet_gateway" "dev-igw" {
  vpc_id = aws_vpc.dev-vpc.id
  tags =  {
    Name = "${var.env_prefix}-igw"
  }
}

resource "aws_default_route_table" "df-rtb" {
  default_route_table_id = aws_vpc.dev-vpc.default_route_table_id
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
  vpc_id = aws_vpc.dev-vpc.id
  cidr_block = var.subnet_1_cidr_block
  availability_zone = var.az_subnet_1
  tags =  {
    Name = "${var.env_prefix}-subnet-1"
  }
} 

resource "aws_subnet" "dev-subnet-2" {
  vpc_id = aws_vpc.dev-vpc.id
  cidr_block = var.subnet_2_cidr_block
  availability_zone = var.az_subnet_2
  tags =  {
    Name = "${var.env_prefix}-subnet-2"
  }
}

resource "aws_subnet" "dev-subnet-3" {
  vpc_id = aws_vpc.dev-vpc.id
  cidr_block = var.subnet_3_cidr_block
  availability_zone = var.az_subnet_3
  tags =  {
      Name = "${var.env_prefix}-subnet-3"
  }
}

resource "aws_default_security_group" "df-sg" {
  vpc_id = aws_vpc.dev-vpc.id

  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = [var.my_ip]
  }

  ingress {
    from_port = 8080
    to_port = 8080
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    prefix_list_ids = []
  }

  tags =  {
      Name = "${var.env_prefix}-df-sg"
  }
}

data "aws_ami" "latest-amazon-linux-2-ami" {
  most_recent = true
  owners = ["amazon"] 

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  } 
}

resource "aws_instance" "dev-server" {
  ami = data.aws_ami.latest-amazon-linux-2-ami.id
  instance_type = "t2.micro"
  subnet_id = aws_subnet.dev-subnet-1.id
  vpc_security_group_ids = [aws_default_security_group.df-sg.id]
  availability_zone = var.az_subnet_1
  associate_public_ip_address = true
  key_name = "aws_server"
  tags = {
    Name = "${var.env_prefix}-server"
  }
}

# output

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