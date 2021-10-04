# ## Load Balancer
# ## Docs https://github.com/terraform-google-modules/terraform-google-lb-http
# module "gce-lb-http" {
#   source            = "GoogleCloudPlatform/lb-http/google"
#   version           = "~> 4.4"
#   address           = google_compute_address.web.address
#   project           = var.gcp_project_id
#   name              = "${var.gcp_project_name}-lb"
# #   target_tags       = [module.mig1.target_tags, module.mig2.target_tags]
#   backends = {
#     default = {
#       description                     = "webserver"
#       protocol                        = "HTTP"
#       port                            = var.service_port
#       port_name                       = var.service_port_name
#       timeout_sec                     = 10
#       enable_cdn                      = false
#       custom_request_headers          = null
#       custom_response_headers         = null
#       security_policy                 = null

#       connection_draining_timeout_sec = null
#       session_affinity                = null
#       affinity_cookie_ttl_sec         = null

#       health_check = {
#         check_interval_sec  = null
#         timeout_sec         = null
#         healthy_threshold   = null
#         unhealthy_threshold = null
#         request_path        = "/"
#         port                = var.service_port
#         host                = null
#         logging             = null
#       }

#       log_config = {
#         enable = true
#         sample_rate = 1.0
#       }

#       groups = [
#         {
#           # Each node pool instance group should be added to the backend.
#           group                        = google_compute_address.web.id
#           balancing_mode               = null
#           capacity_scaler              = null
#           description                  = null
#           max_connections              = null
#           max_connections_per_instance = null
#           max_connections_per_endpoint = null
#           max_rate                     = null
#           max_rate_per_instance        = null
#           max_rate_per_endpoint        = null
#           max_utilization              = null
#         },
#       ]

#       iap_config = {
#         enable               = false
#         oauth2_client_id     = null
#         oauth2_client_secret = null
#       }
#     }
#   }
# }