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

data "vsphere_virtual_machine" "ubuntu" {
  name          = var.ubuntu_name
  datacenter_id = data.vsphere_datacenter.dc.id
}

resource "vsphere_virtual_machine" "k3s-control-01" {
  name             = "k3s-control-01"
  resource_pool_id = data.vsphere_resource_pool.pool.id
  datastore_id     = data.vsphere_datastore.datastore.id
  folder           = var.vm_folder

  num_cpus = 1
  memory   = 2048

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
    size             = 32
  }

  guest_id = "ubuntu64Guest"

  clone {
    template_uuid = data.vsphere_virtual_machine.ubuntu.id
    customize {
      linux_options {
        host_name = "k3s-control-01"
        domain    = var.vm_domain
      }
      network_interface {}
    }
  }
}

resource "vsphere_virtual_machine" "k3s-control-02" {
  name             = "k3s-control-02"
  resource_pool_id = data.vsphere_resource_pool.pool.id
  datastore_id     = data.vsphere_datastore.datastore.id
  folder           = var.vm_folder

  num_cpus = 1
  memory   = 2048

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
    size             = 32
  }

  guest_id = "ubuntu64Guest"

  clone {
    template_uuid = data.vsphere_virtual_machine.ubuntu.id
    customize {
      linux_options {
        host_name = "k3s-control-02"
        domain    = var.vm_domain
      }
      network_interface {}
    }
  }
}

resource "vsphere_virtual_machine" "k3s-control-03" {
  name             = "k3s-control-03"
  resource_pool_id = data.vsphere_resource_pool.pool.id
  datastore_id     = data.vsphere_datastore.datastore.id
  folder           = var.vm_folder

  num_cpus = 1
  memory   = 2048

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
    size             = 32
  }

  guest_id = "ubuntu64Guest"

  clone {
    template_uuid = data.vsphere_virtual_machine.ubuntu.id
    customize {
      linux_options {
        host_name = "k3s-control-03"
        domain    = var.vm_domain
      }
      network_interface {}
    }
  }
}

resource "vsphere_virtual_machine" "k3s-worker-01" {
  name             = "k3s-worker-01"
  resource_pool_id = data.vsphere_resource_pool.pool.id
  datastore_id     = data.vsphere_datastore.datastore.id
  folder           = var.vm_folder

  num_cpus = 4
  memory   = 8192

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
    size             = 32
  }

  guest_id = "ubuntu64Guest"

  clone {
    template_uuid = data.vsphere_virtual_machine.ubuntu.id
    customize {
      linux_options {
        host_name = "k3s-worker-01"
        domain    = var.vm_domain
      }
      network_interface {}
    }
  }
}

resource "vsphere_virtual_machine" "k3s-worker-02" {
  name             = "k3s-worker-02"
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
    size             = 32
  }

  guest_id = "ubuntu64Guest"

  clone {
    template_uuid = data.vsphere_virtual_machine.ubuntu.id
    customize {
      linux_options {
        host_name = "k3s-worker-02"
        domain    = var.vm_domain
      }
      network_interface {}
    }
  }
}

resource "vsphere_virtual_machine" "k3s-worker-03" {
  name             = "k3s-worker-03"
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
    size             = 32
  }

  guest_id = "ubuntu64Guest"

  clone {
    template_uuid = data.vsphere_virtual_machine.ubuntu.id
    customize {
      linux_options {
        host_name = "k3s-worker-03"
        domain    = var.vm_domain
      }
      network_interface {}
    }
  }
}

output "vm_ips" {
  value = {
    ip_1 = vsphere_virtual_machine.k3s-control-01.guest_ip_addresses
    ip_2 = vsphere_virtual_machine.k3s-control-02.guest_ip_addresses
    ip_3 = vsphere_virtual_machine.k3s-control-03.guest_ip_addresses
    ip_4 = vsphere_virtual_machine.k3s-worker-01.guest_ip_addresses
    ip_5 = vsphere_virtual_machine.k3s-worker-02.guest_ip_addresses
    ip_6 = vsphere_virtual_machine.k3s-worker-03.guest_ip_addresses
  }
}