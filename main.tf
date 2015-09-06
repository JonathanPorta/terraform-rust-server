# Make a separate module so we can deploy to each infra separately.
module "aws" {
  source = "./aws"

  aws_access_key = "${var.aws_access_key}"
  aws_secret_key = "${var.aws_secret_key}"
  public_key_path = "${var.public_key_path}"

  cloudflare_email = "${var.cloudflare_email}"
  cloudflare_token = "${var.cloudflare_token}"
  cloudflare_domain = "${var.cloudflare_domain}"
  cloudflare_subdomain = "${var.cloudflare_subdomain}"
}

module "gce" {
  source = "./gce"

  gce_account_file_path = "${var.gce_account_file_path}"
}
