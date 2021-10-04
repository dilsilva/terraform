# Module to create a Local VPC
## Docs: https://github.com/terraform-google-modules/terraform-google-network
module "network" {
  source     = "terraform-google-modules/network/google"
  version    = "~> 3.4"
  depends_on = [google_project_service.apis]

  project_id   = var.gcp_project_id
  network_name = var.gcp_project_name
  routing_mode = "GLOBAL"

  subnets = [
    {
      subnet_name   = "database-subnet"
      subnet_ip     = "10.100.0.0/24"
      subnet_region = var.region
      subnet_private_access = true
    },
    {
      subnet_name   = "backend-subnet"
      subnet_ip     = "10.101.0.0/24"
      subnet_region = var.region
      subnet_private_access = true
    },
    {
      subnet_name   = "frontend-subnet"
      subnet_ip     = "10.102.0.0/24"
      subnet_region = var.region
      subnet_private_access = true
    }
  ]
}

## Firewall rules
##

resource "google_compute_firewall" "https" {
  name    = "track-insight-vpc-allow-https"
  network = module.network.network_name
  direction = "INGRESS"
  priority = 1000
  source_ranges = ["0.0.0.0/0"]
  target_tags = ["https-server"]

  allow {
    protocol = "tcp"
    ports    = ["443"]
  }

}

resource "google_compute_firewall" "http" {
  name    = "track-insight-vpc-allow-http"
  network = module.network.network_name
  direction = "INGRESS"
  priority = 1000
  source_ranges = ["0.0.0.0/0"]
  target_tags = ["http-server"]

  allow {
    protocol = "tcp"
    ports    = ["80"]
  }
}

resource "google_compute_firewall" "memcached" {
  name    = "track-insight-allow-memcached-internal"
  network = module.network.network_name
  direction = "INGRESS"
  priority = 1000
  source_ranges = [tostring(module.network.subnets_ips[1])]
  target_tags = ["http-server"]

  allow {
    protocol = "tcp"
    ports    = ["11211"]
  }

  allow {
    protocol = "icmp"
  }

}

resource "google_compute_firewall" "ssh" {
  name    = "ssh-from-office"
  network = module.network.network_name
  direction = "INGRESS"
  priority = 1000
  source_ranges = ["87.213.98.98"]

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }
}

resource "google_compute_firewall" "iap" {
  name    = "allow-iap-traffic"
  network = module.network.network_name
  direction = "INGRESS"
  priority = 1000
  source_ranges = ["35.235.240.0/20"]
  disabled = false

  allow {
    protocol = "tcp"
    ports = ["22"]
  }
}

resource "google_compute_firewall" "db" {
  name    = "allow-db"
  network = module.network.network_name
  direction = "INGRESS"
  priority = 1000
  source_ranges = [tostring(module.network.subnets_ips[0])]
  target_tags = ["db-server"]

  allow {
    protocol = "tcp"
    ports = ["3306"]
  }

}

## VPC PEERING
##
resource "google_compute_global_address" "private_ip_alloc" {
  name          = "private-ip-alloc"
  purpose       = "VPC_PEERING"
  address_type  = "INTERNAL"
  prefix_length = 20
  network       = module.network.network_id
}

resource "google_service_networking_connection" "default" {
  network                 = module.network.network_id
  service                 = "servicenetworking.googleapis.com"
  reserved_peering_ranges = [google_compute_global_address.private_ip_alloc.name]
}