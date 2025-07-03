output "availability_zones" {
  value = data.aws_availability_zones.az.names
}

output "ami_id" {
  value = data.aws_ami.ubuntu_22_04.id
}

output "random_string" {
  value = random_string.random.result
}

output "public_key" {
  value = tls_private_key.genprivkey.public_key_openssh
  sensitive = true
}