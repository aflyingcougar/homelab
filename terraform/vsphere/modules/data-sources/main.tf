variable "datacenter" {}
variable "resource_pool" {}
variable "datastore" {}
variable "dswitch_name" {}
variable "network_name" {}
variable "content_library" {}
variable "talos_ovf" {}

data "vsphere_datacenter" "dc" {
  name = var.datacenter
}

data "vsphere_resource_pool" "pool" {
  name          = var.resource_pool
  datacenter_id = data.vsphere_datacenter.dc.id
}

data "vsphere_datastore" "datastore" {
  name          = var.datastore
  datacenter_id = data.vsphere_datacenter.dc.id
}

data "vsphere_distributed_virtual_switch" "vds" {
  name          = var.dswitch_name
  datacenter_id = data.vsphere_datacenter.dc.id
}

data "vsphere_network" "network" {
  name                            = var.network_name
  datacenter_id                   = data.vsphere_datacenter.dc.id
  distributed_virtual_switch_uuid = data.vsphere_distributed_virtual_switch.vds.id
}

data "vsphere_content_library" "content_library" {
  name = var.content_library
}

data "vsphere_content_library_item" "talos_ovf" {
  name       = var.talos_ovf
  type       = "ovf"
  library_id = data.vsphere_content_library.content_library.id
}

output "resource_pool_id" {
  value = data.vsphere_resource_pool.pool.id
}

output "datastore_id" {
  value = data.vsphere_datastore.datastore.id
}

output "network_id" {
  value = data.vsphere_network.network.id
}

output "talos_ovf" {
  value = data.vsphere_content_library_item.talos_ovf.id
}