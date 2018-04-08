output "codedeploy_role_arn" {
  value = "${module.codedeploy.codedeploy_role_arn}"
}

output "webserver_iam_profile" {
  value = "${module.iam_webserver.webserver_iam_profile}"
}
