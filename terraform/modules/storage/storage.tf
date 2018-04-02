resource "aws_s3_bucket" "notejam_backup" {
  bucket = "topal.devops.notejam.backup"
  acl    = "private"

  tags {
    Name = "ToptalDevops.NotejamBackup"
    env  = "global"
  }
}
