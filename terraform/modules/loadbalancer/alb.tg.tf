resource "aws_alb_target_group" "app_alb_tg" {
  name     = "${var.app_name}-${var.env}-ALB-TG"
  protocol = "HTTP"
  port     = 80
  vpc_id   = "${var.alb_vpc_id}"

  health_check {
    port                = "traffic-port"
    protocol            = "HTTP"
    path                = "/health-check"
    timeout             = 2
    healthy_threshold   = 2
    unhealthy_threshold = 2
    interval            = 5
    matcher             = "204"
  }
}

# Create a new ASG <=> ALB-TG attachment
resource "aws_autoscaling_attachment" "app_alb_webserver_asg" {
  autoscaling_group_name = "${var.alb_servers_asg_id}"
  alb_target_group_arn   = "${aws_alb_target_group.app_alb_tg.arn}"
}
