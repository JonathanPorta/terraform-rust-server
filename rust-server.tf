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

        }
    }
# Provisioner and credential setting doesn't work with GCE's new Windows Auth system...
#  metadata {
#    gce-initial-windows-user = "Administrator"
#    gce-initial-windows-password = "${var.admin_password}"
#  }
#
#  provisioner "remote-exec" {
#    inline = [
#      "iex ((new-object net.webclient).DownloadString('https://chocolatey.org/install.ps1'))"
#    ]
#    connection {
#      type = "winrm"
#      user = "Administrator"
#      password = "${var.admin_password}"
#    }
#  }
}


#config.vm.provision 'shell', inline: ''
#config.vm.provision 'shell', inline: 'echo "Launching chef powershell installer script..." ; iex C:\vagrant\powershell\chef-installer.ps1'
#config.vm.provision 'shell', inline: 'cinst -y git.install'
#config.vm.provision 'shell', inline: 'echo "Launching chef repo powershell script..." ; iex C:\vagrant\powershell\chef-repo.ps1'
# TODO: Figure out how in the hell these dependencies get on the production server, because I am pretty sure this is not the right way...
#config.vm.provision 'shell', inline: 'echo "Launching chef-solo powershell script..." ; iex C:\vagrant\powershell\chef-solo.ps1'
