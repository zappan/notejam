resource "aws_iam_user" "toptaldevops_codedeploy" {
  name = "ToptalDevOpsCodeDeploy"
}

resource "aws_iam_user_policy_attachment" "toptaldevops_codedeploy_aws_code_deploy_full_access" {
  user       = "${aws_iam_user.toptaldevops_codedeploy.name}"
  policy_arn = "${data.aws_iam_policy.aws_code_deploy_full_access.arn}"
}

resource "aws_iam_user_policy_attachment" "toptaldevops_codedeploy_s3_codedeploy_bucket_full_access" {
  user       = "${aws_iam_user.toptaldevops_codedeploy.name}"
  policy_arn = "${aws_iam_policy.s3_codedeploy_bucket_full_access.arn}"
}
