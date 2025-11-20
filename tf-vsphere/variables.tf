#========== vCenter Credentials ==========#
variable "vsphere_user" {
  description = "Usuario con permisos para acceder al servidor vSphere"
  type        = string
  sensitive   = true
}

variable "vsphere_password" {
  description = "Contraseña del usuario de vSphere"
  type        = string
  sensitive   = true
}

variable "vsphere_server" {
  description = "Dirección IP o nombre del servidor vSphere"
  type        = string
}

#========== vCenter Variables ==========#
variable "vsphere_datacenter" {
  type        = string
  description = "vSphere datacenter"
}

variable "vsphere_compute_cluster" {
  type        = string
  description = "vSphere cluster"
}

variable "vsphere_datastore" {
  type        = string
  description = "vSphere Datastore"
}

variable "vsphere_network" {
  type        = string
  description = "vSphere Portgroup"
}

#========== VM Variables ==========#
variable "vm_template_name" {
  type        = string
  description = "Template que vamos a utilizar para el despliegue de las VMs"
}

variable "vms" {
  type        = map(any)
  description = "Lista de VMs que vamos a desplegar"
}

variable "vm_firmware" {
  type        = string
  description = "Firmware de las VMs"
}

variable "vm_vcpu" {
  type        = string
  description = "La cantidad de procesadores que se asignarán a las VMs"
  default     = "2"
}

variable "vm_memory" {
  type        = string
  description = "La cantidad de memoria que se asignaran a las VMs (MB) "
  default     = "1024"
}

variable "vm_domain" {
  type        = string
  description = "Nombre de Dominio"
}

variable "vm_dns_servers" {
  type        = list(string)
  description = "Lista de servidores DNS"
}

variable "vm_ipv4_netmask" {
  type        = string
  description = "Mascara de subred IPv4"
}

variable "vm_ipv4_gateway" {
  type        = string
  description = "Gateway de las VMs"
}

variable "vm_disk_label" {
  type        = string
  description = "Etiqueta para los discos de las VMs"
}

variable "vm_disk_size" {
  type        = string
  description = "Tamano de discos de las VMs (GB)"
}

variable "vm_disk_thin" {
  type        = string
  description = "Tipo de disco de las VMs"
}