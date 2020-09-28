resource "aws_vpc" "vpc-php" {
  cidr_block = "172.40.0.0/24"
  
}

resource "aws_subnet" "subnet-php1" {
  vpc_id     = aws_vpc.vpc-php.id
  cidr_block = "172.40.0.0/24"
  map_public_ip_on_launch = true
  availability_zone = "us-east-2b"
  depends_on = [aws_vpc.vpc-php] 
}

resource "aws_vpc_ipv4_cidr_block_association" "secondary_cidr" {
  vpc_id     = aws_vpc.vpc-php.id
  cidr_block = "172.41.0.0/24"
}

resource "aws_subnet" "subnet-php2" {
  vpc_id     = aws_vpc_ipv4_cidr_block_association.secondary_cidr.vpc_id
  cidr_block = "172.41.0.0/24"
  map_public_ip_on_launch = true
  availability_zone = "us-east-2c"
}

resource "aws_internet_gateway" "gw-php" {
  vpc_id = aws_vpc.vpc-php.id

  tags = {
    Name = "gw-php"
  }
  depends_on = [aws_vpc.vpc-php] 
}



resource "aws_route_table" "route-php" {
  vpc_id = aws_vpc.vpc-php.id

   route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw-php.id
  }
    depends_on = [aws_internet_gateway.gw-php] 
} 

resource "aws_main_route_table_association" "default-route" {
  vpc_id         = aws_vpc.vpc-php.id
  route_table_id = aws_route_table.route-php.id
}