 

# DATA #

# Retrieve latest ami id from SSM 

data "aws_ssm_parameter" "amzn2_linux" {

    name = "/aws/services/ami-amazon-linux-latest/amzn2-ami-hvm-x86_64-gp2"
}

 
 
# INSTANCES #

# Create EC2 instance and install apache

resource "aws_instance" "nginx1" {

    ami = nonsensitive(data.aws_ssm_parameter.amzn2_linux.value)
    instance_type = var.aws_instance_sizes["small"]
    subnet_id = aws_subnet.public_subnet1.id
    vpc_security_group_ids = [aws_security_group.nginx_sg.id]
    iam_instance_profile = aws_iam_instance_profile.nginx_profile.name
    depends_on = [aws_iam_role_policy.allow_s3_all]
    tags = local.common_tags
    
    user_data = file("userdata.tpl")
}
   
# Create second EC2 instance and install apache

resource "aws_instance" "nginx2" {

    ami = nonsensitive(data.aws_ssm_parameter.amzn2_linux.value)
    instance_type = var.aws_instance_sizes["small"]
    subnet_id = aws_subnet.public_subnet2.id
    vpc_security_group_ids = [aws_security_group.nginx_sg.id]
    iam_instance_profile = aws_iam_instance_profile.nginx_profile.name
    depends_on = [aws_iam_role_policy.allow_s3_all]
    tags = local.common_tags
    
    user_data = file("userdata.tpl")
}


# Create IAM role

resource "aws_iam_role" "allow_nginx_s3" {

    name = "allow_nginx_s3"
    assume_role_policy = <<EOF
    
    {
    
        "Version": "2012-10-17",
        "Statement": [
          {
            "Action": "sts:AssumeRole",
            "Principal": {
                "Service": "ec2.amazonaws.com"
            },
            "Effect": "Allow",
            "Sid": ""
          }
        
        ]
    
    }
    
    EOF
    
    tags = local.common_tags 
}

# Create instance profile 

resource "aws_iam_instance_profile" "nginx_profile" {
    name = "nginx_profile"
    role = aws_iam_role.allow_nginx_s3.name
    
    tags = local.common_tags 

}

# Create IAM role policy - grants instances access to S3

resource "aws_iam_role_policy" "allow_s3_all" {

    name = "allow_s3_all"
    role = aws_iam_role.allow_nginx_s3.name
    
    policy = <<EOF
    
    {
    
        "Version": "2012-10-17",
        "Statement": [
          {
            "Action": [
                "s3:*"
            ],
            "Effect": "Allow",
            "Resource": [
                "arn:aws:s3:::${local.s3_bucket_name}"
                "arn:aws:s3:::${local.s3_bucket_name}/*"
            ]

          }
        
        ]
    
    }
    
    EOF

}
