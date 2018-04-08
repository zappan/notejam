# Create a new application load balancer
resource "aws_alb" "app_alb" {
  name            = "${var.app_name}-${var.env}-ALB"
  internal        = false
  security_groups = ["${var.alb_sg_id}"]
  subnets         = ["${var.alb_subnet_ids}"]

  enable_deletion_protection = false

  # access_logs {
  #   bucket  = "${aws_s3_bucket.alb_logs.bucket}"
  #   prefix  = "${var.app_name}-alb"
  #   enabled = false
  # }

  tags {
    env = "${var.env}"
  }
}

resource "aws_alb_listener" "app_alb_http_listener" {
  load_balancer_arn = "${aws_alb.app_alb.arn}"
  port              = "80"
  protocol          = "HTTP"

  default_action {
    target_group_arn = "${aws_alb_target_group.app_alb_tg.arn}"
    type             = "forward"
  }
}

# ### HTTPS listener requires a SSL cert, which requires a domain, which
# ### requires a hosted zone setup in Route 53, which incurs cost. Skipped.
# ------------------------------------------------------------------------
# resource "aws_alb_listener" "app_alb_https_listener" {
#   load_balancer_arn = "${aws_alb.app_alb.arn}"
#   port              = "443"
#   protocol          = "HTTPS"
#   ssl_policy        = "ELBSecurityPolicy-2016-08"
#   certificate_arn   = "${var.ssl_cert_arn}"  ## "arn:aws:iam::187416307283:server-certificate/test_cert_rab3wuqwgja25ct3n4jdj2tzu4"

#   default_action {
#     target_group_arn = "${aws_alb_target_group.app_alb_tg.arn}"
#     type             = "forward"
#   }
# }
