output "hello_endpoints" {
  value = [ "${cloudstack_instance.hello.ip_address}" ]
}
