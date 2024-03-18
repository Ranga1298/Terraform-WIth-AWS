
resource "aws_instance" "example_instance1" {
  ami                    = "ami-036f5574583e16426"
  instance_type          = "t2.micro"
  key_name               = "terravalue"
  subnet_id = var.ec2-subnet
  vpc_security_group_ids = var.security_group1
  tags = {
    Name = "ec2-terra"
  }

}
resource "aws_instance" "example_instance2" {
  ami                    = "ami-036f5574583e16426"
  instance_type          = "t2.micro"
  key_name               = "terravalue"
  subnet_id = var.ec2-subnet2
  vpc_security_group_ids = var.security_group2
  tags = {
    Name = "ec2-terra2"
  }

}
