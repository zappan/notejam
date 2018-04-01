resource "aws_iam_user" "toptaldevops_codedeploy" {
  name = "ToptalDevOpsCodeDeploy"
}

resource "aws_iam_user_policy_attachment" "toptaldevops_codedeploy" {
  user       = "${aws_iam_user.toptaldevops_codedeploy.name}"
  policy_arn = "${aws_iam_policy.toptaldevops_codedeploy.arn}"
}
