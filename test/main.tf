provider "aws" {
  region = "us-east-1"
}

data "aws_availability_zones" "az" {}
data "aws_ami" "ubuntu_22_04" {
  most_recent = true
  owners      = ["099720109477"] # Canonical's account ID for Ubuntu

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }
}

resource "tls_private_key" "genprivkey" {
  algorithm = "RSA"
  rsa_bits  = 2048
}

resource "local_file" "private_key_pem" {
  content  = tls_private_key.genprivkey.private_key_pem
  filename = "${path.module}/private_key.pem"
}

resource "random_string" "random" {
  length      = 16
  special     = true
  min_upper   = 4
  min_special = 3
  min_numeric = 3
}