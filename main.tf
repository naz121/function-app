resource "azurerm_resource_group" "test5" {
  name     = "azure-functions-test55-rg"
  location = "westus2"
}

resource "azurerm_storage_account" "test5" {
  name                     = "functionsapptest5sa"
  resource_group_name      = "${azurerm_resource_group.test5.name}"
  location                 = "${azurerm_resource_group.test5.location}"
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_app_service_plan" "test5" {
  name                = "azure-functions-test5-service-plan"
  location            = "${azurerm_resource_group.test5.location}"
  resource_group_name = "${azurerm_resource_group.test5.name}"

  sku {
    tier = "Standard"
    size = "S1"
  }
}

resource "azurerm_function_app" "test5" {
  name                      = "test5-azure-functions"
  location                  = "${azurerm_resource_group.test5.location}"
  resource_group_name       = "${azurerm_resource_group.test5.name}"
  app_service_plan_id       = "${azurerm_app_service_plan.test5.id}"
  storage_connection_string = "${azurerm_storage_account.test5.primary_connection_string}"
}
