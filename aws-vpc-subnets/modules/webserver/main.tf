resource "aws_default_security_group" "df-sg" {
  vpc_id = var.vpc_id

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
  subnet_id = var.subnet-1_id
  vpc_security_group_ids = [aws_default_security_group.df-sg.id]
  availability_zone = var.az_subnet_1
  associate_public_ip_address = true
  key_name = "aws_server"

  user_data = file("nginx-script.sh")
  tags = {
    Name = "${var.env_prefix}-server"
  }
}