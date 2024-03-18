# Creating VPC 

resource "aws_vpc" "ranga_vpc2" {
  cidr_block = "10.0.1.0/25"
  tags = {
    Name = var.vpc_name2
  }
}

# Creating Public Subnets
resource "aws_subnet" "public2" {
  for_each = var.public_subnets

  vpc_id                  = aws_vpc.ranga_vpc2.id
  cidr_block              = each.value.cidr_block
  availability_zone       = each.value.availability_zone
  map_public_ip_on_launch = true
}


# Creating Private Subnets
resource "aws_subnet" "private2" {
  for_each = var.private_subnets

  vpc_id                  = aws_vpc.ranga_vpc2.id
  cidr_block              = each.value.cidr_block
  availability_zone       = each.value.availability_zone
}


# Creating Internet_GateWay
resource "aws_internet_gateway" "internet_example2" {
  vpc_id = aws_vpc.ranga_vpc2.id
  tags = {
    Name = "example-internet-gateway2"
  }
}


# Ceating Elastic Ip for NAT Gateway
resource "aws_eip" "eip_example2" {
  for_each = var.private_subnets
}

# Creating Nat_Gateway
resource "aws_nat_gateway" "nat_example2" {

  allocation_id = aws_eip.eip_example2["subnet2"].id
  subnet_id     = aws_subnet.private2["subnet2"].id

  tags = {
    Name = "example-nat-gateway2"
  }
}


# Creating Route Table for Public Subnets
resource "aws_route_table" "private2" {
  vpc_id = aws_vpc.ranga_vpc2.id
}

# Creating Route Table For Private Subnets
resource "aws_route_table" "public2" {
  vpc_id = aws_vpc.ranga_vpc2.id
}


# Creating Route Table association For Public Subnets
resource "aws_route_table_association" "public2" {
  for_each = aws_subnet.public2

  subnet_id      = each.value.id
  route_table_id = aws_route_table.public2.id
}

# Creating Route Table association For Private Subnets
resource "aws_route_table_association" "private2" {
  for_each = aws_subnet.private2

  subnet_id      = each.value.id
  route_table_id = aws_route_table.private2.id
}

# Estblishing Route  For Public Subnets
resource "aws_route" "public2" {
  route_table_id         = aws_route_table.public2.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.internet_example2.id
}

# Estblishing Route  For Private Subnet1 using nat Gateway based on Route Table
resource "aws_route" "private2" {

  route_table_id         = aws_route_table.private2.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.nat_example2.id
  depends_on = [aws_route_table.private2]
}




# Creating NACLs for Public and private
resource "aws_network_acl" "public_nacl2" {
  for_each = var.public_subnets

  vpc_id = aws_vpc.ranga_vpc2.id
}

resource "aws_network_acl" "private_nacl2" {
  for_each = var.private_subnets

  vpc_id = aws_vpc.ranga_vpc2.id
}

#  ingress and egress rules for public and private NACLs
resource "aws_network_acl_rule" "public_ingress2" {
  for_each = var.public_subnets

  network_acl_id = aws_network_acl.public_nacl2[each.key].id

  rule_number   = 100
  rule_action   = "allow"
  protocol      = "tcp"
  cidr_block    = "0.0.0.0/0"
  from_port     = 80
  to_port       = 80
  egress        = false
}

resource "aws_network_acl_rule" "public_egress2" {
  for_each = var.public_subnets

  network_acl_id = aws_network_acl.public_nacl2[each.key].id

  rule_number   = 100
  rule_action   = "allow"
  protocol      = "tcp"
  cidr_block    = "0.0.0.0/0"
  from_port     = 80
  to_port       = 80
  egress        = true
}

resource "aws_network_acl_rule" "private_ingress2" {
  for_each = var.private_subnets

  network_acl_id = aws_network_acl.private_nacl2[each.key].id

  rule_number   = 100
  rule_action   = "allow"
  protocol      = "tcp"
  cidr_block    = "0.0.0.0/0"
  from_port     = 443
  to_port       = 443
  egress        = false
}

resource "aws_network_acl_rule" "private_egress2" {
  for_each = var.private_subnets

  network_acl_id = aws_network_acl.private_nacl2[each.key].id

  rule_number   = 100
  rule_action   = "allow"
  protocol      = "tcp"
  cidr_block    = "0.0.0.0/0"
  from_port     = 443
  to_port       = 443
  egress        = true
}
resource "aws_security_group" "example_security_group" {
  name        = "terra_Security"
  description = " Security Groups for http,https and ssh"
  vpc_id      = aws_vpc.ranga_vpc2.id


  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Allow SSH access from anywhere
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Allow HTTP access from anywhere
  }
  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Allow HTTPs access from anywhere
  }
}

