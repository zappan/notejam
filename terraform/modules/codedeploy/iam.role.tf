resource "aws_iam_role" "codedeploy_service_role" {
  name        = "ToptalDevOpsCodeDeployServiceRole"
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

resource "aws_iam_role_policy_attachment" "codedeploy_service_role" {
  role       = "${aws_iam_role.codedeploy_service_role.name}"
  policy_arn = "${data.aws_iam_policy.aws_code_deploy_role.arn}"
}
