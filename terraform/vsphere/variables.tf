variable "content_library" {
  description = "(Required) The name of the content library."
  type        = string
}

variable "control_plane_vms" {
  description = "List of control plane VM configurations."
  type = list(object({
    name        = string,                 # VM name, e.g., "k8s-control-01"
    mac_address = string,                 # Static MAC address for the VM
    num_cpus    = optional(number, 2),    # Number of vCPUs (default: 2)
    memory      = optional(number, 2048), # Memory in MB (default: 2048)
    disk_size   = optional(number, 10),   # Disk size in GB (default: 10)
  }))
}

variable "datacenter" {
  description = "(Optional) The name of the datacenter. This can be a name or path. Can be omitted if there is only one datacenter in the inventory."
  type        = string
}

variable "datastore" {
  description = "(Required) The name of the datastore. This can be a name or path."
  type        = string
}

variable "dswitch_name" {
  description = "(Required) The name of the VDS. This can be a name or path."
  type        = string
}

variable "control_machine_config" {
  description = "The base64-encoded machine config file."
  type        = string
  default     = ""
  sensitive   = true
}

variable "worker_machine_config" {
  description = "The base64-encoded machine config file."
  type        = string
  default     = ""
  sensitive   = true
}

variable "network_name" {
  description = "(Required) The name of the network. This can be a name or path."
  type        = string
}

variable "resource_pool" {
  description = "(Optional) The name of the resource pool. This can be a name or path. This is required when using vCenter."
  type        = string
}

variable "talos_ovf" {
  description = "The name of the talos ovf content library item (e.g. talos-1.7.5)"
  type        = string
}

variable "vm_folder" {
  description = "The folder where the vm(s) will be deployed to"
  type        = string
}
variable "vsphere_password" {
  description = "(Required) This is the password for vSphere API operations."
  type        = string
  sensitive   = true
}

variable "vsphere_server" {
  description = "(Required) This is the vCenter Server FQDN or IP Address for vSphere API operations."
  type        = string
}

variable "vsphere_user" {
  description = "(Required) This is the username for vSphere API operations."
  type        = string
}

variable "worker_vms" {
  description = "List of worker VM configurations."
  type = list(object({
    name        = string,                 # VM name, e.g., "k8s-worker-01"
    mac_address = string,                 # Static MAC address for the VM
    num_cpus    = optional(number, 1),    # Number of vCPUs (default: 1)
    memory      = optional(number, 1024), # Memory in MB (default: 1024)
    disk_size   = optional(number, 10),   # Disk size in GB (default: 10)
    config_file = optional(string, "")    # Path to Talos configuration file (if applicable)
  }))
}