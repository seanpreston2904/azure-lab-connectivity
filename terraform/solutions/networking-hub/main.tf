resource "azurerm_resource_group" "rg_conectivity_hub_aue" {
  name     = "rg-connectivity-hub-aue"
  location = "Australia east"
}

resource "azurerm_virtual_network" "vnet_connectivity_hub_aue" {
  name                = "vnet-connectivity-hub-aue"
  address_space       = ["10.0.1.0/24"]
  location            = azurerm_resource_group.rg_conectivity_hub_aue.location
  resource_group_name = azurerm_resource_group.rg_conectivity_hub_aue.name
}

resource "azurerm_subnet" "sub_connectivity_hub_aue" {
  name = "sub-connectivity-hub-aue"

  resource_group_name  = azurerm_resource_group.rg_conectivity_hub_aue.name
  virtual_network_name = azurerm_virtual_network.vnet_connectivity_hub_aue.name

  address_prefixes = ["10.0.1.0/27"]
}

resource "azurerm_virtual_network_peering" "hub_to_spoke" {
  for_each = local.vnet_peerings

  name                         = "peer-hub-to-${trimprefix(each.value.remote_virtual_network_name, "vnet-")}"
  resource_group_name          = azurerm_resource_group.rg_conectivity_hub_aue.name
  virtual_network_name         = azurerm_virtual_network.vnet_connectivity_hub_aue.name
  remote_virtual_network_id    = each.value.remote_virtual_network_id
  allow_virtual_network_access = true
  allow_forwarded_traffic      = true
}

resource "azurerm_virtual_network_peering" "spoke_to_hub" {
  for_each = local.vnet_peerings

  name                         = "peer-${trimprefix(each.value.remote_virtual_network_name, "vnet-")}-to-hub"
  resource_group_name          = each.value.remote_virtual_network_rg
  virtual_network_name         = each.value.remote_virtual_network_name
  remote_virtual_network_id    = azurerm_virtual_network.vnet_connectivity_hub_aue.id
  allow_virtual_network_access = true
  allow_forwarded_traffic      = true
}