resource "aws_db_instance" "default" {
  identifier              = "${var.env}-notejam-mysql"
  allocated_storage       = 10
  storage_type            = "gp2"
  engine                  = "mysql"
  engine_version          = "5.7"
  instance_class          = "db.t2.micro"
  name                    = "notejam"
  username                = "notejamadmin"
  password                = "supersecurepassword"
  parameter_group_name    = "default.mysql5.7"
  backup_retention_period = 7
  backup_window           = "00:00-03:00"
  maintenance_window      = "Mon:03:30-Mon:04:30"
  publicly_accessible     = false
  multi_az                = false
  db_subnet_group_name    = "${aws_db_subnet_group.default_sng.name}"
  vpc_security_group_ids  = ["${var.rds_sg_id}"]
}
