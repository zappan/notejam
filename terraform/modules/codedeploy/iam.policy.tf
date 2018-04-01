data "aws_iam_policy" "aws_code_deploy_role" {
  arn = "arn:aws:iam::aws:policy/service-role/AWSCodeDeployRole"
}

data "aws_iam_policy" "aws_code_deploy_full_access" {
  arn = "arn:aws:iam::aws:policy/AWSCodeDeployFullAccess"
}

resource "aws_iam_policy" "s3_codedeploy_bucket_full_access" {
  name        = "ToptalDevOpsS3CodeDeployBucketFullAccessPolicy"
  description = "Access policy allowing CodeDeploy CI user full access to CodeDeploy S3 bucket"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": "s3:*",
      "Resource": [
        "arn:aws:s3:::${aws_s3_bucket.codedeploy_bucket.bucket}",
        "arn:aws:s3:::${aws_s3_bucket.codedeploy_bucket.bucket}/*"
      ]
    }
  ]
}
EOF
}
