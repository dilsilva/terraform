## Cronserver  Compute instance 
##

resource "google_compute_address" "cron" {
  name = "${var.gcp_project_id}-cron-ip"
  region = var.region
  # address_type = "INTERNAL"
  # purpose = "GCE_ENDPOINT"
}

resource "google_compute_instance" "cron" {
  name         = "${var.gcp_project_id}-cron"
  machine_type = var.cron_machine_type
  zone         = "${var.zone}"

  labels = {
    monitor    = "true"
    cron-server = ""
    apache2    = ""
  }

  metadata = {
    ready              = "0"
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
    source = google_compute_disk.cron_data_disk.id
  }

  // Startup scripts to setup crons
  metadata_startup_script = file("${path.module}/install.sh")

  network_interface {
    subnetwork = module.network.subnets_names[0]

    access_config {
      nat_ip = google_compute_address.cron.address
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

resource "google_compute_disk" "cron_data_disk" {
  name  = "cron-data-disk"
  type  = "pd-ssd"
  zone  = var.zone
  image = var.cron_image
  size = 100
}


# ## Cron compute instances
# ##

# resource "google_compute_address" "cron" {
#   name = "${var.gcp_project_id}-cron-ip"
#   region = var.region
# }

# resource "google_compute_instance" "cron" {
#   name         = "${var.gcp_project_id}-cron"
#   machine_type = var.cron_machine_type
#   zone         = "${var.zone}"

#   labels = {
#     monitor     = "true"
#     cron-server = ""
#   }

#   metadata = {
#     ready              = "0"
#     serial-port-enable = true
#     install-variables  = <<EOF
# EOF
#   }

#   tags = [
#     "ssh-server"
#   ]

#   boot_disk {
#     initialize_params {
#       image = "debian-cloud/debian-9"
#       size = 40
#     }
#   }
#   attached_disk {
#     source = google_compute_disk.cron_data_disk.id
#   }

#   metadata_startup_script = file("${path.module}/install.sh")

#   network_interface {
#     # subnetwork = module.network.subnets_names[0]
#     subnetwork = var.subnetwork

#     access_config {
#       nat_ip = google_compute_address.cron.address
#     }
#   }

#   service_account {
#     scopes = ["cloud-platform"]
#   }

#   lifecycle {
#     ignore_changes = [
#       metadata,
#       metadata_startup_script
#     ]
#   }
# }

# ## Compute instance Disks
# ##

# resource "google_compute_disk" "cron_data_disk" {
#   name  = "cron-data-disk"
#   type  = "pd-ssd"
#   zone  = var.zone
#   image = var.cron_image
#   size = 100
# }
