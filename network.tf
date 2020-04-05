provider "aws" {
  region     = "eu-west-2"
  # access_key = "${AWS_ACCESS_KEY}"
  # secret_key = "${AWS_SECRET_KEY}"
}

resource "aws_vpc" "main" {
  cidr_block = "192.168.0.0/16"
}
resource "aws_internet_gateway" "main" {
    vpc_id = "${aws_vpc.main.id}"
}
resource "aws_subnet" "public-subnet-1" {
  vpc_id     = "${aws_vpc.main.id}"
  cidr_block = "192.168.0.0/18"
  availability_zone = "eu-west-2a"
  map_public_ip_on_launch = true

  tags = {
    Name = "public-subnet-1"
  }
}

resource "aws_subnet" "public-subnet-2" {
  vpc_id     = "${aws_vpc.main.id}"
  cidr_block = "192.168.64.0/18"
  availability_zone = "eu-west-2b"
  map_public_ip_on_launch = true

  tags = {
    Name = "public-subnet-2"
  }
}

resource "aws_subnet" "private-subnet-1" {
  vpc_id     = "${aws_vpc.main.id}"
  cidr_block = "192.168.128.0/18"
  availability_zone = "eu-west-2a"

  tags = {
    Name = "private-subnet-1"
  }
}

resource "aws_subnet" "private-subnet-2" {
  vpc_id     = "${aws_vpc.main.id}"
  cidr_block = "192.168.192.0/18"
  availability_zone = "eu-west-2b"

  tags = {
    Name = "private-subnet-2"
  }
}

resource "aws_route_table" "public-routetable" {
  vpc_id = "${aws_vpc.main.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.main.id}"
  }
}

resource "aws_route_table_association" "a" {
  subnet_id      = "${aws_subnet.public-subnet-1.id}"
  route_table_id = "${aws_route_table.public-routetable.id}"
}

resource "aws_route_table_association" "b" {
  subnet_id      = "${aws_subnet.public-subnet-2.id}"
  route_table_id = "${aws_route_table.public-routetable.id}"
}


resource "aws_route_table" "private-routetable" {
  vpc_id = "${aws_vpc.main.id}"
}

resource "aws_route_table_association" "ap" {
  subnet_id      = "${aws_subnet.private-subnet-1.id}"
  route_table_id = "${aws_route_table.private-routetable.id}"
}

resource "aws_route_table_association" "bp" {
  subnet_id      = "${aws_subnet.private-subnet-2.id}"
  route_table_id = "${aws_route_table.private-routetable.id}"
}