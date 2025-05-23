# modules/vpc/outputs.tf

output "vpc_id" {
  value = aws_vpc.main.id
}

output "subnet_ids" {
  value = aws_subnet.private[*].id
}

