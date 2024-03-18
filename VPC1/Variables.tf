variable "private_subnets1" {
  type = map(object({
    cidr_block        = string
    availability_zone = string
  }))
  default = {
    subnet1 = {
      cidr_block        = "10.0.0.64/28"
      availability_zone = "us-east-2a"
    }
    subnet2 = {
      cidr_block        = "10.0.0.80/28"
      availability_zone = "us-east-2b"
    }
  }
}
# subnet configurations
variable "public_subnets1" {
  type = map(object({
    cidr_block        = string
    availability_zone = string
  }))
  default = {
    subnet1 = {
      cidr_block        = "10.0.0.0/28"
      availability_zone = "us-east-2a"
    }
    subnet2 = {
      cidr_block        = "10.0.0.16/28"
      availability_zone = "us-east-2b"
    }
  }
}
variable "vpc_name" {
    type = string
  default = "ranga_vpc1"
}
# variable "routing" {
#   type = string
#   default = "ranga_routing"
  
# }
variable "subnet_vpc2" {
  type = string
  default = "subnet_2vpc"
}
variable "gateway_id" {
  type = string
  default = "gatway_id"
  
}