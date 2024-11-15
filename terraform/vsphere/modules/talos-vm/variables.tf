variable "vm_list" {
  description = "List of VM configurations."
  type = list(object({
    name        = string # VM name, e.g., "k8s-control-01"
    mac_address = string # Static MAC address for the VM
    num_cpus    = number # Number of vCPUs
    memory      = number # Memory in MB
    disk_size   = number # Disk size in GB
  }))
}

variable "datastore_id" {
  description = "The managed object reference ID of the datastore in which to place the virtual machine."
  type        = string
}

variable "network_id" {
  description = "The managed object reference ID of the network on which to connect the virtual machine network interface."
  type        = string
}

variable "resource_pool_id" {
  description = "The managed object reference ID of the resource pool in which to place the virtual machine."
  type        = string
}

variable "machine_config" {
  description = "The base64-encoded machine config file."
  type        = string
  default     = ""
  sensitive   = true
}

variable "template_uuid" {
  description = "The UUID of the source virtual machine or template."
  type        = string
}

variable "vm_folder" {
  description = "The folder where the vm(s) will be deployed to"
  type        = string
}