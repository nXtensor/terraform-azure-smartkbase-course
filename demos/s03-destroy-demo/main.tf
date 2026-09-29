resource "azurerm_resource_group" "destroy_demo" {
  name     = "rg-tfaz-destroy-demo"
  location = "eastus"

  tags = {
    purpose    = "s03-destroy-demo"
    managed_by = "terraform"
  }
}
