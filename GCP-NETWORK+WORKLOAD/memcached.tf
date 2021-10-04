# ## Memcache module
# ##

# module "memorystore_memcache" {
#   source  = "terraform-google-modules/memorystore/google//modules/memcache"
#   version = "4.1.0"
  
#   cpu_count             = var.cpu_count
#   memory_size_mb        = var.memory_size_mb 
#   node_count            = var.node_count

#   region        = var.region
#   zones = var.zones 
#   display_name  = "memcached-$(var.gcp_project_id)"
#   name          = "memcached-$(var.gcp_project_id)"
#   project       = var.gcp_project_name
# }