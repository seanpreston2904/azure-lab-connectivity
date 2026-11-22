locals {
    vnet_peerings = {
        hub_to_management = {
            name                         = "peer-hub-to-management"
            remote_virtual_network_rg    = "rg-management-common-aue"
            remote_virtual_network_name  = "vnet-management-common-aue"
            remote_virtual_network_id    = "/subscriptions/6f1637b0-e4cc-4ee8-8574-eb9dc6845692/resourceGroups/rg-management-common-aue/providers/Microsoft.Network/virtualNetworks/vnet-management-common-aue"
        }
    }
}