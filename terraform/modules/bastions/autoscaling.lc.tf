resource "aws_launch_configuration" "bastion_lc" {
  name_prefix   = "${var.env}-Bastion-LC-"
  image_id      = "${lookup(var.amis, var.region)}"
  instance_type = "${var.instance_type}"
  user_data     = "${file("${path.module}/userdata/bastion.sh")}"
  key_name      = "${var.ssh_key_name}"
  associate_public_ip_address = true
  lifecycle {
    create_before_destroy = true
  }
  security_groups = [
    "${var.bastion_sg_id}",
  ]
}
