provider "azurerm" {
    features {}
}

terraform {
    backend "azurerm" {
        resource_group_name  = "TerraformStorage"
        storage_account_name = "terraformaoliynyk"
        container_name       = "weatherapi"
        key                  = "terraform.tfstate"
    }
}

variable "imagebuild" {
  type        = string
  default     = "latest"
  description = "Latest Image Build"
}



resource "azurerm_resource_group" "this" {
  name     = "weatherapi"
  location = "East US"
}

resource "azurerm_container_group" "this" {
  name                      = "weatherapi"
  location                  = azurerm_resource_group.this.location
  resource_group_name       = azurerm_resource_group.this.name

  ip_address_type     = "public"
  dns_name_label      = "aoliynykwa"
  os_type             = "Linux"

  container {
      name            = "weatherapi"
      image           = "aoliynyk/weatherapi:${var.imagebuild}"
        cpu             = "1"
        memory          = "1"

        ports {
            port        = 80
            protocol    = "TCP"
        }
  }
}