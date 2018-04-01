output "app_name" {
  value = "${aws_codedeploy_app.app.name}"
}

output "codedeploy_bucket" {
  value = "${aws_s3_bucket.codedeploy_bucket.bucket}"
}

output "codedeploy_role_arn" {
  value = "${aws_iam_role.codedeploy_service_role.arn}"
}
