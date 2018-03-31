resource "aws_autoscaling_group" "bastion_asg" {
  name                 = "${var.env}-Bastions-ASG"
  min_size             = "${var.asg_min}"
  max_size             = "${var.asg_max}"
  desired_capacity     = "${var.asg_desired}"
  vpc_zone_identifier  = ["${var.asg_subnet_ids}"]
  launch_configuration = "${aws_launch_configuration.bastion_lc.id}"
  default_cooldown     = 30
  tag {
    key                 = "Name"
    value               = "${var.env}-Bastion"
    propagate_at_launch = "true"
  }
  tag {
    key                 = "env"
    value               = "${var.env}"
    propagate_at_launch = "true"
  }
}
