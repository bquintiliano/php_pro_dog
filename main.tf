provider "aws" {
  region = "us-east-2"
}

resource "aws_instance" "php-web" {
  ami           = "ami-07efac79022b86107"
  instance_type = "t2.micro"
  key_name = "aws-local-pub"
  subnet_id = aws_subnet.subnet-php1.id
  tags = {
    Name = "PHP"
  }
  vpc_security_group_ids = ["${aws_security_group.acesso-php.id}"]

}