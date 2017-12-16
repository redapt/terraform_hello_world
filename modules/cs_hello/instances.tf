provider "cloudstack" {
  api_url    = "${var.cloudstack_api_url}"
  api_key    = "${var.cloudstack_api_key}"
  secret_key = "${var.cloudstack_secret_key}"
}

resource "cloudstack_instance" "hello" {
  name             = "hello-world"
  service_offering = "${var.cloudstack_service_offering}"
  network_id       = "${var.cloudstack_network_id}"
  template         = "${var.cloudstack_template}"
  zone             = "${var.cloudstack_zone}"
}
