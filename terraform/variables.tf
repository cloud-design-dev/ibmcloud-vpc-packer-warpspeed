variable "ibm_image" {}

variable "vpc" {
  default = ""
}

variable "instance_subnet" {
  default = "backend-zone-1-subnet"
}

variable "instance_security_group" {
  default = "base-lab-vpc-backend-sg"
}

variable "vpc_name" {}

variable "resource_group" {
  default = ""
}

variable "ssh_key_name" {
  default = ""
}

variable "region" {
  default = ""
}

variable "tags" {
  default = ["warpspeed"]
}