# variable "vpc_id" {
#   description = "The VPC ID"
# }
# variable "public_subnet_ids" {
#   description = "List of public subnet IDs"
#   type        = list(string)
# }

# variable "private_subnet_ids" {
#   description = "List of private subnet IDs"
#   type        = list(string)
# }
variable "ec2-subnet" {
    type = string
}
variable "ec2-subnet2" {
    type = string
}
variable "security_group1" {
    type = list(string)
  
}
variable "security_group2" {
    type = list(string)
  
}