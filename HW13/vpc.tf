# VPC
resource "aws_vpc" "main" {
    cidr_block = "10.50.0.0/16"
    instance_tenancy = "default"
    enable_dns_hostnames = "true"
    
    tags = {
    Name = "main"
    }
}

# Public subnet
resource "aws_subnet" "sz-public" {
    vpc_id = "${aws_vpc.main.id}"
    cidr_block = "10.50.1.0/24"
    availability_zone = "us-east-1a"
    map_public_ip_on_launch = "true"
    
    tags = {
        Name = "sz-public"
    } 
}

# Internet Gateway
resource "aws_internet_gateway" "sz-internet-gateway" {
    vpc_id = "${aws_vpc.main.id}"
        
    tags = { 
        Name = "sz-internet-gateway"
    }
}

# Route table
resource "aws_route_table" "sz-rt" {
    vpc_id = "${aws_vpc.main.id}"
    
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = "${aws_internet_gateway.sz-internet-gateway.id}"
    }
    
    tags = {
        Name = "sz-rt"
    }
}

# Subnet association
resource "aws_route_table_association" "a" {
    subnet_id = "${aws_subnet.sz-public.id}"
    route_table_id = "${aws_route_table.sz-rt.id}"
}