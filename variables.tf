variable "instance_type" {
    description = "This is for instance type"
    default     = "t3.small"
    #default     = "t3.micro"
}

variable "ami" {
    description = "This is for instance type"
    default     = "ami-006b300825259765d"
}

variable "instance_name" {
    description = "This is for instance type"
    default     = "mpesa_vm"
}


#VPC Variables

variable "vpc_cidr" {
    default = "20.0.0.0/16"  
  }

variable "vpc_name" {
    default = "mpesa_vpc"
  }

variable "subnet_cidrs" {
  type    = list(string)
  default = ["20.0.1.0/24", "20.0.2.0/24", "20.0.3.0/24"]
}



