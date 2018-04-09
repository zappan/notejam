resource "aws_efs_file_system" "notejam_efs" {
  creation_token = "${var.env}-notejam-efs"

  tags {
    Name = "${var.env}-notejam-efs"
  }
}

resource "aws_efs_mount_target" "notejam_efs" {
  count           = "${length("${var.webserver_subnet_ids}")}"

  file_system_id  = "${aws_efs_file_system.notejam_efs.id}"
  subnet_id       = "${element("${var.webserver_subnet_ids}", count.index)}"
  security_groups = ["${var.efs_sg_id}"]
}
