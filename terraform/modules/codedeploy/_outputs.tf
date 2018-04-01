output "app_name" {
  value = "${aws_codedeploy_app.app.name}"
}

output "codedeploy_role_arn" {
  value = "${aws_iam_role.toptaldevops_codedeploy.arn}"
}

output "codedeploy_policy_arn" {
  value = "${aws_iam_policy.toptaldevops_codedeploy.arn}"
}
