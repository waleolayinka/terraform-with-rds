# Create AWS VPC
resource "aws_vpc" "myrdsvpc" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"
  enable_dns_support =  "true"
  enable_dns_hostnames =  "true"
  enable_classiclink = "false"
  
  tags = {
    Name = "myrds_vpc"
  }
}

# Public subnets in Custom VPC
resource "aws_subnet" "myrdsvpc-public-1" {
  vpc_id = aws_vpc.myrdsvpc.id
  cidr_block = "10.0.1.0/24"
  map_public_ip_on_launch = "true"
  availability_zone = "us-east-1a"

  tags ={
    Name = "myrdsvpc-public-1"
  }
}

resource "aws_subnet" "myrdsvpc-public-2" {
  vpc_id = aws_vpc.myrdsvpc.id
  cidr_block = "10.0.2.0/24"
  map_public_ip_on_launch = "true"
  availability_zone = "us-east-1b"

  tags ={
    Name = "myrdsvpc-public-2"
  }
}

resource "aws_subnet" "myrdsvpc-public-3" {
  vpc_id = aws_vpc.myrdsvpc.id
  cidr_block = "10.0.3.0/24"
  map_public_ip_on_launch = "true"
  availability_zone = "us-east-1c"

  tags ={
    Name = "myrdsvpc-public-3"
  }
}

# Private subnets in Custom VPC
resource "aws_subnet" "myrdsvpc-private-1" {
  vpc_id = aws_vpc.myrdsvpc.id
  cidr_block = "10.0.4.0/24"
  map_public_ip_on_launch = "false"
  availability_zone = "us-east-1a"

  tags ={
    Name = "myrdsvpc-private-1"
  }
}

resource "aws_subnet" "myrdsvpc-private-2" {
  vpc_id = aws_vpc.myrdsvpc.id
  cidr_block = "10.0.5.0/24"
  map_public_ip_on_launch = "false"
  availability_zone = "us-east-1b"

  tags ={
    Name = "myrdsvpc-private-2"
  }
}

resource "aws_subnet" "myrdsvpc-private-3" {
  vpc_id = aws_vpc.myrdsvpc.id
  cidr_block = "10.0.6.0/24"
  map_public_ip_on_launch = "false"
  availability_zone = "us-east-1c"

  tags ={
    Name = "myrdsvpc-private-3"
  }
}

# Custom Internet Gateway
resource "aws_internet_gateway" "myrds-gw"{
vpc_id = aws_vpc.myrdsvpc.id

tags = {
    Name = "myrds-gw"
}
}

#Routing Table for the Custom VPC
resource "aws_route_table" "myrds-public" {
    vpc_id = aws_vpc.myrdsvpc.id
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.myrds-gw.id
    }

  tags = {
    Name = "myrdsvpc-public-1"
  }
}

resource "aws_route_table_association" "myrds-public-1-a" {
    subnet_id = aws_subnet.myrdsvpc-public-1.id
    route_table_id = aws_route_table.myrds-public.id 
}

resource "aws_route_table_association" "myrds-public-2-a" {
    subnet_id = aws_subnet.myrdsvpc-public-2.id
    route_table_id = aws_route_table.myrds-public.id 
}

resource "aws_route_table_association" "myrds-public-3-a" {
    subnet_id = aws_subnet.myrdsvpc-public-3.id
    route_table_id = aws_route_table.myrds-public.id 
}