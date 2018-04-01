resource "aws_codedeploy_app" "app" {
  name = "${var.app_name}"
}
