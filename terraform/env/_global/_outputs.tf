output "app_name" {
  value = "${module.codedeploy.app_name}"
}

output "codedeploy_role_arn" {
  value = "${module.codedeploy.codedeploy_role_arn}"
}

output "webserver_iam_profile" {
  value = "${module.iam.webserver_iam_profile}"
}
