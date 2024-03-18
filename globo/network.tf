 ############
# DATA
############

data "aws_availability_zones" "available" {

    state = "available"
}

#NETWORKING#

# Create VPC 

resource "aws_vpc" "app" {

    cidr_block = var.vpc_cidr_block
    enable_dns_hostnames = var.enable_dns_hostnames
    tags = local.common_tags
}

# Create IGW 

resource "aws_internet_gateway" "app" {

    vpc_id = aws_vpc.app.id

}

# Create public subnet1 

resource "aws_subnet" "public_subnet1" {

    cidr_block = var.vpc_public_subnets_cidr[0]
    vpc_id = aws_vpc.app.id
    map_public_ip_on_launch = var.map_public_ip
    availability_zone = data.aws_availability_zones.available.names[0]
}

# Create public subnet2 

resource "aws_subnet" "public_subnet2" {

    cidr_block = var.vpc_public_subnets_cidr[1]
    vpc_id = aws_vpc.app.id
    map_public_ip_on_launch = var.map_public_ip
    availability_zone = data.aws_availability_zones.available.names[1]
}

# ROUTING $

# Create default route table 

resource "aws_route_table" "app" {

    vpc_id  = aws_vpc.app.id
    
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.app.id
    }
}

# Add route table association for subnet1 

resource "aws_route_table_association" "app_subnet1" {

    subnet_id = aws_subnet.public_subnet1.id
    route_table_id = aws_route_table.app.id
}

# Add route table association for subnet2

resource "aws_route_table_association" "app_subnet2" {

    subnet_id = aws_subnet.public_subnet2.id
    route_table_id = aws_route_table.app.id
}


# SECURITY GROUPS
# Nginx security group 

#Allow only traffic from within the VPC 

resource "aws_security_group" "nginx_sg" {

    name = "nginx_sg"
    vpc_id = aws_vpc.app.id
    
    # HTTP access from anywhere
    ingress {
      from_port = 80
      to_port = 80
      protocol = "tcp"
      cidr_blocks = [var.vpc_cidr_block]    
    }
    
    # outbound internet access
    egress {
      from_port = 0
      to_port = 0
      protocol = "-1"
      cidr_blocks = ["0.0.0.0/0"] 
    }
}

# Allow all traffic to ALB 

resource "aws_security_group" "nginx_alb_sg" {

    name = "nginx_alb_sg"
    vpc_id = aws_vpc.app.id
    
    # HTTP access from anywhere
    ingress {
      from_port = 80
      to_port = 80
      protocol = "tcp"
      cidr_blocks = ["0.0.0.0/0"]    
    }
    
    # outbound internet access
    egress {
      from_port = 0
      to_port = 0
      protocol = "-1"
      cidr_blocks = ["0.0.0.0/0"] 
    }
}