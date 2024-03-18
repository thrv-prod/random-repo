#!/bin/bash                                                    
yum update -y                                                  
yum install httpd -y                                           
systemctl start httpd                                          
systemctl enable httpd                                         
aws s3 cp s3://${aws_s3_bucket.web_bucket.id}/website/index.html /home/ec2-user/index.html
cp /home/ec2-user/index.html /var/www/html/index.html
