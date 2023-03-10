source "vsphere-iso" "this" {
  vcenter_server    = var.vsphere_server
  username          = var.vsphere_user
  password          = var.vsphere_password
  datacenter        = var.datacenter
  host              = var.host
  folder            = var.vm_folder

  insecure_connection  = true

  vm_name = "tf-ubuntu-22042"
  guest_os_type = "ubuntu64Guest"

  ssh_username = "ubuntu"
  ssh_password = "ubuntu"
  ssh_timeout = "10m"

  CPUs =             1
  RAM =              1024
  RAM_reserve_all = true

  disk_controller_type =  ["pvscsi"]
  datastore = var.datastore
  storage {
    disk_size =        16384
    disk_thin_provisioned = true
  }

  iso_paths = ["[ISOs] Ubuntu/ubuntu-22.04.2-live-server-amd64.iso"]
  iso_checksum = "sha256:84aeaf7823c8c61baa0ae862d0a06b03409394800000b3235854a6b38eb4856f"

  network_adapters {
    network =  var.network_name
    network_card = "vmxnet3"
  }

  boot_command = [
    "<esc><esc><esc><esc>e<wait>",
    "<del><del><del><del><del><del><del><del>",
    "<del><del><del><del><del><del><del><del>",
    "<del><del><del><del><del><del><del><del>",
    "<del><del><del><del><del><del><del><del>",
    "<del><del><del><del><del><del><del><del>",
    "<del><del><del><del><del><del><del><del>",
    "<del><del><del><del><del><del><del><del>",
    "<del><del><del><del><del><del><del><del>",
    "<del><del><del><del><del><del><del><del>",
    "<del><del><del><del><del><del><del><del>",
    "<del><del><del><del><del><del><del><del>",
    "<del><del><del><del><del><del><del><del>",
    "<del><del><del><del><del><del><del><del>",
    "<del><del><del><del><del><del><del><del>",
    "<del>",
    "linux /casper/vmlinuz --- autoinstall ds=\"nocloud-net;seedfrom=http://{{.HTTPIP}}:{{.HTTPPort}}/\"<enter><wait>",
    "initrd /casper/initrd<enter><wait>",
    "boot<enter>",
    "<enter><f10><wait>" 
  ]
  
  http_directory = "./http"
}

build {
  sources  = [
    "source.vsphere-iso.this"
  ]

  provisioner "shell" {
	execute_command = "echo 'ubuntu' | sudo -S -E bash '{{.Path}}'"
	script = "provision_scripts/provision.sh"
  }
}