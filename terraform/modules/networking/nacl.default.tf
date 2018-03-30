###############################################################################
## DISABLING THIS CONFIG
## There is a bug in tracking subnets, it tries to remove all subnets on each
## config apply, which does not happen in practice. Default NACL rules (all
## in/out traffic allowed) are used anyway, so we can live without this one.
###############################################################################

# # Default NACL - tagging
# resource "aws_default_network_acl" "default_nacl" {
#   default_network_acl_id = "${aws_vpc.vpc.default_network_acl_id}"
#   ingress {
#     protocol   = -1
#     rule_no    = 100
#     action     = "allow"
#     cidr_block = "0.0.0.0/0"
#     from_port  = 0
#     to_port    = 0
#   }
#   egress {
#     protocol   = -1
#     rule_no    = 100
#     action     = "allow"
#     cidr_block = "0.0.0.0/0"
#     from_port  = 0
#     to_port    = 0
#   }
#   tags {
#     Name = "${var.env}-Default-NACL"
#     env  = "${var.env}"
#   }
# }
