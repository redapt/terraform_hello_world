data "template_file" "cloud-config" {
  count = "${ var.cluster_size }"

  template = <<EOF
#cloud-config
#the following line is to test interpolation of the network ports attribute in a template -- take out spaces in dollar dollar and uncomment the var to use it
#test line with the IP address: $ $ {host_addr}

---
coreos:
  units:
    - name: docker.service
      command: start

EOF

  vars {
//    host_addr = "${ element(openstack_networking_port_v2.ips.*.all_fixed_ips.0, count.index) }"
  }
}
