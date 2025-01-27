resource "aws_vpc" "dev-vpc" {
  cidr_block = var.vpc_cidr_block
  tags =  {
    Name = var.env_prefix
  }
}

module "subnet" {
  source = "./modules/subnet"
  vpc_id = aws_vpc.dev-vpc.id
  default_route_table_id = aws_vpc.dev-vpc.default_route_table_id
  subnet_1_cidr_block = var.subnet_1_cidr_block
  subnet_2_cidr_block = var.subnet_2_cidr_block
  subnet_3_cidr_block = var.subnet_3_cidr_block
  az_subnet_1 = var.az_subnet_1
  az_subnet_2 = var.az_subnet_2
  az_subnet_3 = var.az_subnet_3
  env_prefix = var.env_prefix
}

module "webserver" {
  source = "./modules/webserver"
  vpc_id = aws_vpc.dev-vpc.id
  subnet-1_id = module.subnet.subnet-1.id
  az_subnet_1 = var.az_subnet_1
  az_subnet_2 = var.az_subnet_2
  az_subnet_3 = var.az_subnet_3
  env_prefix = var.env_prefix
  my_ip = var.my_ip
}
