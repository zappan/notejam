resource "aws_iam_policy" "toptaldevops_codedeploy_s3_read_access" {
  name        = "ToptalDevOpsCodeDeployAgentS3ReadAccessPolicy"
  description = "Access policy allowing EC2 instances CodeDeploy agent to fetch app code bundle from S3"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": "s3:Get*",
      "Resource": [
        "arn:aws:s3:::${var.codedeploy_bucket}",
        "arn:aws:s3:::${var.codedeploy_bucket}/*"
      ]
    },
    {
      "Effect": "Allow",
      "Action": "s3:List*",
      "Resource": [
        "arn:aws:s3:::${var.codedeploy_bucket}",
        "arn:aws:s3:::${var.codedeploy_bucket}/*"
      ]
    }
  ]
}
EOF
}
