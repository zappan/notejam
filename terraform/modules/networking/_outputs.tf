
output "bastion_sg_id" {
  value = "${aws_security_group.bastion_sg.id}"
}

output "webserver_sg_id" {
  value = "${aws_security_group.webserver_sg.id}"
}
