resource "aws_security_group" "sz-dev-t-sg" {
    name = "sz-dev-t-sg"
    description = "This firewall allows SSH, HTTP and MYSQL"
    vpc_id = "${aws_vpc.main.id}"

    dynamic "ingress" {
        for_each = ["22", "80", "3306"]

        content {
            from_port        = ingress.value
            to_port          = ingress.value
            protocol         = "tcp"
            cidr_blocks      = ["0.0.0.0/0"]
        }
    }   
    
    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
    
    tags = {
        Name = "sz-dev-t-sg"
    }
}