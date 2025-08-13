
resource "azurerm_resource_group" "example" {
  name     = "stage-website-rg"
  location = var.resource_group_location
}

resource "azurerm_service_plan" "example" {
  name                = "stage-website-plan"
  resource_group_name = azurerm_resource_group.example.name
  location            = var.resource_group_location
  os_type             = "Linux"
  sku_name            = "F1"
}

resource "azurerm_linux_web_app" "example" {
  name                = "stage-website"
  resource_group_name = azurerm_resource_group.example.name
  location            = var.resource_group_location
  service_plan_id     = azurerm_service_plan.example.id

  site_config {
    always_on = false
    ftps_state = "FtpsOnly"
  }
}