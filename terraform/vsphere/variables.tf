variable "vsphere_server" {
  description = "vSphere server"
  type        = string
}

variable "vsphere_user" {
  description = "vSphere username"
  type        = string
}

variable "vsphere_password" {
  description = "vSphere password"
  type        = string
  sensitive   = true
}

variable "datacenter" {
  description = "vSphere data center"
  type        = string
}

variable "resource_pool" {
  description = "vSphere cluster"
  type        = string
}

variable "datastore" {
  description = "vSphere datastore"
  type        = string
}

variable "network_name" {
  description = "vSphere network name"
  type        = string
}

variable "dswitch_name" {
  description = "Distributed Switch name"
  type        = string
}

variable "vm_folder" {
  description = "The folder where the vm(s) will be deployed to"
  type        = string
}

variable "content_library" {
  description = "The name of the content library"
  type        = string
}

variable "talos_ovf" {
  description = "The name of the talos ovf content library item (e.g. talos-1.7.5)"
  type        = string
}