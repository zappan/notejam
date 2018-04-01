resource "aws_codedeploy_deployment_group" "app_dg" {
  app_name               = "${var.deployment_app_name}"
  deployment_group_name  = "${var.deployment_app_name}-deploy-${var.env}"
  deployment_config_name = "${var.deployment_config_name}"
  service_role_arn       = "${var.deployment_service_role_arn}"

  deployment_style {
    deployment_option = "${var.deployment_option}"
    deployment_type   = "${var.deployment_type}"
  }

  # load_balancer_info {
  # }

  # ec2_tag_filter {
  #   key   = "filterkey"
  #   type  = "KEY_AND_VALUE"
  #   value = "filtervalue"
  # }

  autoscaling_groups     = ["${aws_autoscaling_group.webserver_asg.name}"]

  auto_rollback_configuration {
    enabled = true
    events  = ["DEPLOYMENT_FAILURE"]
  }

  # trigger_configuration {
  #   trigger_events     = ["DeploymentFailure"]
  #   trigger_name       = "notejam-trigger"
  #   trigger_target_arn = "${aws_sns_topic.notejam.arn}"
  # }

  # alarm_configuration {
  #   alarms  = ["my-alarm-name"]
  #   enabled = true
  # }
}
