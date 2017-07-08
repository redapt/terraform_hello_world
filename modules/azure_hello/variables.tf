variable "azure_subscription_id" {
  type = "string"

  description = <<EOF
Azure Subscription ID.
EOF
}

variable "azure_client_id" {
  type = "string"

  description = <<EOF
Azure Client ID.
EOF
}

variable "azure_client_secret" {
  type = "string"

  description = <<EOF
Azure Client Secret.
EOF
}

variable "azure_tenant_id" {
  type = "string"

  description = <<EOF
Azure Tenant ID.
EOF
}

variable "os_admin_password" {
  type = "string"

  description = <<EOF
Admin password for the vm operating system.
EOF
}
