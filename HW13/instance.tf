resource "aws_instance" "sz-dev-t" {
    ami           = "${var.AMI_ID}"
    instance_type = "${var.INSTANCE_TYPE}"
    key_name = "${var.KEY_NAME}"
    subnet_id = "${aws_subnet.sz-public.id}"
    vpc_security_group_ids = ["${aws_security_group.sz-dev-t-sg.id}"]

    tags = {
        Name = "sz-dev-t-env"
    }
}

output "instance_id"{
    value = aws_instance.sz-dev-t.id
}

variable "security_group_id" {}

data "aws_security_group" "selected" {
  id = var.security_group_id
}

output "sg_id"{
    value = "${data.aws_security_group.selected.id}"
}