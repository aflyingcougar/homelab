resource "vsphere_virtual_machine" "vm" {
  for_each = { for vm in var.vm_list : vm.name => vm }

  name             = each.value.name
  resource_pool_id = var.resource_pool_id
  datastore_id     = var.datastore_id
  folder           = var.vm_folder

  num_cpus = each.value.num_cpus
  memory   = each.value.memory

  network_interface {
    network_id     = var.network_id
    use_static_mac = true
    mac_address    = each.value.mac_address
  }

  wait_for_guest_net_timeout = -1
  wait_for_guest_ip_timeout  = -1

  disk {
    label            = "disk0"
    size             = each.value.disk_size
    thin_provisioned = true
  }

  enable_disk_uuid = true
  guest_id         = "other3xLinux64Guest"

  clone {
    template_uuid = var.template_uuid
  }

  extra_config = {
    "guestinfo.talos.config" = var.machine_config
  }
}