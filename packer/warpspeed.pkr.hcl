packer {
  required_plugins {
    ibmcloud = {
      version = ">=v2.2.0"
      source  = "github.com/IBM/ibmcloud"
    }
  }
}

variable "ibm_api_key" {
  description = "IBM Cloud API Key used to deploy VPC resources."
  type    = string
}

variable "ibm_region" {
  description = "IBM Cloud Region where resources will be deployed."
  type    = string
}


variable "subnet_id" {
  description = "Subnet ID that will be used for VPC image deployment and capture."
  type    = string
}

variable "resource_group_id" {
  description = "ID of the Resource Group that will be used for VPC resources."
  type    = string
}


locals {
  timestamp = regex_replace(timestamp(), "[- TZ:]", "")
  name      = "warpspeed-${local.timestamp}"
}

source "ibmcloud-vpc" "warpspeed" {
  api_key = "${var.ibm_api_key}"
  region  = "${var.ibm_region}"

  subnet_id          = "${var.subnet_id}"
  resource_group_id  = "${var.resource_group_id}"
  security_group_id  = ""
  vsi_base_image_id  = "r038-6955ded7-4d13-40a8-b318-26d9323b12e3"
  vsi_profile        = "cx2-2x4"
  vsi_interface      = "public"
  vsi_user_data_file = ""

  image_name = "${local.name}"

  communicator = "ssh"
  ssh_username = "root"
  ssh_port     = 22
  ssh_timeout  = "15m"

  timeout = "30m"
}

build {
  sources = [
    "source.ibmcloud-vpc.warpspeed",
  ]

  provisioner "file" {
    source      = "./warpspeed-login.sh"
    destination = "/usr/local/bin/warpspeed-login.sh"
  }

  provisioner "file" {
    source      = "./warpspeed-installer.sh"
    destination = "/usr/local/bin/warpspeed-installer.sh"
  }

  provisioner "file" {
    source      = "./root-profile"
    destination = "/root/.profile"
  }

}









