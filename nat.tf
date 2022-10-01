#Define External IP
resource "aws_eip" "myrds-nat" {
    vpc = true
}

resource "aws_nat_gateway" "myrds-nat-gw"{
    allocation_id = aws_eip.myrds-nat.id
    subnet_id = aws_subnet.myrdsvpc-public-1.id
    depends_on = [aws_internet_gateway.myrds-gw]
}

resource "aws_route_table" "myrds-private" {
    vpc_id = aws_vpc.myrdsvpc.id
    route {
        cidr_block = "0.0.0.0/0"
        nat_gateway_id = aws_nat_gateway.myrds-nat-gw.id
    }

    tags = {
        Name = "myrds-private"
    }
}

# route table association private
resource "aws_route_table_association" "myrds-private-1-a" {
    subnet_id = aws_subnet.myrdsvpc-private-1.id
    route_table_id = aws_route_table.myrds-private.id 
}

resource "aws_route_table_association" "myrds-private-2-a" {
    subnet_id = aws_subnet.myrdsvpc-private-2.id
    route_table_id = aws_route_table.myrds-private.id 
}

resource "aws_route_table_association" "myrds-private-3-a" {
    subnet_id = aws_subnet.myrdsvpc-private-3.id
    route_table_id = aws_route_table.myrds-private.id 
}