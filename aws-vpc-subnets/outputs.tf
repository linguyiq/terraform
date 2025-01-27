
output "vpc-id" {
  value = aws_vpc.dev-vpc.id
}

output "ec2-public-ip" {
  value = module.webserver.instance_public_ip
}


