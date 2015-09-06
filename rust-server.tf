# Configure the Google Cloud provider
provider "google" {
    account_file = "${file("account.json")}"
    project = "ogs-production"
    region = "us-central1"
}

resource "google_compute_instance" "default" {
  name = "rust"
  machine_type = "g1-small"
  zone = "us-central1-f"

  disk {
    image = "windows-server-2012-r2-dc-v20150813"
  }

  network_interface {
    network = "default"
    access_config {
      nat_ip = "104.197.31.88"
    }
  }
}

resource "google_compute_firewall" "default" {
  name = "rust"
  network = "default"

  allow {
    protocol = "icmp"
  }

  allow {
    protocol = "tcp"
    ports = ["80", "5718", "28055"]
  }

  allow {
    protocol = "udp"
    ports = ["80", "5718", "28055"]
  }

  source_ranges = ["0.0.0.0/0"]
}
