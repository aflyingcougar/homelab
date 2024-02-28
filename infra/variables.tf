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

variable "ubuntu_name" {
  description = "CentOS name (ie: image_path)"
  type        = string
}

variable "vm_domain" {
  description = "The domain name for the virutal machines"
  type        = string
}

variable "vm_folder" {
  description = "The folder where the vm(s) will be deployed to"
  type        = string
}