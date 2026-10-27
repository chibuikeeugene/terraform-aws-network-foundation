output "vpc_id" {
  description = "the id of the vpc"
  value       = aws_vpc.this.id
}

output "public_subnet_id" {
  description = "the id of the public subnet"
  value = {
    for name, subnet in aws_subnet.public :
    name => subnet.id
  }
}

output "private_app_subnet_id" {
  description = "the id of the private app subnet"
  value = {
    for name, subnet in aws_subnet.private_app :
    name => subnet.id
  }
}

output "private_db_subnet_id" {
  description = "the id of the private db subnet"
  value = {
    for name, subnet in aws_subnet.private_db :
    name => subnet.id
  }
}

output "nat_eip" {
  description = "The elastic ip public address assigned to nat gateway"
  value = {
    for name, nat_eip in aws_eip.nat :
    name => nat_eip.public_ip
  }
}