# Cloudflare Provider for DNS Provising

variable "cloudflare_email" {}
variable "cloudflare_token" {}
variable "cloudflare_domain" {}
variable "cloudflare_subdomain" {}

provider "cloudflare" {
    email = "${var.cloudflare_email}"
    token = "${var.cloudflare_token}"
}

resource "cloudflare_record" "rust_dns" {
    domain = "${var.cloudflare_domain}"
    name = "${var.cloudflare_subdomain}"
    value = "${aws_eip.rust_public.public_ip}"
    type = "A"
    ttl = 120
}
