
output "bastion_subnet_ids" {
    value = ["${aws_subnet.bastion_subnets.*.id}"]
}

output "webserver_subnet_ids" {
    value = ["${aws_subnet.webserver_subnets.*.id}"]
}

output "bastion_sg_id" {
  value = "${aws_security_group.bastion_sg.id}"
}

output "webserver_sg_id" {
  value = "${aws_security_group.webserver_sg.id}"
}
