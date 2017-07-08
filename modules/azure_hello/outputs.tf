output "azure_hello_endpoint" {
  value = [ "${ azurerm_public_ip.paul_hello_ips.ip_address }" ]
}
