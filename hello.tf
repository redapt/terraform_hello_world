variable "os_cluster_size" { }
variable "os_auth_url" { }
variable "public_key_file" { }
variable "private_key_file" { }
variable "os_region" { }
variable "image_name" { }
variable "flavor_name" { }
variable "ssh_key_pair_name" { }
variable "security_group_ids" { type="list" }
variable "network_id" { }

variable "access_key" { }
variable "secret_key" { }
variable "aws_region" { }

variable "subscription_id" { }
variable "client_id" { }
variable "client_secret" { }
variable "tenant_id" { }
variable "os_admin_password" { }

#####################################################################

module "os_hello" {
  source = "./modules/os_hello"

  public_key_file = "${ var.public_key_file }"
  private_key_file = "${ var.private_key_file }"
  os_auth_url = "${ var.os_auth_url }"
  cluster_size = "${ var.os_cluster_size }"
  region = "${ var.os_region }"
  image_name = "${ var.image_name }"
  flavor_name = "${ var.flavor_name }"
  ssh_key_pair_name = "${ var.ssh_key_pair_name }"
  security_group_ids = "${ var.security_group_ids }"
  network_id = "${ var.network_id }"
}
/*
module "aws_hello" {
  source = "./modules/aws_hello"

  access_key = "${ var.access_key }"
  secret_key = "${ var.secret_key }"
  region     = "${ var.aws_region }"
}

module "azure_hello" {
  source = "./modules/azure_hello"

  azure_subscription_id = "${ var.subscription_id }"
  azure_client_id       = "${ var.client_id }"
  azure_client_secret   = "${ var.client_secret }"
  azure_tenant_id       = "${ var.tenant_id }"
  os_admin_password     = "${ var.os_admin_password }"
}
*/
#####################################################################
output "os_hello_endpoints" {
  value = [ "${ module.os_hello.hello_endpoints }" ]
}
/*
output "aws_hello_endpoints" {
  value = [ "${ module.aws_hello.aws_hello_endpoint }" ]
}

output "azure_hello_endpoints" {
  value = [ "${ module.azure_hello.azure_hello_endpoint }" ]
}
*/
