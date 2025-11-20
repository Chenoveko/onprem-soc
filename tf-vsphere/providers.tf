# Terraform block
terraform {
  required_version = "~> 1.13.5" # Acepta cualquier versión >= 1.13.5 y < 1.14.0.
  required_providers {
    vsphere = {
      source  = "vmware/vsphere"
      version = "2.15.0" # Acepta solo versión 2.15.0
    }
  }
}

# Providers block
provider "vsphere" {
  user                 = var.vsphere_user
  password             = var.vsphere_password
  vsphere_server       = var.vsphere_server
  allow_unverified_ssl = true
  api_timeout          = 10
}