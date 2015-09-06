# AWS Provider Config for a Rust server

variable "aws_access_key" {}
variable "aws_secret_key" {}
variable "public_key_path" {}

provider "aws" {
  access_key = "${var.aws_access_key}"
  secret_key = "${var.aws_secret_key}"
  region = "us-west-2"
}

# Create a web server
resource "aws_instance" "rust" {
  ami = "ami-4dbcb67d"
  instance_type = "t2.medium"
  availability_zone = "us-west-2b"

  root_block_device {
    volume_type = "gp2"
    volume_size = "30"
    delete_on_termination = "false"
  }

  key_name = "${aws_key_pair.portaj.key_name}"

  vpc_security_group_ids = ["${aws_security_group.remote_access.id}", "${aws_security_group.rust_public.id}", "${aws_security_group.rust_rcon.id}"]

  tags {
    Name = "RustServer"
  }
}

resource "aws_eip" "rust_public" {
  instance = "${aws_instance.rust.id}"
  vpc = true
}

resource "aws_security_group" "remote_access" {
  name = "remote_access"
  description = "Allow all inbound remote access traffic"

  ingress {
    from_port = 3389
    to_port = 3389
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags {
    Name = "remote_access"
  }
}

resource "aws_security_group" "rust_public" {
  name = "rust_public"
  description = "Allow all inbound public Rust traffic"

  ingress {
    from_port = 28015
    to_port = 28016
    protocol = "udp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags {
    Name = "rust_public"
  }
}

resource "aws_security_group" "rust_rcon" {
  name = "rust_rcon"
  description = "Allow all inbound Rust RCON traffic"

  ingress {
    from_port = 5718
    to_port = 5718
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags {
    Name = "rust_rcon"
  }
}

resource "aws_key_pair" "portaj" {
  key_name = "portaj"
  public_key = "${file(var.public_key_path)}"
}
