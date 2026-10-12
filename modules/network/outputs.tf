output "vpc_id" {
  description = "the id of the vpc"
  value = aws_vpc.this.id
}

output "public_subnet_id" {
  description = "the id of the public subnet"
  value = aws_subnet.public.id
}

output "private_app_subnet_id" {
  description = "the id of the private app subnet"
  value = aws_subnet.private_app.id
}

output "private_db_subnet_id" {
  description = "the id of the private db subnet"
  value = aws_subnet.private_db.id
}

output "nat_eip" {
  description = "The elastic ip public address assigned to nat gateway"
  value = aws_eip.nat.public_ip
}