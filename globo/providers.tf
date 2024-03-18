 
##########
#PROVIDERS
##########

provider "aws" {

    region = var.aws_regions[0]
    #profile = "default"
}

# reference with provider: aws.west
provider "aws" {

    region = var.aws_regions[1]
    alias = "west"
    assume_role {
        role_arn = "arn:aws:iam::1313:/role/OrganizationAccountAccessRole"
    }
}

