resource "aws_autoscaling_group" "webserver_asg" {
  name                 = "${var.env}-WebServers-ASG"
  min_size             = "${var.asg_min}"
  max_size             = "${var.asg_max}"
  desired_capacity     = "${var.asg_desired}"
  vpc_zone_identifier  = ["${var.webserver_subnet_ids}"]
  launch_configuration = "${aws_launch_configuration.webserver_lc.id}"
  default_cooldown     = 30
  tag {
    key                 = "Name"
    value               = "${var.env}-WebServer"
    propagate_at_launch = "true"
  }
  tag {
    key                 = "env"
    value               = "${var.env}"
    propagate_at_launch = "true"
  }
}

resource "aws_autoscaling_policy" "avg_cpu" {
  name                      = "${aws_autoscaling_group.webserver_asg.name}-AvgCPU-ASP"
  autoscaling_group_name    = "${aws_autoscaling_group.webserver_asg.name}"
  policy_type               = "TargetTrackingScaling"
  estimated_instance_warmup = 600
  target_tracking_configuration {
    predefined_metric_specification { predefined_metric_type = "ASGAverageCPUUtilization" }
    target_value = 70.0
  }
}
