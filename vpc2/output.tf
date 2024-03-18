output "vpc_id" {
  description = "The ID of the VPC."
  value       = aws_vpc.ranga_vpc2.id
}
output "subnet_id1" {
  value = aws_subnet.private2["subnet2"].id
}
output "security-2"{
  value = [aws_security_group.example_security_group.id]
}
# output "routing_table" {
  
#   value = aws_route_table.private2.id
# }

