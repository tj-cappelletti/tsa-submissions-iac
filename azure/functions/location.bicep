@description('Gets the display name for a location.')
@export()
func getLocationDisplayName(location string) string => getLocations()[location].displayName

@description('Gets the short code for a location.')
@export()
func getLocationShortCode(location string) string => getLocations()[location].shortCode

@description('Gets the locations that resources can be deployed to.')
@export()
func getLocations() object => {
  centralus: {
    displayName: 'Central US'
    shortCode: 'cus'
  }
  eastus: {
    displayName: 'East US'
    shortCode: 'eus'
  }
  eastus2: {
    displayName: 'East US 2'
    shortCode: 'eus2'
  }
  northcentralus: {
    displayName: 'North Central US'
    shortCode: 'ncus'
  }
  southcentralus: {
    displayName: 'South Central US'
    shortCode: 'scus'
  }
  westcentralus: {
    displayName: 'West Central US'
    shortCode: 'wcus'
  }
  westus: {
    displayName: 'West US'
    shortCode: 'wus'
  }
  westus2: {
    displayName: 'West US 2'
    shortCode: 'wus2'
  }
}
