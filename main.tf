provider "aws" {
  alias      = "peer"
  region     = var.aws_region
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
}

module "vpc1" {
  source   = "./VPC-1"
  vpc_name = "ranga_vpc1"
  # routing = module.vpc2.routing_table
  subnet_vpc2 = module.vpc2.subnet_id1
  # gateway_id = aws_vpc_peering_connection.peering.id

}
module "vpc2" {
  source     = "./VPC-2"
  vpc_name2  = "ranga_vpc2"
}
module "ec2" {
  source = "./EC2"
  ec2-subnet = module.vpc1.subnet_ec2
  ec2-subnet2 = module.vpc2.subnet_id1
  security_group1 = module.vpc1.security-1
  security_group2 = module.vpc2.security-2
  
  # security_group2 = module.vpc2.security2
  # vpc_id = module.ranga_vpc1.ec2_instance_id
  # public_subnet_ids  = module.ranga_vpc1.public1
  # private_subnet_ids = module.ranga_vpc1.private1
}
module "RDS" {
  source     = "./RDS"
}

resource "aws_vpc_peering_connection" "peering" {
  peer_vpc_id = module.vpc1.vpc_id
  vpc_id      = module.vpc2.vpc_id
  peer_region = "us-east-2"
  # auto_accept          = true
  tags = {
    Name = "VPC-Peering-Connection"
  }
}
resource "aws_vpc_peering_connection_accepter" "peer" {
  provider                  = aws.peer
  vpc_peering_connection_id = aws_vpc_peering_connection.peering.id
  auto_accept               = true

  tags = {
    Side = "Accepter"
  }
}