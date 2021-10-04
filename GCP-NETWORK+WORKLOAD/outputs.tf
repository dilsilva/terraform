output "cron-self-link" {
  value = google_compute_instance.web.self_link
}
output "web-self-link" {
  value = google_compute_instance.cron.self_link
}

output "web-ip" {
  value = google_compute_address.web.address
}

output "cron-ip" {
  value = google_compute_address.cron.address
}