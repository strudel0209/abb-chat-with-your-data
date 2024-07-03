param subnetId string
param resourceId string
param resourceName string
param privateDnsZoneId string
param groupIds string[]
param location string
param tags object

resource privateEndpoint 'Microsoft.Network/privateEndpoints@2023-05-01' = {
  name: '${resourceName}-conn'
  tags: tags
  location: location
  properties: {
    customNetworkInterfaceName: '${resourceName}-conn-nic'
    subnet: { id: subnetId }
    privateLinkServiceConnections: [
      {
        name: '${resourceName}-conn'
        properties: {
          groupIds: groupIds
          privateLinkServiceId: resourceId
        }
      }
    ]
  }

  resource privateEndpointDns 'privateDnsZoneGroups' = {
    name: '${resourceName}-dns'
    properties: {
      privateDnsZoneConfigs: [
        {
          name: '${resourceName}-dns-config'
          properties: {
            privateDnsZoneId: privateDnsZoneId
          }
        }
      ]
    }
  }
}
