output "notejam_backup_bucket" {
  value = "${aws_s3_bucket.notejam_backup.bucket}"
}
