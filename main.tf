# Make a separate module so we can deploy to each infra separately.
module "aws" {
    source = "./aws"

    aws_access_key = "${var.aws_access_key}"
    aws_secret_key = "${var.aws_secret_key}"
}

#module "gce" {
#    source = "./gce"
#    account_file_path = "account.json"
#}
