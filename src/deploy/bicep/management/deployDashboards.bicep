@description('Deploy Azure Inventory Dashboard')
resource AzureInventory 'Microsoft.Portal/dashboards@2020-09-01-preview' = {
  name: 'AzureInventory'
  location: resourceGroup().location
  properties: {
    lenses: [
      {
        order: 0
        parts: [
          {
            position: {
              x: 0
              y: 0
              colSpan: 18
              rowSpan: 1
            }
            metadata: {
              inputs: []
              type: 'Extension/HubsExtension/PartType/MarkdownPart'
              settings: {
                content: {
                  settings: {
                    content: '<div style=\'line-height:50px;\'>\n<span style=\'font-size:16px;font-weight:bold\'>AZURE RESOURCE INVENTORY - </span>\n<span>This section gives you an overview of all your Azure resources across all subscriptions that you can access.</span>\n</div>'
                    title: ''
                    subtitle: ''
                    markdownUri: null
                  }
                }
              }
            }
          }
          {
            position: {
              x: 0
              y: 1
              colSpan: 3
              rowSpan: 4
            }
            metadata: {
              inputs: [
                {
                  name: 'partTitle'
                  value: 'Count of all my Azure resources'
                }
                {
                  name: 'query'
                  value: 'summarize Resources=count()'
                }
                {
                  name: 'chartType'
                  isOptional: true
                }
              ]
              type: 'Extension/HubsExtension/PartType/MarkdownPart'
              settings: {}
            }
          }
          {
            position: {
              x: 3
              y: 1
              colSpan: 15
              rowSpan: 4
            }
            metadata: {
              inputs: [
                {
                  name: 'partTitle'
                  value: 'Top 10 resource counts by type'
                }
                {
                  name: 'query'
                  value: 'summarize ResourceCount=count() by type\r\n| order by ResourceCount\r\n| extend [\'Resource count\']=ResourceCount, [\'Resource type\']=type\r\n| project [\'Resource type\'], [\'Resource count\']\r\n| take 10'
                }
                {
                  name: 'chartType'
                  value: 1
                }
              ]
              type: 'Extension/HubsExtension/PartType/MarkdownPart'
              settings: {}
            }
          }
          {
            position: {
              x: 0
              y: 5
              colSpan: 18
              rowSpan: 1
            }
            metadata: {
              inputs: []
              type: 'Extension/HubsExtension/PartType/MarkdownPart'
              settings: {
                content: {
                  settings: {
                    content: '<div style=\'line-height:50px\'>\r\n<span style=\'font-size:16px;font-weight:bold\'>AZURE COMPUTE INVENTORY - </span>\r\n<span>This section gives you an overview of your Azure Compute usage.</span>\r\n</div>'
                    title: ''
                    subtitle: ''
                    markdownUri: null
                  }
                }
              }
            }
          }
          {
            position: {
              x: 0
              y: 6
              colSpan: 4
              rowSpan: 3
            }
            metadata: {
              inputs: [
                {
                  name: 'partTitle'
                  value: 'Virtual machines count (includes classic)'
                }
                {
                  name: 'query'
                  value: 'where type == "microsoft.compute/virtualmachines" or type=="microsoft.classiccompute/virtualmachines"\r\n| summarize VMCount=count()\r\n| extend [\'Count (Virtual Machines)\']=VMCount\r\n| project [\'Count (Virtual Machines)\']'
                }
                {
                  name: 'chartType'
                  isOptional: true
                }
              ]
              type: 'Extension/HubsExtension/PartType/MarkdownPart'
              settings: {}
            }
          }
          {
            position: {
              x: 4
              y: 6
              colSpan: 4
              rowSpan: 3
            }
            metadata: {
              inputs: [
                {
                  name: 'partTitle'
                  value: 'Virtual machines by operating system'
                }
                {
                  name: 'query'
                  value: 'where type == "microsoft.compute/virtualmachines" or type == "microsoft.classiccompute/virtualmachines"\r\n| extend OSType = iff(type == "microsoft.compute/virtualmachines", tostring(properties.storageProfile.osDisk.osType),tostring(properties.storageProfile.operatingSystemDisk.operatingSystem)) \r\n| summarize VMCount=count() by OSType\r\n| order by VMCount desc\r\n|extend [\'Count (Virtual Machines)\']=VMCount\r\n| project OSType, [\'Count (Virtual Machines)\']'
                }
                {
                  name: 'chartType'
                  value: 1
                }
              ]
              type: 'Extension/HubsExtension/PartType/MarkdownPart'
              settings: {}
            }
          }
          {
            position: {
              x: 8
              y: 6
              colSpan: 6
              rowSpan: 3
            }
            metadata: {
              inputs: [
                {
                  name: 'partTitle'
                  value: 'Virtual machines by family'
                }
                {
                  name: 'query'
                  value: 'where type == "microsoft.compute/virtualmachines" or type == "microsoft.classiccompute/virtualmachines"\r\n| extend Size = iff(type == "microsoft.compute/virtualmachines", tostring(properties.hardwareProfile.vmSize),  tostring(properties.hardwareProfile.size))\r\n| extend Family = extract(\'([^_]+)_\', 1, Size, typeof(string))\r\n| extend Family = iff(strlen(Family) == 0, Size, Family)\r\n| summarize VMCount=count() by Family\r\n| order by VMCount desc\r\n|extend [\'Count (Virtual Machines)\']=VMCount\r\n| project Family, [\'Count (Virtual Machines)\']'
                }
                {
                  name: 'chartType'
                  value: 1
                }
              ]
              type: 'Extension/HubsExtension/PartType/MarkdownPart'
              settings: {}
            }
          }
          {
            position: {
              x: 14
              y: 6
              colSpan: 4
              rowSpan: 3
            }
            metadata: {
              inputs: [
                {
                  name: 'partTitle'
                  value: 'Count of virtual machines by type'
                }
                {
                  name: 'query'
                  value: 'where type == "microsoft.compute/virtualmachines" or type=="microsoft.classiccompute/virtualmachines"\r\n| summarize VMCount=count() by type\r\n| extend [\'Count (Virtual Machines)\']=VMCount\r\n| extend Type = iff(type == "microsoft.compute/virtualmachines", "Resource Manager", "Classic")\r\n| project Type,[\'Count (Virtual Machines)\']'
                }
                {
                  name: 'chartType'
                  value: 1
                }
              ]
              type: 'Extension/HubsExtension/PartType/MarkdownPart'
              settings: {}
            }
          }
          {
            position: {
              x: 0
              y: 9
              colSpan: 18
              rowSpan: 1
            }
            metadata: {
              inputs: []
              type: 'Extension/HubsExtension/PartType/MarkdownPart'
              settings: {
                content: {
                  settings: {
                    content: '<div style=\'line-height:50px\'>\n<span style=\'font-size:16px;font-weight:bold\'>AZURE STORAGE INVENTORY - </span>\n<span>This section gives you an overview of your Azure Storage usage.</span>\n</div>'
                    title: ''
                    subtitle: ''
                    markdownUri: null
                  }
                }
              }
            }
          }
          {
            position: {
              x: 0
              y: 10
              colSpan: 6
              rowSpan: 3
            }
            metadata: {
              inputs: [
                {
                  name: 'partTitle'
                  value: 'Count of storage accounts by status'
                }
                {
                  name: 'query'
                  value: ' where type == "microsoft.storage/storageaccounts"\r\n | summarize StorageCount=count() by PrimaryStatus=tostring(properties.statusOfPrimary), SecondaryStatus=tostring(properties.statusOfSecondary)\r\n | extend SecondaryStatus= iff(strlen(SecondaryStatus) == 0, "No secondary", SecondaryStatus)\r\n | extend [\'Count (Storage accounts)\']=StorageCount\r\n | project-away StorageCount'
                }
                {
                  name: 'chartType'
                  isOptional: true
                }
              ]
              type: 'Extension/HubsExtension/PartType/MarkdownPart'
              settings: {}
            }
          }
          {
            position: {
              x: 6
              y: 10
              colSpan: 3
              rowSpan: 3
            }
            metadata: {
              inputs: [
                {
                  name: 'partTitle'
                  value: 'Sum of all disk sizes (GB)'
                }
                {
                  name: 'query'
                  value: 'where type == "microsoft.compute/disks"\r\n| extend SizeGB = tolong(properties.diskSizeGB)\r\n| summarize [\'Total Disk Size (GB)\']=sum(SizeGB)'
                }
                {
                  name: 'chartType'
                  isOptional: true
                }
              ]
              type: 'Extension/HubsExtension/PartType/MarkdownPart'
              settings: {}
            }
          }
          {
            position: {
              x: 9
              y: 10
              colSpan: 5
              rowSpan: 3
            }
            metadata: {
              inputs: [
                {
                  name: 'partTitle'
                  value: 'Disks (count) by disk state'
                }
                {
                  name: 'query'
                  value: 'where type == "microsoft.compute/disks"\r\n| summarize DiskCount=count() by State=tostring(properties.diskState)\r\n| order by DiskCount desc\r\n| extend ["Count (Disks)"]=DiskCount\r\n| project State, ["Count (Disks)"]'
                }
                {
                  name: 'chartType'
                  value: 1
                }
              ]
              type: 'Extension/HubsExtension/PartType/MarkdownPart'
              settings: {}
            }
          }
          {
            position: {
              x: 14
              y: 10
              colSpan: 4
              rowSpan: 3
            }
            metadata: {
              inputs: [
                {
                  name: 'partTitle'
                  value: 'Count of storage accounts by type'
                }
                {
                  name: 'query'
                  value: 'where type == "microsoft.storage/storageaccounts" or type=="microsoft.classicstorage/storageaccounts"\r\n| summarize StorageCount=count() by type\r\n| extend [\'Count (Storage Accounts)\']=StorageCount\r\n| extend Type = iff(type == "microsoft.storage/storageaccounts", "Resource Manager", "Classic")\r\n| project Type,[\'Count (Storage Accounts)\']'
                }
                {
                  name: 'chartType'
                  value: 1
                }
              ]
              type: 'Extension/HubsExtension/PartType/MarkdownPart'
              settings: {}
            }
          }
          {
            position: {
              x: 0
              y: 13
              colSpan: 18
              rowSpan: 1
            }
            metadata: {
              inputs: []
              type: 'Extension/HubsExtension/PartType/MarkdownPart'
              settings: {
                content: {
                  settings: {
                    content: '<div style=\'line-height:50px\'>\r\n<span style=\'font-size:16px;font-weight:bold\'>AZURE NETWORKING INVENTORY - </span>\r\n<span>This section gives you an overview of your Azure networking usage.</span>\r\n</div>'
                    title: ''
                    subtitle: ''
                    markdownUri: null
                  }
                }
              }
            }
          }
          {
            position: {
              x: 0
              y: 14
              colSpan: 4
              rowSpan: 3
            }
            metadata: {
              inputs: [
                {
                  name: 'partTitle'
                  value: 'Count of virtual networks (includes classic)'
                }
                {
                  name: 'query'
                  value: 'where type == "microsoft.network/virtualnetworks"or type == "microsoft.classicnetwork/virtualnetworks"\r\n| summarize [\'Virtual networks\']=count()'
                }
                {
                  name: 'chartType'
                  isOptional: true
                }
              ]
              type: 'Extension/HubsExtension/PartType/MarkdownPart'
              settings: {}
            }
          }
          {
            position: {
              x: 4
              y: 14
              colSpan: 3
              rowSpan: 3
            }
            metadata: {
              inputs: [
                {
                  name: 'partTitle'
                  value: 'Count of network interfaces'
                }
                {
                  name: 'query'
                  value: 'where type == "microsoft.network/networkinterfaces"\r\n| summarize [\'Network interfaces\']=count()'
                }
                {
                  name: 'chartType'
                  isOptional: true
                }
              ]
              type: 'Extension/HubsExtension/PartType/MarkdownPart'
              settings: {}
            }
          }
          {
            position: {
              x: 7
              y: 14
              colSpan: 3
              rowSpan: 3
            }
            metadata: {
              inputs: [
                {
                  name: 'partTitle'
                  value: 'Total public IPs'
                }
                {
                  name: 'query'
                  value: 'where type == "microsoft.network/publicipaddresses"\r\n| summarize [\'Number of public IP addresses\']=count()'
                }
                {
                  name: 'chartType'
                  isOptional: true
                }
              ]
              type: 'Extension/HubsExtension/PartType/MarkdownPart'
              settings: {}
            }
          }
          {
            position: {
              x: 10
              y: 14
              colSpan: 8
              rowSpan: 3
            }
            metadata: {
              inputs: [
                {
                  name: 'partTitle'
                  value: 'Virtual networks by type'
                }
                {
                  name: 'query'
                  value: 'where type == "microsoft.network/virtualnetworks" or type=="microsoft.classicnetwork/virtualnetworks"\r\n| summarize VNetCount=count() by type\r\n| extend [\'Count (Virtual Networks)\']=VNetCount\r\n| extend Type = iff(type == "microsoft.network/virtualnetworks", "Resource Manager", "Classic")\r\n| project Type,[\'Count (Virtual Networks)\']'
                }
                {
                  name: 'chartType'
                  value: 1
                }
              ]
              type: 'Extension/HubsExtension/PartType/MarkdownPart'
              settings: {}
            }
          }
          {
            position: {
              x: 0
              y: 17
              colSpan: 18
              rowSpan: 1
            }
            metadata: {
              inputs: []
              type: 'Extension/HubsExtension/PartType/MarkdownPart'
              settings: {
                content: {
                  settings: {
                    content: '<div style=\'line-height:50px\'>\r\n<span style=\'font-size:16px;font-weight:bold\'>AZURE SQL DATABASES INVENTORY - </span>\r\n<span>This section gives you an overview of your Azure SQL database usage.</span>\r\n</div>'
                    title: ''
                    subtitle: ''
                    markdownUri: null
                  }
                }
              }
            }
          }
          {
            position: {
              x: 0
              y: 18
              colSpan: 3
              rowSpan: 3
            }
            metadata: {
              inputs: [
                {
                  name: 'partTitle'
                  value: 'Count of SQL databases'
                }
                {
                  name: 'query'
                  value: 'where type == "microsoft.sql/servers/databases"\r\n| summarize DBCount=count()'
                }
                {
                  name: 'chartType'
                  isOptional: true
                }
              ]
              type: 'Extension/HubsExtension/PartType/MarkdownPart'
              settings: {}
            }
          }
          {
            position: {
              x: 3
              y: 18
              colSpan: 6
              rowSpan: 3
            }
            metadata: {
              inputs: [
                {
                  name: 'partTitle'
                  value: 'SQL databases (count) by tier'
                }
                {
                  name: 'query'
                  value: 'where type == "microsoft.sql/servers/databases"\r\n| summarize DBCount=count() by Tier=tostring(properties.currentSku.tier)\r\n| order by DBCount desc\r\n|extend [\'Count (SQL Databases)\']=DBCount\r\n| project Tier, [\'Count (SQL Databases)\']'
                }
                {
                  name: 'chartType'
                  value: 1
                }
              ]
              type: 'Extension/HubsExtension/PartType/MarkdownPart'
              settings: {}
            }
          }
          {
            position: {
              x: 9
              y: 18
              colSpan: 9
              rowSpan: 3
            }
            metadata: {
              inputs: [
                {
                  name: 'partTitle'
                  value: 'SQL databases (count) by max size (GB)'
                }
                {
                  name: 'query'
                  value: 'where type == "microsoft.sql/servers/databases"\r\n| extend GB = todouble(properties.maxSizeBytes) / (1024 * 1024 * 1024)\r\n| summarize DBCount=count() by GB\r\n| order by GB desc\r\n|extend [\'Count (SQL Databases)\']=DBCount\r\n| project GB=strcat(tostring(GB), " GB"), [\'Count (SQL Databases)\']'
                }
                {
                  name: 'chartType'
                  value: 1
                }
              ]
              type: 'Extension/HubsExtension/PartType/MarkdownPart'
              settings: {}
            }
          }
          {
            position: {
              x: 0
              y: 21
              colSpan: 18
              rowSpan: 1
            }
            metadata: {
              inputs: []
              type: 'Extension/HubsExtension/PartType/MarkdownPart'
              settings: {
                content: {
                  settings: {
                    content: '<div style=\'line-height:50px\'>\r\n<span style=\'font-size:16px;font-weight:bold\'>APP SERVICE INVENTORY - </span>\r\n<span>This section gives you an overview of your Azure App Service usage.</span>\r\n</div>'
                    title: ''
                    subtitle: ''
                    markdownUri: null
                  }
                }
              }
            }
          }
          {
            position: {
              x: 0
              y: 22
              colSpan: 3
              rowSpan: 3
            }
            metadata: {
              inputs: [
                {
                  name: 'partTitle'
                  value: 'Count of AppService apps'
                }
                {
                  name: 'query'
                  value: 'where type == "microsoft.web/sites"\r\n| summarize SiteCount=count() \r\n|extend [\'Count (AppService Apps)\']=SiteCount\r\n| project [\'Count (AppService Apps)\']'
                }
                {
                  name: 'chartType'
                  isOptional: true
                }
              ]
              type: 'Extension/HubsExtension/PartType/MarkdownPart'
              settings: {}
            }
          }
          {
            position: {
              x: 3
              y: 22
              colSpan: 3
              rowSpan: 3
            }
            metadata: {
              inputs: [
                {
                  name: 'partTitle'
                  value: 'Count of AppService plans'
                }
                {
                  name: 'query'
                  value: 'where type == "microsoft.web/serverfarms"\r\n| summarize serverFarmCount=count() \r\n|extend [\'Count (AppService plans)\']=serverFarmCount\r\n| project [\'Count (AppService plans)\']'
                }
                {
                  name: 'chartType'
                  isOptional: true
                }
              ]
              type: 'Extension/HubsExtension/PartType/MarkdownPart'
              settings: {}
            }
          }
          {
            position: {
              x: 6
              y: 22
              colSpan: 4
              rowSpan: 3
            }
            metadata: {
              inputs: [
                {
                  name: 'partTitle'
                  value: 'AppService Apps by status'
                }
                {
                  name: 'query'
                  value: 'where type == "microsoft.web/sites"\r\n| summarize SiteCount=count() by Status=tostring(properties.state) \r\n| order by SiteCount desc\r\n|extend [\'Count (AppService Apps)\']=SiteCount\r\n| project Status, [\'Count (AppService Apps)\']'
                }
                {
                  name: 'chartType'
                  value: 1
                }
              ]
              type: 'Extension/HubsExtension/PartType/MarkdownPart'
              settings: {}
            }
          }
          {
            position: {
              x: 10
              y: 22
              colSpan: 8
              rowSpan: 3
            }
            metadata: {
              inputs: [
                {
                  name: 'partTitle'
                  value: 'AppService apps by kind'
                }
                {
                  name: 'query'
                  value: 'where type == "microsoft.web/sites"\r\n| summarize SiteCount=count() by kind \r\n| order by SiteCount desc\r\n|extend [\'Count (AppService Apps)\']=SiteCount\r\n| project Kind=kind, [\'Count (AppService Apps)\']'
                }
                {
                  name: 'chartType'
                  value: 1
                }
              ]
              type: 'Extension/HubsExtension/PartType/MarkdownPart'
              settings: {}
            }
          }
        ]
      }
    ]
    metadata: {}
  }
}

output AzureInventoryId string = AzureInventory.id
output AzureInventoryName string = AzureInventory.name
output AzureInventoryType string = AzureInventory.type

