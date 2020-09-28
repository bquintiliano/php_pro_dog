resource "aws_db_instance" "DB-PHP" {
  allocated_storage    = 20
  storage_type         = "gp2"
  engine               = "mysql"
  engine_version       = "5.7"
  instance_class       = "db.t2.micro"
  name                 = "dbphp"
  username             = "php"
  password             = "password"
  parameter_group_name = "default.mysql5.7"
  skip_final_snapshot =  "true"
  db_subnet_group_name = "${aws_db_subnet_group.subnetdb.id}"
  vpc_security_group_ids = ["${aws_security_group.acesso-dbphp.id}"]
  depends_on = [aws_db_subnet_group.subnetdb]
}

resource "aws_db_subnet_group" "subnetdb" {
  name       = "subnetdb"
  subnet_ids = [aws_subnet.subnet-php1.id,aws_subnet.subnet-php2.id]

  tags = {
    Name = "My DB subnet group"
  }
  depends_on = [aws_route_table.route-php] 
}