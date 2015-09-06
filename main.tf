# Make a separate module so we can deploy to each infra separately.
module "aws" {
    source = "./aws"
}

module "gce" {
    source = "./gce"
}
