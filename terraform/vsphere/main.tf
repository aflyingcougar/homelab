provider "vsphere" {
  vsphere_server = var.vsphere_server
  user           = var.vsphere_user
  password       = var.vsphere_password

  # If you have a self-signed cert
  allow_unverified_ssl = true
}

# Import data sources
module "data_sources" {
  source          = "./modules/data-sources"
  datacenter      = var.datacenter
  resource_pool   = var.resource_pool
  datastore       = var.datastore
  dswitch_name    = var.dswitch_name
  network_name    = var.network_name
  content_library = var.content_library
  talos_ovf       = var.talos_ovf
}

# Generate control plane VMs
module "control_plane_vms" {
  source           = "./modules/talos-vm"
  vm_list          = var.control_plane_vms
  machine_config   = var.control_machine_config
  template_uuid    = module.data_sources.talos_ovf
  resource_pool_id = module.data_sources.resource_pool_id
  datastore_id     = module.data_sources.datastore_id
  network_id       = module.data_sources.network_id
  vm_folder        = var.vm_folder
}

# Generate worker VMs
module "worker_vms" {
  source           = "./modules/talos-vm"
  vm_list          = var.worker_vms
  machine_config   = var.worker_machine_config
  template_uuid    = module.data_sources.talos_ovf
  resource_pool_id = module.data_sources.resource_pool_id
  datastore_id     = module.data_sources.datastore_id
  network_id       = module.data_sources.network_id
  vm_folder        = var.vm_folder
}

# Output all VM IPs
output "control_plane_ips" {
  value = module.control_plane_vms.vm_ips
}

output "worker_ips" {
  value = module.worker_vms.vm_ips
}