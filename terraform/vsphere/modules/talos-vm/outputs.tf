output "vm_ips" {
  description = "For each VM, a list of IP addresses as reported by VMware Tools."
  value       = { for vm in vsphere_virtual_machine.vm : vm.name => vm.guest_ip_addresses }
}
