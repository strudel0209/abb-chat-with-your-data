param privateDnsZoneName string
param privateDnsZoneLinkName string
param vnetId string
param subnetId string
param resourceIds string[]
param resourceNames string[]
param groupIds string[]
param location string
param tags object

resource privateDnsZone 'Microsoft.Network/privateDnsZones@2020-06-01' = {
  name: privateDnsZoneName
  tags: tags
  location: 'global'

  resource link 'virtualNetworkLinks' = {
    name: privateDnsZoneLinkName
    tags: tags
    location: 'global'
    properties: {
      registrationEnabled: false
      virtualNetwork: { id: vnetId }
    }
  }
}

module privateEndpoints 'private-endpoint.bicep' = [for (item, index) in resourceIds: {
  name: '${resourceNames[index]}-link'
  params: {
    location: location
    tags: tags
    groupIds: groupIds
    privateDnsZoneId: privateDnsZone.id
    resourceId: item
    resourceName: resourceNames[index]
    subnetId: subnetId
  }
}]
