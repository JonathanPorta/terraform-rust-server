# terraform-rust-server
Terraform config for spinning up a Rust server on Google Compute Engine

# Creating Infrastructure on a Single Provider
Infrastructure is organized into two modules based on the infra provider: `aws` and `gce`.

`terraform plan -target=module.aws` or `terraform plan -target=module.gce`
