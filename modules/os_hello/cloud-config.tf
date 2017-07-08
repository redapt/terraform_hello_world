data "template_file" "cloud-config" {
  count = "${ var.cluster_size }"

  template = <<EOF
#cloud-config

---
coreos:
  units:
    - name: docker.service
      command: start

EOF

}
