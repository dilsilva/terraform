## Webserver  Compute instance 
##

resource "google_compute_address" "web" {
  name = "${var.gcp_project_id}-web-ip"
  region = var.region
  # address_type = "INTERNAL"
}

resource "google_compute_instance" "web" {
  name         = "${var.gcp_project_id}-web"
  machine_type = var.web_machine_type
  zone         = "${var.zone}"

  labels = {
    monitor    = "true"
    web-server = ""
    apache2    = ""
  }

  metadata = {
    ready              = "0"
    serial-port-enable = true
    install-variables  = <<EOF
export memcachedMemoryInMb="1024"
export memcachedConnections="4096"
EOF
  }

  tags = [
    "http-server",
    "https-server",
    "ssh-from-office"
  ]


  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-9"
      size = 40
    }
  }

  
  attached_disk {
    source = google_compute_disk.web_data_disk.id
  }

  // Startup scripts to setup crons
  metadata_startup_script = file("${path.module}/install.sh")

  network_interface {
    subnetwork = module.network.subnets_names[0]

    access_config {
      nat_ip = google_compute_address.web.address
    }
  }

  lifecycle {
    ignore_changes = [
      metadata,
      metadata_startup_script
    ]
  }

  service_account {
    # Google recommends custom service accounts that have cloud-platform scope and permissions granted via IAM Roles.
    scopes = ["cloud-platform","service-management","storage-full","monitoring-write","trace"]
  }
}

## Compute instance Disks
##

resource "google_compute_disk" "web_data_disk" {
  name  = "web-data-disk"
  type  = "pd-ssd"
  zone  = var.zone
  image = var.web_image
  size = 100
}
