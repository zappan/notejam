resource "aws_iam_role" "toptaldevops_codedeploy" {
  name        = "ToptalDevOpsCodeDeployRole"
  description = "A service role used by the AWS CodeDeploy service to orchestrate the deployment."

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "",
      "Effect": "Allow",
      "Principal": {
        "Service": "codedeploy.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "toptaldevops_codedeploy" {
  role       = "${aws_iam_role.toptaldevops_codedeploy.name}"
  policy_arn = "${aws_iam_policy.toptaldevops_codedeploy.arn}"
}
