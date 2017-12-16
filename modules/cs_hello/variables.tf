variable "cloudstack_api_url" {
  type = "string"

  description = <<EOF
CloudStack authentication URL for the API
EOF
}

variable "cloudstack_api_key" {
  type = "string"

  description = <<EOF
API Key to use for calling CloudStack API.
EOF
}

variable "cloudstack_secret_key" {
  type = "string"

  description = <<EOF
CloudStack Secret Key for API
EOF
}

variable "cloudstack_service_offering" {
  type = "string"

  description = <<EOF
Service Offering for instance
EOF
}

variable "cloudstack_network_id" {
  type = "string"

  description = <<EOF
Network ID for instance
EOF
}

variable "cloudstack_template" {
  type = "string"

  description = <<EOF
Template for instance
EOF
}

variable "cloudstack_zone" {
  type = "string"

  description = <<EOF
Zone for instance
EOF
}
