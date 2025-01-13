variable "project_name" {
  description = "The name of the Oxide project to use"
  type        = string
}

variable "instance_count" {
  description = "Number of instances to create for the Rancher server"
  type        = number
  default     = 1
}

variable "instance_prefix" {
  description = "Prefix for instance names"
  type        = string
  default     = "rancher-"
}

variable "boot_image_id" {
  description = "ID of the boot image to use for instances"
  type        = string
}

variable "public_ssh_key" {
  description = "Public SSH key for instance access"
  type        = string
}

variable "disk_size" {
  description = "Disk size for instances in bytes"
  type        = number
  default     = 137438953472  # 128 GiB
}

variable "memory" {
  description = "Memory for instances in bytes"
  type        = number
  default     = 8589934592  # 8 GiB
}

variable "ncpus" {
  description = "Number of CPUs for instances"
  type        = number
  default     = 4
}

variable "vpc_name" {
  description = "Name of the VPC to create"
  type        = string
  default     = "rancher-vpc"
}

variable "vpc_dns_name" {
  description = "DNS name for the VPC"
  type        = string
  default     = "example.com"
}

variable "vpc_description" {
  description = "Description of the VPC"
  type        = string
  default     = "Rancher VPC"
}

variable "dns_name" {
  description = "DNS name for the VPC"
  type        = string
  default     = "example-dns"
}

variable "lb_instance_name" {
  description = "Name of the load balancer instance"
  type        = string
  default     = "rancher-lb"
}

variable "lb_image_id" {
  description = "ID of the boot image to use for the load balancer"
  type        = string
}

variable "lb_memory" {
  description = "Memory for the load balancer instance in bytes"
  type        = number
  default     = 4294967296  # 4 GiB
}

variable "lb_ncpus" {
  description = "Number of CPUs for the load balancer instance"
  type        = number
  default     = 2
}

variable "lb_disk_size" {
  description = "Disk size for the load balancer instance in bytes"
  type        = number
  default     = 17179869184  # 16 GiB
}

variable "host_name" {
  description = "Host name for the instances"
  type        = string
}

variable "description" {
  description = "Description for the instances"
  type        = string
}
