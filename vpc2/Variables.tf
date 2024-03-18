variable "private_subnets" {
  type = map(object({
    cidr_block        = string
    availability_zone = string
  }))
  default = {
    subnet1 = {
      cidr_block        = "10.0.1.64/28"
      availability_zone = "us-east-2a"
    }
    subnet2 = {
      cidr_block        = "10.0.1.80/28"
      availability_zone = "us-east-2b"
    }
  }
}
# subnet configurations
variable "public_subnets" {
  type = map(object({
    cidr_block        = string
    availability_zone = string
  }))
  default = {
    subnet1 = {
      cidr_block        = "10.0.1.0/28"
      availability_zone = "us-east-2a"
    }
    subnet2 = {
      cidr_block        = "10.0.1.16/28"
      availability_zone = "us-east-2b"
    }
  }
}
variable "vpc_name2" {
    default = "ranga-vpc2"
  
}

