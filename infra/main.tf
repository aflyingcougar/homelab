provider "vsphere" {
  vsphere_server = var.vsphere_server
  user           = var.vsphere_user
  password       = var.vsphere_password

  # If you have a self-signed cert
  allow_unverified_ssl = true
}

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

data "local_file" "talos_cp_config" {
  filename = var.talos_cp_config_path
}

data "local_file" "talos_wk_config" {
  filename = var.talos_wk_config_path
}

resource "vsphere_virtual_machine" "k8s-control-01" {
  name             = "k8s-control-01"
  resource_pool_id = data.vsphere_resource_pool.pool.id
  datastore_id     = data.vsphere_datastore.datastore.id
  folder           = var.vm_folder

  num_cpus = 2
  memory   = 4096

  network_interface {
    network_id     = data.vsphere_network.network.id
    use_static_mac = true
    mac_address    = "00:50:56:00:00:01"
  }

  wait_for_guest_net_timeout = -1
  wait_for_guest_ip_timeout  = -1

  disk {
    label            = "disk0"
    thin_provisioned = true
    size             = 10
  }

  enable_disk_uuid = true
  guest_id         = "other3xLinux64Guest"

  clone {
    template_uuid = data.vsphere_content_library_item.talos_ovf.id
  }

  extra_config = {
    "guestinfo.talos.config" = data.local_file.talos_cp_config.content_base64
  }
}

resource "vsphere_virtual_machine" "k8s-control-02" {
  name             = "k8s-control-02"
  resource_pool_id = data.vsphere_resource_pool.pool.id
  datastore_id     = data.vsphere_datastore.datastore.id
  folder           = var.vm_folder

  num_cpus = 2
  memory   = 4096

  network_interface {
    network_id     = data.vsphere_network.network.id
    use_static_mac = true
    mac_address    = "00:50:56:00:00:02"
  }

  wait_for_guest_net_timeout = -1
  wait_for_guest_ip_timeout  = -1

  disk {
    label            = "disk0"
    thin_provisioned = true
    size             = 10
  }

  enable_disk_uuid = true
  guest_id         = "other3xLinux64Guest"

  clone {
    template_uuid = data.vsphere_content_library_item.talos_ovf.id
  }

  extra_config = {
    "guestinfo.talos.config" = data.local_file.talos_cp_config.content_base64
  }
}

resource "vsphere_virtual_machine" "k8s-control-03" {
  name             = "k8s-control-03"
  resource_pool_id = data.vsphere_resource_pool.pool.id
  datastore_id     = data.vsphere_datastore.datastore.id
  folder           = var.vm_folder

  num_cpus = 2
  memory   = 4096

  network_interface {
    network_id     = data.vsphere_network.network.id
    use_static_mac = true
    mac_address    = "00:50:56:00:00:03"
  }

  wait_for_guest_net_timeout = -1
  wait_for_guest_ip_timeout  = -1

  disk {
    label            = "disk0"
    thin_provisioned = true
    size             = 10
  }

  enable_disk_uuid = true
  guest_id         = "other3xLinux64Guest"

  clone {
    template_uuid = data.vsphere_content_library_item.talos_ovf.id
  }

  extra_config = {
    "guestinfo.talos.config" = data.local_file.talos_cp_config.content_base64
  }
}

resource "vsphere_virtual_machine" "k8s-worker-01" {
  name             = "k8s-worker-01"
  resource_pool_id = data.vsphere_resource_pool.pool.id
  datastore_id     = data.vsphere_datastore.datastore.id
  folder           = var.vm_folder

  num_cpus = 2
  memory   = 4096

  network_interface {
    network_id     = data.vsphere_network.network.id
    use_static_mac = true
    mac_address    = "00:50:56:00:00:04"
  }

  wait_for_guest_net_timeout = -1
  wait_for_guest_ip_timeout  = -1

  disk {
    label            = "disk0"
    thin_provisioned = true
    size             = 10
  }

  enable_disk_uuid = true
  guest_id         = "other3xLinux64Guest"

  clone {
    template_uuid = data.vsphere_content_library_item.talos_ovf.id
  }

  extra_config = {
    "guestinfo.talos.config" = data.local_file.talos_wk_config.content_base64
  }
}

resource "vsphere_virtual_machine" "k8s-worker-02" {
  name             = "k8s-worker-02"
  resource_pool_id = data.vsphere_resource_pool.pool.id
  datastore_id     = data.vsphere_datastore.datastore.id
  folder           = var.vm_folder

  num_cpus = 2
  memory   = 4096

  network_interface {
    network_id     = data.vsphere_network.network.id
    use_static_mac = true
    mac_address    = "00:50:56:00:00:05"
  }

  wait_for_guest_net_timeout = -1
  wait_for_guest_ip_timeout  = -1

  disk {
    label            = "disk0"
    thin_provisioned = true
    size             = 10
  }

  enable_disk_uuid = true
  guest_id         = "other3xLinux64Guest"

  clone {
    template_uuid = data.vsphere_content_library_item.talos_ovf.id
  }

  extra_config = {
    "guestinfo.talos.config" = data.local_file.talos_wk_config.content_base64
  }
}

resource "vsphere_virtual_machine" "k8s-worker-03" {
  name             = "k8s-worker-03"
  resource_pool_id = data.vsphere_resource_pool.pool.id
  datastore_id     = data.vsphere_datastore.datastore.id
  folder           = var.vm_folder

  num_cpus = 2
  memory   = 4096

  network_interface {
    network_id     = data.vsphere_network.network.id
    use_static_mac = true
    mac_address    = "00:50:56:00:00:06"
  }

  wait_for_guest_net_timeout = -1
  wait_for_guest_ip_timeout  = -1

  disk {
    label            = "disk0"
    thin_provisioned = true
    size             = 10
  }

  enable_disk_uuid = true
  guest_id         = "other3xLinux64Guest"

  clone {
    template_uuid = data.vsphere_content_library_item.talos_ovf.id
  }

  extra_config = {
    "guestinfo.talos.config" = data.local_file.talos_wk_config.content_base64
  }
}

output "vm_ips" {
  value = {
    ip_1 = vsphere_virtual_machine.k8s-control-01.guest_ip_addresses
    ip_2 = vsphere_virtual_machine.k8s-control-02.guest_ip_addresses
    ip_3 = vsphere_virtual_machine.k8s-control-03.guest_ip_addresses
    ip_4 = vsphere_virtual_machine.k8s-worker-01.guest_ip_addresses
    ip_5 = vsphere_virtual_machine.k8s-worker-02.guest_ip_addresses
    ip_6 = vsphere_virtual_machine.k8s-worker-03.guest_ip_addresses
  }
}