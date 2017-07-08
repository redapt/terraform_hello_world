provider "openstack" {
  # assumes OS environment variables
  auth_url = "${ var.os_auth_url }"
}

resource "openstack_networking_port_v2" "ips" {
  count = "${ var.cluster_size }"
  name = "hello-${ count.index+1 }"
  security_group_ids = "${ var.security_group_ids }"
  network_id = "${ var.network_id }"
  admin_state_up = "true"
}

resource "openstack_compute_keypair_v2" "keypair" {
  name = "${ var.ssh_key_pair_name }"
  public_key = "${ file(var.public_key_file) }"
}

resource "openstack_compute_instance_v2" "hello_cluster" {
  count = "${ var.cluster_size }"
  name = "hello-${ count.index + 1 }"
  region = "${ var.region }"
  image_name = "${ var.image_name }"
  flavor_name = "${ var.flavor_name }"
  key_pair = "${ var.ssh_key_pair_name }"

  network {
    port = "${ element(openstack_networking_port_v2.ips.*.id, count.index+1) }"
  }

  user_data = "${ element(data.template_file.cloud-config.*.rendered, count.index) }"
}
