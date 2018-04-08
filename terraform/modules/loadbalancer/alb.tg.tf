resource "aws_alb_target_group" "app_alb_tg" {
  name     = "${var.app_name}-${var.env}-ALB-TG"
  protocol = "HTTP"
  port     = 80
  vpc_id   = "${var.alb_vpc_id}"

  health_check {
    port                = "traffic-port"
    protocol            = "HTTP"
    path                = "/"
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 2
    matcher             = "200"
  }
}

# Create a new ASG <=> ALB-TG attachment
resource "aws_autoscaling_attachment" "app_alb_webserver_asg" {
  autoscaling_group_name = "${var.alb_servers_asg_id}"
  alb_target_group_arn   = "${aws_alb_target_group.app_alb_tg.arn}"
}
