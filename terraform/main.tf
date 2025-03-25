provider "azurerm" {
    features {
      
    }
    subscription_id = "8204b7b3-f73c-4b85-95ac-d9ae27a9e877"
  
}

resource "azurerm_resource_group" "rg" {
    name = "devops-rg"
    location = "East US"
  
}

resource "azurerm_kubernetes_cluster" "aks" {
    name = "devops-aks"
    location = azurerm_resource_group.rg.location
    resource_group_name = azurerm_resource_group.rg.name
    dns_prefix = "devopsaks"

    default_node_pool {
      name = "default"
      node_count = 2
      vm_size = "Standard_D2s_v3"
    }

    identity {
      type = "SystemAssigned"
    }
}

resource "azurerm_postgresql_flexible_server" "db" {
    name = "devops-db"
    resource_group_name = azurerm_resource_group.rg.name
    location = azurerm_resource_group.rg.location
    version = "16"
    administrator_login = "adminuser"
    administrator_password = "SuperSecret123!"
    sku_name = "GP_Standard_D4ds_v5"
  
}