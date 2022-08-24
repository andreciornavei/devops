resource "aws_db_subnet_group" "rds_subnet_group" {
  name       = "main_${var.tagname}_rds_subnet_group"
  subnet_ids = [aws_subnet.subnet_1a.id, aws_subnet.subnet_1b.id, aws_subnet.subnet_1c.id]
  tags = {
    Name = "Main DB subnet group for application"
  }
}

resource "aws_db_instance" "rds_instance" {
  identifier              = "${var.tagname}-database-rds"
  allocated_storage       = 20
  max_allocated_storage   = 100
  storage_type            = "gp2"
  engine                  = "mysql"
  engine_version          = "5.7"
  instance_class          = var.rds_instance_class
  db_name                 = "${var.tagname}_instance"
  username                = "${var.database_username}"
  password                = "${var.database_password}"
  parameter_group_name    = "default.mysql5.7"
  skip_final_snapshot     = true
  publicly_accessible     = false
  multi_az                = true
  vpc_security_group_ids  = [aws_security_group.securitygroup_database_rds.id]
  db_subnet_group_name    = aws_db_subnet_group.rds_subnet_group.name
}

resource "aws_ssm_parameter" "ssm_rds_instance_ssl" {
  name      = "appenv_db_ssl"
  type      = "String"
  value     = "true"
  overwrite = true
}

resource "aws_ssm_parameter" "ssm_rds_instance_host" {
  name      = "appenv_db_host"
  type      = "String"
  value     = aws_db_instance.rds_instance.address
  overwrite = true
}

resource "aws_ssm_parameter" "ssm_rds_instance_name" {
  name      = "appenv_db_name"
  type      = "String"
  value     = aws_db_instance.rds_instance.db_name
  overwrite = true
}

resource "aws_ssm_parameter" "ssm_rds_instance_username" {
  name      = "appenv_db_user"
  type      = "String"
  value     = aws_db_instance.rds_instance.username
  overwrite = true
}

resource "aws_ssm_parameter" "ssm_rds_instance_password" {
  name      = "appenv_db_pass"
  type      = "String"
  value     = aws_db_instance.rds_instance.password
  overwrite = true
}

resource "aws_ssm_parameter" "ssm_rds_instance_port" {
  name      = "appenv_db_port"
  type      = "String"
  value     = aws_db_instance.rds_instance.port
  overwrite = true
}
