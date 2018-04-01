resource "aws_s3_bucket" "codedeploy_bucket" {
  bucket = "toptal.devops.codedeploy"
  acl    = "private"

  tags {
    Name = "ToptalDevops.CodeDeploy"
    env  = "global"
  }
}
