resource "aws_vpc" "myvpc" {
  cidr_block = "192.168.0.0/16"

  tags = {
    "Name" = "myvpc"
  }
}

resource "aws_internet_gateway" "myvpc-ig" {
  vpc_id = aws_vpc.myvpc.id

  tags = {
    "Name" = "myvpc-ig"
  }
}

resource "aws_subnet" "pub-sub01" {
  vpc_id = aws_vpc.myvpc.id
  cidr_block = "192.168.1.0/24"
  availability_zone = "us-east-1a"

  tags = {
    "Name" = "pub-sub01"
  }
}

resource "aws_subnet" "pub-sub02" {
  vpc_id = aws_vpc.myvpc.id
  cidr_block = "192.168.1.0/24"
  availability_zone = "us-east-1b"

  tags = {
    "Name" = "pub-sub02"
  }
}

resource "aws_subnet" "pri-sub01" {
  vpc_id = aws_vpc.myvpc.id
  cidr_block = "192.168.1.0/24"
  availability_zone = "us-east-1a"

  tags = {
    "Name" = "pri-sub01"
  }
}

resource "aws_subnet" "pri-sub02" {
  vpc_id = aws_vpc.myvpc.id
  cidr_block = "192.168.1.0/24"
  availability_zone = "us-east-1b"

  tags = {
    "Name" = "pri-sub02"
  }
}

resource "aws_route_table" "pubrt" {
    vpc_id = aws_vpc.myvpc.id
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.myvpc-ig.id
    }

    tags = {
        "Name" = "pub-rt"
    }
}

# resource "aws_route_table" "prirt" {
#     vpc_id = aws_vpc.myvpc.id
#     route {
#         cidr_block = "0.0.0.0/0"
#         nat_gateway_id = aws_internet_gateway.myvpc-ng.id
#     }

#     tags = {
#         "Name" = "pri-rt"
#     }
# }

resource "aws_route_table_association" "pubsb01" {
    route_table_id = aws_route_table.pubrt.id
    subnet_id = aws_subnet.pub-sub01.id
  
}

resource "aws_route_table_association" "pubsb02" {
    route_table_id = aws_route_table.pubrt.id
    subnet_id = aws_subnet.pub-sub02.id
  
}
