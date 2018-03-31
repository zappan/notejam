resource "aws_launch_configuration" "webserver_lc" {
  name_prefix   = "${var.env}-WebServer-LC-"
  image_id      = "${lookup(var.amis, var.region)}"
  instance_type = "${var.instance_type}"
  user_data     = "${file("${path.module}/userdata/webserver.sh")}"
  key_name      = "${var.ssh_key_name}"
  associate_public_ip_address = true
  lifecycle {
    create_before_destroy = true
  }
  security_groups = [
    "${var.webserver_sg_id}",
  ]
}
