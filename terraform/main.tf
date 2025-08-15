
resource "azurerm_resource_group" "devops" {
  name     = "prod-website-devops-rg"
  location = var.resource_group_location
}

resource "azurerm_service_plan" "devops" {
  name                = "prod-website-devops-plan"
  resource_group_name = azurerm_resource_group.devops.name
  location            = var.resource_group_location
  os_type             = "Linux"
  sku_name            = "F1"
}

resource "azurerm_linux_web_app" "devops" {
  name                = "prod-website-devops"
  resource_group_name = azurerm_resource_group.devops.name
  location            = var.resource_group_location
  service_plan_id     = azurerm_service_plan.devops.id

  site_config {
    always_on = false
    ftps_state = "FtpsOnly"
  }
}

output "app-name" {
  value = azurerm_linux_web_app.devops.name
}

output "group-name" {
  value = azurerm_resource_group.devops.name
}