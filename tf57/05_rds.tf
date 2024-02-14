resource "aws_db_subnet_group" "demo_db_subnet_group" {
  name       = "tf-rds-subnet-group"
  subnet_ids = [aws_subnet.demo_subnet1.id, aws_subnet.demo_subnet2.id]
  tags = {
    Name = "tf-rds-subnet-group"
  }
}

resource "aws_db_instance" "demo_database" {
  engine                 = "mysql"
  identifier             = "tf-rds-mysql"
  username               = var.db_username
  password               = var.db_password
  instance_class         = "db.t3.micro"
  allocated_storage      = 10
  db_subnet_group_name   = aws_db_subnet_group.demo_db_subnet_group.id
  vpc_security_group_ids = [aws_security_group.demo_sg.id]
  skip_final_snapshot    = true
  availability_zone      = data.aws_availability_zones.available.names[0]
  db_name                = var.initial_db_name
}