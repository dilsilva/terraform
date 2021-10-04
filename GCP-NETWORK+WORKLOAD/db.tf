## databaseserver  Compute instance 
##

resource "google_compute_address" "database" {
  name = "${var.gcp_project_id}-database-ip"
  region = var.region
  # address_type = "INTERNAL"
  # purpose = "GCE_ENDPOINT"
}

resource "google_compute_instance" "database" {
  name         = "${var.gcp_project_id}-database"
  machine_type = var.cron_machine_type
  zone         = "${var.zone}"

  labels = {
    monitor    = "true"
    database-server = ""
    apache2    = ""
  }

  metadata = {
    ready              = "0"
  }

  tags = [
    "db-server"
  ]

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-9"
      size = 40
    }
  }

  
  # Attached_disk {
  # source = google_compute_disk.database_data_disk.id
  # }

  // Startup scripts to setup databases
  metadata_startup_script = file("${path.module}/install.sh")

  network_interface {
    subnetwork = module.network.subnets_names[1]

    access_config {
      nat_ip = google_compute_address.database.address
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

# resource "google_compute_disk" "database_data_disk" {
#   name  = "database-data-disk"
#   type  = "pd-ssd"
#   zone  = var.zone
#   image = var.database_image
#   size = 100
# }

