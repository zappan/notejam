resource "aws_db_subnet_group" "default_sng" {
  name       = "${var.env}-default-rds-sng"
  subnet_ids = ["${var.rds_subnetgroup_ids}"]

  tags {
    Name = "Default DB subnet group"
  }
}
