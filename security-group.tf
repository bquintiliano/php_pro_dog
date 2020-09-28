resource "aws_security_group" "acesso-php" {
  name        = "acesso-http"
  description = "acesso-http"
  vpc_id = aws_vpc.vpc-php.id

  ingress {
    description = "acesso-http2"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
    ingress {
    description = "acesso-ssh2"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  
  egress {
    description = "acesso-internet"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  
  tags = {
    Name = "acesso-php"
  }
}

resource "aws_security_group" "acesso-dbphp" {
  name        = "acesso-dbphp"
  description = "acesso-dbphp"
  vpc_id = aws_vpc.vpc-php.id

  ingress {
    description = "acesso-dbphp"
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["172.40.0.0/24"]
  }

}