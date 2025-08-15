resource "random_id" "unique_suffix" {
  byte_length = 4
}

resource "azurerm_resource_group" "devops" {
  name     = "prod-website-devops-${random_id.unique_suffix.hex}-rg"
  location = var.resource_group_location
}

resource "azurerm_service_plan" "devops" {
  name                = "prod-website-devops-${random_id.unique_suffix.hex}-plan"
  resource_group_name = azurerm_resource_group.devops.name
  location            = var.resource_group_location
  os_type             = "Linux"
  sku_name            = "F1"
}

resource "azurerm_linux_web_app" "devops" {
  name                = "prod-website-devops-${random_id.unique_suffix.hex}-app"
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

resource "local_file" "app_details" {
  content = <<-EOT
    app_name=${azurerm_linux_web_app.devops.name}
    group_name=${azurerm_resource_group.devops.name}
  EOT
  filename = "${path.module}/app_details.txt"
}