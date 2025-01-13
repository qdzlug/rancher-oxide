terraform {
  required_providers {
    oxide = {
      source  = "oxidecomputer/oxide"
      version = "0.4.0"
    }
  }

  required_version = ">= 1.0"
}

provider "oxide" {
  # Uses OXIDE_HOST and OXIDE_TOKEN environment variables for authentication
}

data "oxide_project" "rancher" {
  name = var.project_name
}

resource "oxide_vpc" "rancher_vpc" {
  name        = var.vpc_name
  dns_name    = var.dns_name
  description = var.vpc_description
  project_id  = data.oxide_project.rancher.id
}

resource "oxide_disk" "rancher_servers" {
count       = var.instance_count
name        = "${var.instance_prefix}${count.index + 1}-disk"
project_id  = data.oxide_project.rancher.id
description = "Disk for ${var.instance_prefix}${count.index + 1}"
size        = var.disk_size
}

resource "oxide_instance" "rancher_servers" {
count       = var.instance_count
name        = "${var.instance_prefix}${count.index + 1}"
project_id  = data.oxide_project.rancher.id
description = var.description
host_name   = var.host_name
memory      = var.memory
ncpus       = var.ncpus

disk_attachments = [
    oxide_disk.rancher_servers[count.index].id
]

network_interfaces = [
    {
      vpc_id      = oxide_vpc.rancher_vpc.id
      subnet_id   = oxide_vpc.rancher_vpc.id  # Assuming subnet is created automatically with VPC
      description = "Primary network interface for Rancher server"
      name        = "nic-${var.instance_prefix}${count.index + 1}"
    }
  ]

  ssh_public_keys = [var.public_ssh_key]
}

resource "oxide_disk" "load_balancer" {
name        = "${var.lb_instance_name}-disk"
project_id  = data.oxide_project.rancher.id
description = "Disk for load balancer"
size        = var.lb_disk_size
}

resource "oxide_instance" "load_balancer" {
name        = var.lb_instance_name
project_id  = data.oxide_project.rancher.id
description = "Load balancer instance for Rancher"
host_name   = "lb-${var.lb_instance_name}"
memory      = var.lb_memory
ncpus       = var.lb_ncpus

disk_attachments = [
    oxide_disk.load_balancer.id
]

network_interfaces = [
    {
      vpc_id      = oxide_vpc.rancher_vpc.id
      subnet_id   = oxide_vpc.rancher_vpc.id  # Assuming subnet is created automatically with VPC
      description = "Primary network interface for load balancer"
      name        = "nic-${var.lb_instance_name}"
    }
  ]

  ssh_public_keys = [var.public_ssh_key]
}

output "rancher_server_ips" {
  value = [for instance in oxide_instance.rancher_servers : instance.external_ips[0]]
}

output "load_balancer_ip" {
value = tolist(oxide_instance.load_balancer.external_ips)[0]
}
