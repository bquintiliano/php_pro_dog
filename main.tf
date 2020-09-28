provider "aws" {
  region = "us-east-2"
}

resource "aws_instance" "php-web" {
  ami           = "ami-03657b56516ab7912"
  instance_type = "t2.micro"
  key_name = "aws-local-pub"
  subnet_id = aws_subnet.subnet-php1.id
  tags = {
    Name = "PHP"
  }
  vpc_security_group_ids = ["${aws_security_group.acesso-php.id}"]

user_data = <<EOF
        #!/bin/bash
        yum update && yum install -y httpd php php-mysql
        cd /tmp
        wget https://wordpress.org/wordpress-5.1.1.tar.gz
        tar xzvf /tmp/wordpress-5.1.1.tar.gz --strip 1 -C /var/www/html
        rm /tmp/latest.tar.gz -Rf
        chown -R apache:apache /var/www/html
        systemctl enable httpd
        systemctl start httpd
        EOF

}