 
# in tags section: tags = local.common_tags

locals {
    common_tags = {
        company = var.company
        business_unit = "$(var.company}-${var.business_unit}"
    }
    s3_bucket_name = "globo-web-app-${random_integer.s3.result}"

}

# Generate random 5 digit number

resource "random_integer" "s3" {

    min = 10000
    max = 99999
}
