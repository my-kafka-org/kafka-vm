resource "random_id" "instance_id" {
  byte_length = 8
}


resource "google_compute_instance" "default" {
  #name         = "vm-${random_id.instance_id.hex}"
  name         = "kafka-vm"
  machine_type = "n1-standard-2"
  #machine_type = "f1-micro"
  zone         = "us-west1-a"

  boot_disk {
    initialize_params {
 #     image = "debian-cloud/debian-9"
      image = "centos-8-v20200714"
    }
  }
  metadata_startup_script = file("${path.module}/boot.sh")
  metadata = {
  ssh-keys = "thirupalanivel:${var.ssh_key}"
  }

  network_interface {
    network = "default"

    access_config {
      // Include this section to give the VM an external ip address  
    }
  }

  // Apply the firewall rule to allow external IPs to access this instance
  tags = ["http-server"]
}

resource "google_compute_firewall" "http-server" {
  name    = "default-allow-http"
  network = "default"

  allow {
    protocol = "tcp"
    ports    = ["80"]
  }

  // Allow traffic from everywhere to instances with an http-server tag
  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["http-server"]
}

output "ip" {
  value = "${google_compute_instance.default.network_interface.0.access_config.0.nat_ip}"
}