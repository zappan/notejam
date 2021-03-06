
output "vpc_id" {
  value = "${aws_vpc.vpc.id}"
}

output "bastion_subnet_ids" {
    value = ["${aws_subnet.bastion_subnets.*.id}"]
}

output "webserver_subnet_ids" {
    value = ["${aws_subnet.webserver_subnets.*.id}"]
}

output "alb_sg_id" {
  value = "${aws_security_group.alb_sg.id}"
}

output "efs_sg_id" {
  value = "${aws_security_group.efs_sg.id}"
}

output "bastion_sg_id" {
  value = "${aws_security_group.bastion_sg.id}"
}

output "webserver_sg_id" {
  value = "${aws_security_group.webserver_sg.id}"
}

output "rds_sg_id" {
  value = "${aws_security_group.rds_sg.id}"
}
