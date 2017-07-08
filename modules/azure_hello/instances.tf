provider "azurerm" {
  subscription_id = "${ var.azure_subscription_id }"
  client_id       = "${ var.azure_client_id }"
  client_secret   = "${ var.azure_client_secret }"
  tenant_id       = "${ var.azure_tenant_id }"
}

resource "azurerm_resource_group" "rg_paul_hello" {
    name = "rg_paul_hello"
    location = "West US"
}

resource "azurerm_virtual_network" "net_paul_hello" {
    name = "paulvn"
    address_space = ["10.0.0.0/16"]
    location = "West US"
    resource_group_name = "${azurerm_resource_group.rg_paul_hello.name}"
}

resource "azurerm_subnet" "paul_hello_subnet" {
    name = "paulsub"
    resource_group_name = "${azurerm_resource_group.rg_paul_hello.name}"
    virtual_network_name = "${azurerm_virtual_network.net_paul_hello.name}"
    address_prefix = "10.0.2.0/24"
}

resource "azurerm_public_ip" "paul_hello_ips" {
    name = "paul_hello_ip"
    location = "West US"
    resource_group_name = "${azurerm_resource_group.rg_paul_hello.name}"
    public_ip_address_allocation = "dynamic"

    tags {
        environment = "HelloWorld"
    }
}

resource "azurerm_network_interface" "paul_hello_nic" {
    name = "paulni"
    location = "West US"
    resource_group_name = "${azurerm_resource_group.rg_paul_hello.name}"

    ip_configuration {
        name = "cfg1"
        subnet_id = "${azurerm_subnet.paul_hello_subnet.id}"
        private_ip_address_allocation = "static"
        private_ip_address = "10.0.2.5"
        public_ip_address_id = "${azurerm_public_ip.paul_hello_ips.id}"
    }
}

resource "azurerm_storage_account" "pauldemo" {
    name = "pauldemo10101"
    resource_group_name = "${azurerm_resource_group.rg_paul_hello.name}"
    location = "westus"
    account_type = "Standard_LRS"

    tags {
        environment = "staging"
    }
}

# create storage container
resource "azurerm_storage_container" "paul_demo_container" {
    name = "vhd"
    resource_group_name = "${azurerm_resource_group.rg_paul_hello.name}"
    storage_account_name = "${azurerm_storage_account.pauldemo.name}"
    container_access_type = "private"
    depends_on = ["azurerm_storage_account.pauldemo"]
}

# create virtual machine
resource "azurerm_virtual_machine" "paul_hello_vm" {
    name = "hello_vm"
    location = "West US"
    resource_group_name = "${azurerm_resource_group.rg_paul_hello.name}"
    network_interface_ids = ["${azurerm_network_interface.paul_hello_nic.id}"]
    vm_size = "Standard_A0"

    storage_image_reference {
        publisher = "Canonical"
        offer = "UbuntuServer"
        sku = "14.04.2-LTS"
        version = "latest"
    }

    storage_os_disk {
        name = "myosdisk"
        vhd_uri = "${azurerm_storage_account.pauldemo.primary_blob_endpoint}${azurerm_storage_container.paul_demo_container.name}/myosdisk.vhd"
        caching = "ReadWrite"
        create_option = "FromImage"
    }

    os_profile {
        computer_name = "hello"
        admin_username = "paul"
        admin_password = "${ var.os_admin_password }"
    }

    os_profile_linux_config {
        disable_password_authentication = false
    }

    tags {
        environment = "staging"
    }
}
