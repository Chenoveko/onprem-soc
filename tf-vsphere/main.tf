resource "vsphere_virtual_machine" "vm" {
  for_each         = var.vms
  name             = each.value.name
  resource_pool_id = data.vsphere_compute_cluster.cluster.resource_pool_id
  datastore_id     = data.vsphere_datastore.datastore.id

  num_cpus                = var.vm_vcpu
  memory                  = var.vm_memory
  guest_id                = data.vsphere_virtual_machine.template.guest_id
  firmware                = var.vm_firmware
  efi_secure_boot_enabled = true

  network_interface {
    network_id   = data.vsphere_network.network.id
    adapter_type = data.vsphere_virtual_machine.template.network_interface_types[0]
  }

  disk {
    label            = var.vm_disk_label
    size             = var.vm_disk_size
    thin_provisioned = var.vm_disk_thin
  }
  clone {
    template_uuid = data.vsphere_virtual_machine.template.id
    customize {
      linux_options {
        host_name = each.value.name
        domain    = var.vm_domain
      }
      network_interface {
        ipv4_address    = each.value.vm_ip
        ipv4_netmask    = var.vm_ipv4_netmask
        dns_server_list = var.vm_dns_servers
      }
      ipv4_gateway = var.vm_ipv4_gateway
    }
  }
}