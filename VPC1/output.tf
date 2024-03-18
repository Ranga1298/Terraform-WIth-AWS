output "vpc_id" {
  description = "The ID of the VPC."
  value       = aws_vpc.ranga_vpc1.id
}
# output "ranga_id" {
#   value = module.ranga_instance_1.ec2_instance_id
# }
# output "public_subnet_ids" {
#   value = module.public1.public_subnet_ids
# }

# output "private_subnet_ids" {
#   value = module.private1.private_subnet_ids
# }
output "subnet_ec2"{
  value = aws_subnet.public1["subnet1"].id
}
output "security-1"{
  value = [aws_security_group.example_security_group.id]
}
