data "template_file" "user_data" {
  template = "${file("${path.module}/userdata/webserver.sh.tpl")}"

  vars {
    datadog_api_key = "${var.datadog_api_key}"
    efs_dns_name    = "${aws_efs_file_system.notejam_efs.dns_name}"
  }
}

resource "aws_launch_configuration" "webserver_lc" {
  name_prefix          = "${var.env}-WebServer-LC-"
  image_id             = "${lookup(var.amis, var.region)}"
  instance_type        = "${var.instance_type}"
  iam_instance_profile = "${var.webserver_iam_profile}"
  user_data            = "${data.template_file.user_data.rendered}"
  key_name             = "${var.ssh_key_name}"
  associate_public_ip_address = true
  lifecycle {
    create_before_destroy = true
  }
  security_groups = [
    "${var.webserver_sg_id}",
  ]
}
