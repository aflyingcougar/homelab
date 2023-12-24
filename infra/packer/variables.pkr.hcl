variable "vsphere_server" {
  type    = string
  default = ""
}

variable "vsphere_user" {
  type    = string
  default = ""
}

variable "vsphere_password" {
  type    = string
  sensitive = true
  default = ""
}

variable "datacenter" {
  type    = string
  default = ""
}

variable "host" {
  type    = string
  default = ""
}

variable "datastore" {
  type    = string
  default = ""
}

variable "network_name" {
  type    = string
  default = ""
}

variable "vm_folder" {
  type    = string
  default = ""
}

variable "sudo_password" {
  type = string
  sensitive = true
  default = ""
}