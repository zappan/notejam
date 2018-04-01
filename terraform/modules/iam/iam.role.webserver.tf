resource "aws_iam_instance_profile" "webserver" {
    name = "ToptalDevOpsWebServerProfile"
    role = "${aws_iam_role.webserver.name}"
}

resource "aws_iam_role_policy_attachment" "webserver" {
  role       = "${aws_iam_role.webserver.name}"
  policy_arn = "${var.codedeploy_policy_arn}"
}

resource "aws_iam_role" "webserver" {
  name = "ToptalDevOpsWebServerRole"
  description = "Web Server EC2 role allowing use of S3 for CodeDeploy and other required resources"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "",
      "Effect": "Allow",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}
