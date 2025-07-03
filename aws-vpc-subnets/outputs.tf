# outputs

output "ec2-public-ip" {
  value = aws_instance.dev-server.public_ip
}

output "vpc-id" {
  value = aws_vpc.dev-vpc.id
}

output "subnet-1-id" {
  value = aws_subnet.dev-subnet-1.id
}

output "subnet-2-id" {
  value = aws_subnet.dev-subnet-2.id
}

output "subnet-3-id" {
  value = aws_subnet.dev-subnet-3.id
}