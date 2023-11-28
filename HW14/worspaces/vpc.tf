# VPC
resource "aws_vpc" "main" {
    cidr_block = var.vpc_cidr_block
    instance_tenancy = "default"
    enable_dns_hostnames = "true"
    
    tags = {
        Name = var.vpc_name
    }
}

# Public subnet
resource "aws_subnet" "sz-public" {
    vpc_id = "${aws_vpc.main.id}"
    cidr_block = var.subnet_cidr_block
    availability_zone = var.subnet_availability_zone
    map_public_ip_on_launch = "true"
    
    tags = {
        Name = var.subnet_name
    } 
}

# Internet Gateway
resource "aws_internet_gateway" "sz-internet-gateway" {
    vpc_id = "${aws_vpc.main.id}"
        
    tags = { 
        Name = var.ig_name
    }
}

# Route table
resource "aws_route_table" "sz-rt" {
    vpc_id = "${aws_vpc.main.id}"
    
    route {
        cidr_block = var.route_cidr_block
        gateway_id = "${aws_internet_gateway.sz-internet-gateway.id}"
    }
    
    tags = {
        Name = var.rt_name
    }
}

# Subnet association
resource "aws_route_table_association" "a" {
    subnet_id = "${aws_subnet.sz-public.id}"
    route_table_id = "${aws_route_table.sz-rt.id}"
}