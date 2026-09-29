resource "azurerm_resource_group" "smartkbase" {
  name     = "rg-smartkbase-learning"
  location = "eastus"

  tags = {
    project     = "smartkbase"
    environment = "development"
    managed_by  = "terraform"
  }
}
