# Creating VPC 

resource "aws_vpc" "ranga_vpc1" {
  cidr_block = "10.0.0.0/25"
  tags = {
    Name = var.vpc_name
  }
}


# Creating Public Subnets
resource "aws_subnet" "public1" {
  for_each = var.public_subnets1

  vpc_id                  = aws_vpc.ranga_vpc1.id
  cidr_block              = each.value.cidr_block
  availability_zone       = each.value.availability_zone
  map_public_ip_on_launch = true
}


# Creating Private Subnets
resource "aws_subnet" "private1" {
  for_each = var.private_subnets1

  vpc_id                  = aws_vpc.ranga_vpc1.id
  cidr_block              = each.value.cidr_block
  availability_zone       = each.value.availability_zone
}


# Creating Internet_GateWay
resource "aws_internet_gateway" "internet_example1" {
  vpc_id = aws_vpc.ranga_vpc1.id
  tags = {
    Name = "example-internet-gateway1"
  }
}


# Ceating Elastic Ip for NAT Gateway
resource "aws_eip" "eip_example1" {
  for_each = var.private_subnets1
}

# Creating Nat_Gateway
resource "aws_nat_gateway" "nat_example1" {

  allocation_id = aws_eip.eip_example1["subnet1"].id
  subnet_id     = aws_subnet.private1["subnet1"].id

  tags = {
    Name = "example-nat-gateway1"
  }
}


# Creating Route Table for Public Subnets
resource "aws_route_table" "private1" {
  vpc_id = aws_vpc.ranga_vpc1.id
}

# Creating Route Table For Private Subnets
resource "aws_route_table" "public1" {
  vpc_id = aws_vpc.ranga_vpc1.id
}


# Creating Route Table association For Public Subnets
resource "aws_route_table_association" "public1" {
  for_each = aws_subnet.public1

  subnet_id      = each.value.id
  route_table_id = aws_route_table.public1.id
}
# resource "aws_route" "destination_route" {
#   route_table_id         = var.routing
#   destination_cidr_block = ""  # Replace with the desired CIDR block
#   gateway_id             = var.gateway_id  # Replace with the desired target (e.g., an Internet Gateway or VPC Peering Connection)
# }
# resource "aws_route_table_association" "route_2_vpc" {
#   subnet_id = var.subnet_vpc2
#   route_table_id = var.routing

  
# }
# Creating Route Table association For Private Subnets
resource "aws_route_table_association" "private1" {
  for_each = aws_subnet.private1

  subnet_id      = each.value.id
  route_table_id = aws_route_table.private1.id
}

# Estblishing Route  For Public Subnets
resource "aws_route" "public1" {
  route_table_id         = aws_route_table.public1.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.internet_example1.id
}

# Estblishing Route  For Private Subnet1 using nat Gateway based on Route Table
resource "aws_route" "private1" {

  route_table_id         = aws_route_table.private1.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.nat_example1.id
  depends_on = [aws_route_table.private1]
}




# Creating NACLs for Public and private
resource "aws_network_acl" "public_nacl1" {
  for_each = var.public_subnets1

  vpc_id = aws_vpc.ranga_vpc1.id
}

resource "aws_network_acl" "private_nacl1" {
  for_each = var.private_subnets1

  vpc_id = aws_vpc.ranga_vpc1.id
}

#  ingress and egress rules for public and private NACLs
resource "aws_network_acl_rule" "public_ingress1" {
  for_each = var.public_subnets1

  network_acl_id = aws_network_acl.public_nacl1[each.key].id

  rule_number   = 100
  rule_action   = "allow"
  protocol      = "tcp"
  cidr_block    = "0.0.0.0/0"
  from_port     = 80
  to_port       = 80
  egress        = false
}

resource "aws_network_acl_rule" "public_egress1" {
  for_each = var.public_subnets1

  network_acl_id = aws_network_acl.public_nacl1[each.key].id

  rule_number   = 100
  rule_action   = "allow"
  protocol      = "tcp"
  cidr_block    = "0.0.0.0/0"
  from_port     = 80
  to_port       = 80
  egress        = true
}

resource "aws_network_acl_rule" "private_ingress1" {
  for_each = var.private_subnets1

  network_acl_id = aws_network_acl.private_nacl1[each.key].id

  rule_number   = 100
  rule_action   = "allow"
  protocol      = "tcp"
  cidr_block    = "0.0.0.0/0"
  from_port     = 443
  to_port       = 443
  egress        = false
}

resource "aws_network_acl_rule" "private_egress1" {
  for_each = var.private_subnets1

  network_acl_id = aws_network_acl.private_nacl1[each.key].id

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
  vpc_id      = aws_vpc.ranga_vpc1.id


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


