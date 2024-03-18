# # resource "aws_db_instance" "oracle" {
# #   allocated_storage    = 20
# #   storage_type         = "gp2"
# #   engine               = "oracle-se2"
# #   engine_version       = "19.0.0.0.ru-2022-07.rur-2022-07.r1"
# #   instance_class       = "db.t2.micro"
# #   username             = "dbuser"
# #   password             = "dbpassword"
# #   parameter_group_name = "default.oracle-se2-19.0"

# #   # Specify the DB subnet group
# #   db_subnet_group_name = aws_db_subnet_group.ranga.name

# #   vpc_security_group_ids = [aws_security_group.example.id]

# #   publicly_accessible = false
# #   storage_encrypted   = true
# #   backup_retention_period = 7

# #   maintenance_window = "Sun:03:00-Sun:04:00"
# #   backup_window      = "04:00-05:00"

# #   tags = {
# #     Name = "MyOracleDB"
# #   }
# # }


# resource "aws_db_subnet_group" "ranga" {
#   name        = "example-subnet-group"
#   description = "Example DB subnet group"
#   subnet_ids  = [aws_subnet.private2["subnet1"].id, aws_subnet.public2["subnet2"].id]
# }

# module "vpc" {
#   source = "../VPC-2"
#   subnet_ids  = aws_subnet.private2["subnet1"].id 
#   # Configuration for your VPC module
# }

# resource "aws_security_group" "example" {
#   name        = "my-rds-security-group"
#   description = "Security group for RDS instance"

#   vpc_id = module.vpc.vpc_id

#   # Define your security group rules here
#   # Example: Inbound rule for Oracle (Port 1521)
#   ingress {
#     from_port   = 1521
#     to_port     = 1521
#     protocol    = "tcp"
#     cidr_blocks = ["0.0.0.0/0"]
#   }
# }
# resource "aws_db_instance" "my_rds_instance" {
#   identifier           = "my-rds-instance"
#   engine               = "oracle-se2"
#   instance_class       = "db.t2.micro"
#   allocated_storage    = 20
#   username             = "ranga"
#   password             = "dbpassword"
#   db_subnet_group_name  = aws_db_subnet_group.aurora_subnet_group.name
#   vpc_security_group_ids = [aws_security_group.example.id]
# #   db_subnet_group_name = aws_db_subnet_group.aurora_subnet_group.id
# #   vpc_security_group_ids = [aws_security_group.my_security_group.id]
#    engine_version       = "19.0.0.0.ru-2021-07.rur-2021-07.r1"
# license_model        = "license-included"  # Set to "license-included" or "bring-your-own-license"
# skip_final_snapshot   = true

#   tags = {
#     Name = "MyRDSInstance"
#     # Add any other tags as needed
#     }
# }
#  module "vpc" {
#    source = "../VPC-2"
#    subnet_ids  = aws_subnet.private2["subnet1"].id
   
#  }

# resource "aws_security_group" "my_security_group" {
#   name        = "rds_security_group"
#   description = "My security group for EC2 instances"
#   vpc_id = aws_vpc.ranga_vpc2.id

#   ingress {
#     from_port   = 1521
#     to_port     = 1521
#     protocol    = "tcp"
#     cidr_blocks = ["0.0.0.0/0"]
#   }

#   egress {
#     from_port   = 0
#     to_port     = 0
#     protocol    = "-1"
#     cidr_blocks = ["0.0.0.0/0"]
#   }
# }

# resource "aws_db_subnet_group" "aurora_subnet_group" {
#   name       = "asg"
#   subnet_ids = [ aws_subnet.private2["subnet2"].id ]
# }

