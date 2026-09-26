provider "azurerm" {
  features {}

  # AzureRM 5.x does not register resource providers for you.
  # Register Microsoft.Resources once with Azure CLI (see the README).
  resource_provider_registrations = "none"

  # Replace this placeholder with your sandbox subscription id:
  #   az account show --query id --output tsv
  # Do not commit a real subscription id to a public repository.
  # Do not use a company production subscription for this lab.
  subscription_id = "00000000-0000-0000-0000-000000000000"
}
