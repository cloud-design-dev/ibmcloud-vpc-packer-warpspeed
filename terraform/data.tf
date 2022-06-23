data "local_file" "packer_manifest" {
  filename = "../manifest.json"
}

data "ibm_is_vpc" "vpc" {
  name = var.vpc_name
}

data "ibm_resource_group" "group" {
  name = var.resource_group
}

data "ibm_is_subnet" "subnet" {
  name = var.subnet_name
}

data "ibm_is_security_group" "frontend_sg" {
  name = "base-lab-vpc-frontend-sg"
}

data "ibm_is_ssh_key" "region" {
  name = var.ssh_key_name
}

