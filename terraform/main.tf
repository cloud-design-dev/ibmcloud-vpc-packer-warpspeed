resource "ibm_is_instance" "warpspeed" {
  name                     = "warpspeed-test"
  image                    = data.local_file
  profile                  = "cx2-2x4"
  metadata_service_enabled = true
  resource_group           = data.ibm_resource_group.cde_lab.id

  boot_volume {
    name = "wp-boot-volume"
  }

  primary_network_interface {
    subnet            = data.ibm_is_subnet.subnet.id
    security_groups   = [data.ibm_is_security_group.frontend_sg.id]
    allow_ip_spoofing = true
  }

  user_data = file("./init.yml")
  vpc       = data.ibm_is_vpc.vpc.id
  zone      = "ca-tor-1"
  keys      = [data.ibm_is_ssh_key.region.id]
  tags      = concat(var.tags, ["project:${var.name}", "region:${var.region}", "zone:${data.ibm_is_subnet.subnet.zone}"])
}

resource "ibm_is_floating_ip" "warpspeed" {
  name           = "${var.name}-wg-public-ip"
  target         = ibm_is_instance.warpspeed.primary_network_interface.0.id
  resource_group = data.ibm_resource_group.cde_lab.id
  tags           = concat(var.tags, ["project:${var.name}", "region:${var.region}", "zone:ca-tor-1"])
}
