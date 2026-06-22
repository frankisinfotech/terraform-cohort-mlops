#VPC
resource "aws_vpc" "mpesa_vpc" {
  cidr_block       = var.vpc_cidr
  instance_tenancy = "default"

  tags = {
    Name = var.vpc_name
  }
}

#SUBNET

#resource "aws_subnet" "mpesa_sub" {
#  vpc_id     = aws_vpc.mpesa_vpc.id
#  cidr_block = "20.0.1.0/24"

#  map_public_ip_on_launch = true 

#  tags = {
#    Name = "mpesa_sub"
#  }
#}

resource "aws_subnet" "public" {
  count             = length(var.subnet_cidrs) # Creates 3 subnets
  vpc_id            = aws_vpc.mpesa_vpc.id
  cidr_block        = var.subnet_cidrs[count.index]
  #availability_zone = data.aws_availability_zones.available.names[count.index]

  map_public_ip_on_launch = true

  tags = {
    Name = "mpesa-subnet-${count.index}"
  }
}

#ROUTE-TABLE

resource "aws_route_table" "mpesa_rt" {
  vpc_id = aws_vpc.mpesa_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.mpesa_igw.id
  }


  tags = {
    Name = "mpesa_rt"
  }
}

#IGW

resource "aws_internet_gateway" "mpesa_igw" {
  vpc_id = aws_vpc.mpesa_vpc.id

  tags = {
    Name = "mpesa_igw"
  }
}

#ROUTE-TABLE-ASSOCIATION
resource "aws_route_table_association" "mpesa_rta" {
  count           = 3
  #subnet_id      = aws_subnet.mpesa_sub.id
  subnet_id       = aws_subnet.public[count.index % length(aws_subnet.public)].id
  route_table_id  = aws_route_table.mpesa_rt.id
}
