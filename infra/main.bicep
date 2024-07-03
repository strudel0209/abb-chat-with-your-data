targetScope = 'subscription'

@minLength(1)
@maxLength(20)
@description('Name of the the environment which is used to generate a short unique hash used in all resources.')
param environmentName string

@description('Location for all resources.')
param location string

param resourceToken string = toLower(uniqueString(subscription().id, environmentName, location))

@description('Name of App Service plan')
param hostingPlanName string = 'hosting-plan-${resourceToken}'

@description('The pricing tier for the App Service plan')
@allowed([
  'F1'
  'D1'
  'B1'
  'B2'
  'B3'
  'S1'
  'S2'
  'S3'
  'P1'
  'P2'
  'P3'
  'P4'
])
param hostingPlanSku string = 'B2'

@description('The sku tier for the App Service plan')
@allowed([
  'Free'
  'Shared'
  'Basic'
  'Standard'
  'Premium'
  'PremiumV2'
  'PremiumV3'
])
param skuTier string = 'Basic'

@description('Name of Web App')
param websiteName string = 'web-${resourceToken}'

@description('Name of Admin Web App')
param adminWebsiteName string = '${websiteName}-admin'

@description('Name of Application Insights')
param applicationInsightsName string = 'appinsights-${resourceToken}'

@description('Name of the Workbook')
param workbookDisplayName string = 'workbook-${resourceToken}'

@description('Use semantic search')
param azureSearchUseSemanticSearch string = 'false'

@description('Semantic search config')
param azureSearchSemanticSearchConfig string = 'default'

@description('Is the index prechunked')
param azureSearchIndexIsPrechunked string = 'false'

@description('Top K results')
param azureSearchTopK string = '5'

@description('Enable in domain')
param azureSearchEnableInDomain string = 'false'

@description('Content columns')
param azureSearchContentColumns string = 'content'

@description('Filename column')
param azureSearchFilenameColumn string = 'filename'

@description('Search filter')
param azureSearchFilter string = ''

@description('Title column')
param azureSearchTitleColumn string = 'title'

@description('Url column')
param azureSearchUrlColumn string = 'url'

@description('Use Azure Search Integrated Vectorization (Not yet implemented)')
@allowed([
  false
])
param azureSearchUseIntegratedVectorization bool = false

@description('Name of Azure OpenAI Resource')
param azureOpenAIResourceName string = 'openai-${resourceToken}'

@description('Name of Azure OpenAI Resource SKU')
param azureOpenAISkuName string = 'S0'

@description('Azure OpenAI Model Deployment Name')
param azureOpenAIModel string = 'gpt-4'

@description('Azure OpenAI Model Name')
param azureOpenAIModelName string = 'gpt-4'

param azureOpenAIModelVersion string = '0613'

@description('Azure OpenAI Model Capacity - See here for more info  https://learn.microsoft.com/en-us/azure/ai-services/openai/how-to/quota')
param azureOpenAIModelCapacity int = 30

@description('Deploys and uses GPT-4 vision for processing images')
param useGPT4Vision bool = false

@description('Azure OpenAI GPT-4 Vision Model Deployment Name')
param azureOpenAIGPT4VisionModel string = 'gpt-4'

@description('Azure OpenAI GPT-4 Vision Model Name')
param azureOpenAIGPT4VisionModelName string = 'gpt-4-vision'

@description('Azure OpenAI GPT-4 Vision Model Version')
param azureOpenAIGPT4VisionModelVersion string = 'vision-preview'

@description('Azure OpenAI GPT-4 Vision Model Capacity - See here for more info  https://learn.microsoft.com/en-us/azure/ai-services/openai/how-to/quota')
param azureOpenAIGPT4VisionModelCapacity int = 10

@description('Orchestration strategy: openai_function or langchain str. If you use a old version of turbo (0301), plese select langchain')
@allowed([
  'openai_function'
  'langchain'
])
param orchestrationStrategy string = 'openai_function'

@description('Azure OpenAI Temperature')
param azureOpenAITemperature string = '0'

@description('Azure OpenAI Top P')
param azureOpenAITopP string = '1'

@description('Azure OpenAI Max Tokens')
param azureOpenAIMaxTokens string = '1000'

@description('Azure OpenAI Stop Sequence')
param azureOpenAIStopSequence string = '\n'

@description('Azure OpenAI System Message')
param azureOpenAISystemMessage string = 'You are an AI assistant that helps people find information.'

@description('Azure OpenAI Api Version')
param azureOpenAIApiVersion string = '2024-02-01'

@description('Whether or not to stream responses from Azure OpenAI')
param azureOpenAIStream string = 'true'

@description('Azure OpenAI Embedding Model Deployment Name')
param azureOpenAIEmbeddingModel string = 'text-embedding-ada-002'

@description('Azure OpenAI Embedding Model Name')
param azureOpenAIEmbeddingModelName string = 'text-embedding-ada-002'

@description('Azure OpenAI Embedding Model Capacity - See here for more info  https://learn.microsoft.com/en-us/azure/ai-services/openai/how-to/quota')
param azureOpenAIEmbeddingModelCapacity int = 30

@description('Name of Computer Vision Resource (if useGPT4Vision=true)')
param computerVisionName string = 'computer-vision-${resourceToken}'

@description('Name of Computer Vision Resource SKU (if useGPT4Vision=true)')
@allowed([
  'F0'
  'S1'
])
param computerVisionSkuName string = 'S1'

@description('Location of Computer Vision Resource (if useGPT4Vision=true)')
@allowed([// List taken from https://learn.microsoft.com/en-us/azure/ai-services/computer-vision/how-to/image-retrieval?tabs=python#prerequisites
  'eastus'
  'westus'
  'koreacentral'
  'francecentral'
  'northeurope'
  'westeurope'
  'southeastasia'
  ''
])
param computerVisionLocation string = useGPT4Vision ? location : ''

@description('Azure AI Search Resource')
param azureAISearchName string = 'search-${resourceToken}'

@description('The SKU of the search service you want to create. E.g. free or standard')
@allowed([
  'free'
  'basic'
  'standard'
  'standard2'
  'standard3'
])
param azureSearchSku string = 'basic'

@description('Azure AI Search Index')
param azureSearchIndex string = 'index-${resourceToken}'

@description('Azure AI Search Conversation Log Index')
param azureSearchConversationLogIndex string = 'conversations'

@description('Name of Storage Account')
param storageAccountName string = 'str${resourceToken}'

@description('Name of Function App for Batch document processing')
param functionName string = 'backend-${resourceToken}'

@description('Azure Form Recognizer Name')
param formRecognizerName string = 'formrecog-${resourceToken}'

@description('Azure Content Safety Name')
param contentSafetyName string = 'contentsafety-${resourceToken}'

@description('Azure Speech Service Name')
param speechServiceName string = 'speech-${resourceToken}'

@description('Log Analytics Name')
param logAnalyticsName string = 'la-${resourceToken}'

param newGuidString string = newGuid()
param searchTag string = 'chatwithyourdata-sa'

@description('Whether to use Key Vault to store secrets (best when using keys). If using RBAC, then please set this to false.')
param useKeyVault bool = authType == 'rbac' ? false : true

@description('Id of the user or app to assign application roles')
param principalId string = ''

@description('Whether the Azure services communicate with each other using RBAC or keys. RBAC is recommended, however some users may not have sufficient permissions to assign roles.')
@allowed([
  'rbac'
  'keys'
])
param authType string = 'keys'

@description('Hosting model for the web apps. Containers are prebuilt and can be deployed faster, but code allows for more customization.')
@allowed([
  'code'
  'container'
])
param hostingModel string = 'code'

@allowed([
  'CRITICAL'
  'ERROR'
  'WARN'
  'INFO'
  'DEBUG'
])
param logLevel string = 'INFO'

@description('List of comma-separated languages to recognize from the speech input. Supported languages are listed here: https://learn.microsoft.com/en-us/azure/ai-services/speech-service/language-support?tabs=stt#supported-languages')
param recognizedLanguages string = 'en-US,fr-FR,de-DE,it-IT'

@description('Customize this to use a different (e.g. branded) frontend image.')
param frontendImage string = 'fruoccopublic.azurecr.io/rag-webapp'

@description('Set to true if you want to isolate the dependencies in a private network')
param usePrivateNetwork bool = true
@description('Existing resource group name for the virtual network')
param vnetRgName string = ''
@description('Existing virtual network name')
param vnetName string = ''
@description('Existing subnet name for the private endpoint')
param vnetPrivateEndpointSubnet string = ''
@description('Existing subnet name for the app service. Has to be delegated to Microsoft.Web/serverFarms')
param vnetAppServiceSubnet string = ''
@description('Whether to allow public access to the frontend')
param allowPublicAccessToFrontend bool = true
@description('Whether to allow public access to the admin frontend')
param allowPublicAccessToAdmin bool = true

param dnsOverride string = ''

var blobContainerName = 'documents'
var queueName = 'doc-processing'
var clientKey = '${uniqueString(guid(subscription().id, deployment().name))}${newGuidString}'
var eventGridSystemTopicName = 'doc-processing'
var tags = { 'azd-env-name': environmentName }
var rgName = 'rg-${environmentName}'
var keyVaultName = 'kv-${resourceToken}'


resource vnet 'Microsoft.Network/virtualNetworks@2020-11-01' existing = if(usePrivateNetwork) {
  name: vnetName
  scope: resourceGroup(vnetRgName)
}

resource privateEndpointSubnet 'Microsoft.Network/virtualNetworks/subnets@2020-11-01' existing = if(usePrivateNetwork) {
 name: vnetPrivateEndpointSubnet
 parent: vnet
}

resource appServiceSubnet 'Microsoft.Network/virtualNetworks/subnets@2020-11-01' existing = if(usePrivateNetwork) {
 name: vnetAppServiceSubnet
 parent: vnet
}

// Organize resources in a resource group
resource rg 'Microsoft.Resources/resourceGroups@2021-04-01' = {
  name: rgName
  location: location
  tags: tags
}

// Store secrets in a keyvault
module keyvault './core/security/keyvault.bicep' = if (useKeyVault || authType == 'rbac') {
  name: 'keyvault'
  scope: rg
  params: {
    name: keyVaultName
    location: location
    tags: tags
    principalId: principalId
    publicNetworkAccess: usePrivateNetwork ? 'Disabled' : 'Enabled'
  }
}

module privateDnsZonesKv 'core/networking/private-dns-zone.bicep' = if (usePrivateNetwork && (useKeyVault || authType == 'rbac')) {
  name: 'privatelink.vaultcore.azure.net'
  scope: rg
  params: {
    privateDnsZoneLinkName: 'vnetlink-kv'
    privateDnsZoneName: 'privatelink.vaultcore.azure.net'
    vnetId: vnet.id
    groupIds: [ 'vault' ]
    resourceIds: [keyvault.outputs.id]
    resourceNames: [keyVaultName]
    subnetId: privateEndpointSubnet.id
    location: location
    tags: tags
  }
}

var defaultOpenAiDeployments = [
  {
    name: azureOpenAIModel
    model: {
      format: 'OpenAI'
      name: azureOpenAIModelName
      version: azureOpenAIModelVersion
    }
    sku: {
      name: 'Standard'
      capacity: azureOpenAIModelCapacity
    }
  }
  {
    name: azureOpenAIEmbeddingModel
    model: {
      format: 'OpenAI'
      name: azureOpenAIEmbeddingModelName
      version: '2'
    }
    capacity: azureOpenAIEmbeddingModelCapacity
  }
]

var openAiDeployments = concat(defaultOpenAiDeployments, useGPT4Vision ? [
    {
      name: azureOpenAIGPT4VisionModelName
      model: {
        format: 'OpenAI'
        name: azureOpenAIGPT4VisionModel
        version: azureOpenAIGPT4VisionModelVersion
      }
      sku: {
        name: 'Standard'
        capacity: azureOpenAIGPT4VisionModelCapacity
      }
    }
  ] : [])

module openai 'core/ai/cognitiveservices.bicep' = {
  name: azureOpenAIResourceName
  scope: rg
  params: {
    name: azureOpenAIResourceName
    location: 'swedencentral'
    tags: tags
    sku: {
      name: azureOpenAISkuName
    }
    managedIdentity: authType == 'rbac'
    deployments: openAiDeployments
    publicNetworkAccess: usePrivateNetwork ? 'Disabled' : 'Enabled'
  }
}

// Search Index Data Reader
module searchIndexRoleOpenai 'core/security/role.bicep' = if (authType == 'rbac') {
  scope: rg
  name: 'search-index-role-openai'
  params: {
    principalId: openai.outputs.identityPrincipalId
    roleDefinitionId: '1407120a-92aa-4202-b7e9-c0e197c71c8f'
    principalType: 'ServicePrincipal'
  }
}

// Search Service Contributor
module searchServiceRoleOpenai 'core/security/role.bicep' = if (authType == 'rbac') {
  scope: rg
  name: 'search-service-role-openai'
  params: {
    principalId: openai.outputs.identityPrincipalId
    roleDefinitionId: '7ca78c08-252a-4471-8644-bb5ff32d4ba0'
    principalType: 'ServicePrincipal'
  }
}

module computerVision 'core/ai/cognitiveservices.bicep' = if (useGPT4Vision) {
  name: 'computerVision'
  scope: rg
  params: {
    name: computerVisionName
    kind: 'ComputerVision'
    location: computerVisionLocation
    tags: tags
    sku: {
      name: computerVisionSkuName
    }
    publicNetworkAccess: usePrivateNetwork ? 'Disabled' : 'Enabled'
  }
}

module speechService 'core/ai/cognitiveservices.bicep' = {
  scope: rg
  name: speechServiceName
  params: {
    name: speechServiceName
    location: location
    sku: {
      name: 'S0'
    }
    kind: 'SpeechServices'
    publicNetworkAccess: usePrivateNetwork ? 'Disabled' : 'Enabled'
  }
}

module formrecognizer 'core/ai/cognitiveservices.bicep' = {
  name: formRecognizerName
  scope: rg
  params: {
    name: formRecognizerName
    location: location
    tags: tags
    kind: 'FormRecognizer'
    publicNetworkAccess: usePrivateNetwork ? 'Disabled' : 'Enabled'
    managedIdentity: usePrivateNetwork
  }
}

module contentsafety 'core/ai/cognitiveservices.bicep' = {
  name: contentSafetyName
  scope: rg
  params: {
    name: contentSafetyName
    location: location
    tags: tags
    kind: 'ContentSafety'
    publicNetworkAccess: usePrivateNetwork ? 'Disabled' : 'Enabled'
  }
}

module eventgrid 'app/eventgrid.bicep' = {
  name: eventGridSystemTopicName
  scope: rg
  params: {
    name: eventGridSystemTopicName
    location: location
    storageAccountId: storage.outputs.id
    queueName: queueName
    blobContainerName: blobContainerName
  }
}

module privateDnsZonesOpenAI 'core/networking/private-dns-zone.bicep' = if (usePrivateNetwork) {
  name: 'privatelink.openai.azure.com'
  scope: rg
  params: {
    privateDnsZoneLinkName: 'vnetlink-openai'
    privateDnsZoneName: 'privatelink.openai.azure.com'
    vnetId: vnet.id
    groupIds: [ 'account' ]
    resourceIds: [openai.outputs.id]
    resourceNames: [azureOpenAIResourceName]
    subnetId: privateEndpointSubnet.id
    location: location
    tags: tags
  }
}

var cogServicesIds = concat(
  [speechService.outputs.id, formrecognizer.outputs.id, contentsafety.outputs.id],
  useGPT4Vision ? [computerVision.outputs.id] : [])
var cogServicesNames = concat(
  [speechServiceName, formRecognizerName, contentSafetyName],
  useGPT4Vision ? [computerVisionName] : [])

module privateDnsZonesCogSvc 'core/networking/private-dns-zone.bicep' = if (usePrivateNetwork) {
  name: 'privatelink.cognitiveservices.azure.com'
  scope: rg
  params: {
    privateDnsZoneLinkName: 'vnetlink-cognitive'
    privateDnsZoneName: 'privatelink.cognitiveservices.azure.com'
    vnetId: vnet.id
    groupIds: [ 'account' ]
    resourceIds: cogServicesIds
    resourceNames: cogServicesNames
    subnetId: privateEndpointSubnet.id
    location: location
    tags: tags
  }
}

module search './core/search/search-services.bicep' = {
  name: azureAISearchName
  scope: rg
  params: {
    name: azureAISearchName
    location: location
    tags: {
      deployment: searchTag
    }
    sku: {
      name: azureSearchSku
    }
    authOptions: {
      aadOrApiKey: {
        aadAuthFailureMode: 'http403'
      }
    }
    publicNetworkAccess: usePrivateNetwork ? 'disabled' : 'enabled'
  }
}

module privateDnsZonesSearch 'core/networking/private-dns-zone.bicep' = if (usePrivateNetwork) {
  name: 'privatelink.search.windows.net'
  scope: rg
  params: {
    privateDnsZoneLinkName: 'vnetlink-search'
    privateDnsZoneName: 'privatelink.search.windows.net'
    vnetId: vnet.id
    groupIds: [ 'searchService' ]
    resourceIds: [search.outputs.id]
    resourceNames: [azureAISearchName]
    subnetId: privateEndpointSubnet.id
    location: location
    tags: tags
  }
}

module storage 'core/storage/storage-account.bicep' = {
  name: storageAccountName
  scope: rg
  params: {
    name: storageAccountName
    location: location
    sku: {
      name: 'Standard_GRS'
    }
    containers: [
      {
        name: blobContainerName
        publicAccess: 'None'
      }
      {
        name: 'config'
        publicAccess: 'None'
      }
    ]
    queues: [
      {
        name: 'doc-processing'
      }
      {
        name: 'doc-processing-poison'
      }
    ]
    publicNetworkAccess: 'Enabled'
    networkAcls: usePrivateNetwork ?  {
      resourceAccessRules: [
          {
              tenantId: subscription().tenantId
              resourceId: formrecognizer.outputs.id
          }
      ]
      bypass: 'AzureServices'
      virtualNetworkRules: []
      ipRules: []
      defaultAction: 'Deny'
    } : {
      bypass: 'AzureServices'
      defaultAction: 'Allow'
    }
  }
}


module privateDnsZonesStorageBlob 'core/networking/private-dns-zone.bicep' = if (usePrivateNetwork) {
  name: 'privatelink.blob.core.windows.net'
  scope: rg
  params: {
    privateDnsZoneLinkName: 'vnetlink-blob'
    privateDnsZoneName: 'privatelink.blob.core.windows.net'
    vnetId: vnet.id
    groupIds: [ 'blob' ]
    resourceIds: [storage.outputs.id]
    resourceNames: ['${storageAccountName}-blob']
    subnetId: privateEndpointSubnet.id
    location: location
    tags: tags
  }
}


module privateDnsZonesStorageQueue 'core/networking/private-dns-zone.bicep' = if (usePrivateNetwork) {
  name: 'privatelink.queue.core.windows.net'
  scope: rg
  params: {
    privateDnsZoneLinkName: 'vnetlink-queue'
    privateDnsZoneName: 'privatelink.queue.core.windows.net'
    vnetId: vnet.id
    groupIds: [ 'queue' ]
    resourceIds: [storage.outputs.id]
    resourceNames: ['${storageAccountName}-queue']
    subnetId: privateEndpointSubnet.id
    location: location
    tags: tags
  }
}

module storekeys './app/storekeys.bicep' = if (useKeyVault) {
  name: 'storekeys'
  scope: rg
  params: {
    keyVaultName: keyVaultName
    azureOpenAIName: openai.outputs.name
    azureAISearchName: search.outputs.name
    storageAccountName: storage.outputs.name
    formRecognizerName: formrecognizer.outputs.name
    contentSafetyName: contentsafety.outputs.name
    speechServiceName: speechServiceName
    rgName: rgName
  }
}

module hostingplan './core/host/appserviceplan.bicep' = {
  name: hostingPlanName
  scope: rg
  params: {
    name: hostingPlanName
    location: location
    sku: {
      name: hostingPlanSku
      tier: skuTier
    }
    reserved: true
    tags: { Automation: 'Ignore' }
  }
}


module web './app/web.bicep' = if (hostingModel == 'code') {
  name: websiteName
  scope: rg
  params: {
    name: websiteName
    location: location
    tags: union(tags, { 'azd-service-name': 'web' })
    runtimeName: 'python'
    runtimeVersion: '3.11'
    appServicePlanId: hostingplan.outputs.name
    applicationInsightsName: monitoring.outputs.applicationInsightsName
    healthCheckPath: '/api/health'
    azureOpenAIName: openai.outputs.name
    azureAISearchName: search.outputs.name
    storageAccountName: storage.outputs.name
    formRecognizerName: formrecognizer.outputs.name
    contentSafetyName: contentsafety.outputs.name
    speechServiceName: speechService.outputs.name
    openAIKeyName: useKeyVault ? storekeys.outputs.OPENAI_KEY_NAME : ''
    storageAccountKeyName: useKeyVault ? storekeys.outputs.STORAGE_ACCOUNT_KEY_NAME : ''
    formRecognizerKeyName: useKeyVault ? storekeys.outputs.FORM_RECOGNIZER_KEY_NAME : ''
    searchKeyName: useKeyVault ? storekeys.outputs.SEARCH_KEY_NAME : ''
    contentSafetyKeyName: useKeyVault ? storekeys.outputs.CONTENT_SAFETY_KEY_NAME : ''
    speechKeyName: useKeyVault ? storekeys.outputs.SPEECH_KEY_NAME : ''
    useKeyVault: useKeyVault
    keyVaultName: useKeyVault || authType == 'rbac' ? keyvault.outputs.name : ''
    authType: authType
    virutalNetworkSubnetId: usePrivateNetwork ? appServiceSubnet.id : null
    allowPublicAccess: allowPublicAccessToFrontend
    appSettings: union({
      AZURE_BLOB_ACCOUNT_NAME: storageAccountName
      AZURE_BLOB_CONTAINER_NAME: blobContainerName
      AZURE_CONTENT_SAFETY_ENDPOINT: contentsafety.outputs.endpoint
      AZURE_FORM_RECOGNIZER_ENDPOINT: formrecognizer.outputs.endpoint
      AZURE_OPENAI_RESOURCE: azureOpenAIResourceName
      AZURE_OPENAI_MODEL: azureOpenAIModel
      AZURE_OPENAI_MODEL_NAME: azureOpenAIModelName
      AZURE_OPENAI_TEMPERATURE: azureOpenAITemperature
      AZURE_OPENAI_TOP_P: azureOpenAITopP
      AZURE_OPENAI_MAX_TOKENS: azureOpenAIMaxTokens
      AZURE_OPENAI_STOP_SEQUENCE: azureOpenAIStopSequence
      AZURE_OPENAI_SYSTEM_MESSAGE: azureOpenAISystemMessage
      AZURE_OPENAI_API_VERSION: azureOpenAIApiVersion
      AZURE_OPENAI_STREAM: azureOpenAIStream
      AZURE_OPENAI_EMBEDDING_MODEL: azureOpenAIEmbeddingModel
      AZURE_SEARCH_USE_SEMANTIC_SEARCH: azureSearchUseSemanticSearch
      AZURE_SEARCH_SERVICE: 'https://${azureAISearchName}.search.windows.net'
      AZURE_SEARCH_INDEX: azureSearchIndex
      AZURE_SEARCH_CONVERSATIONS_LOG_INDEX: azureSearchConversationLogIndex
      AZURE_SEARCH_SEMANTIC_SEARCH_CONFIG: azureSearchSemanticSearchConfig
      AZURE_SEARCH_INDEX_IS_PRECHUNKED: azureSearchIndexIsPrechunked
      AZURE_SEARCH_TOP_K: azureSearchTopK
      AZURE_SEARCH_ENABLE_IN_DOMAIN: azureSearchEnableInDomain
      AZURE_SEARCH_CONTENT_COLUMNS: azureSearchContentColumns
      AZURE_SEARCH_FILENAME_COLUMN: azureSearchFilenameColumn
      AZURE_SEARCH_FILTER: azureSearchFilter
      AZURE_SEARCH_TITLE_COLUMN: azureSearchTitleColumn
      AZURE_SEARCH_URL_COLUMN: azureSearchUrlColumn
      AZURE_SPEECH_SERVICE_NAME: speechServiceName
      AZURE_SPEECH_SERVICE_REGION: location
      SPEECH_RECOGNIZER_LANGUAGES: recognizedLanguages
      ORCHESTRATION_STRATEGY: orchestrationStrategy
      LOGLEVEL: logLevel
    }, empty(dnsOverride) ? {} : {
      WEBSITE_DNS_SERVER: dnsOverride
    })
  }
}


module web_docker './app/web.bicep' = if (hostingModel == 'container') {
  name: '${websiteName}-docker'
  scope: rg
  params: {
    name: '${websiteName}-docker'
    location: location
    tags: union(tags, { 'azd-service-name': 'web-docker' })
    dockerFullImageName: frontendImage
    appServicePlanId: hostingplan.outputs.name
    applicationInsightsName: monitoring.outputs.applicationInsightsName
    healthCheckPath: '/api/health'
    azureOpenAIName: openai.outputs.name
    azureAISearchName: search.outputs.name
    storageAccountName: storage.outputs.name
    formRecognizerName: formrecognizer.outputs.name
    contentSafetyName: contentsafety.outputs.name
    speechServiceName: speechService.outputs.name
    openAIKeyName: useKeyVault ? storekeys.outputs.OPENAI_KEY_NAME : ''
    storageAccountKeyName: useKeyVault ? storekeys.outputs.STORAGE_ACCOUNT_KEY_NAME : ''
    formRecognizerKeyName: useKeyVault ? storekeys.outputs.FORM_RECOGNIZER_KEY_NAME : ''
    searchKeyName: useKeyVault ? storekeys.outputs.SEARCH_KEY_NAME : ''
    contentSafetyKeyName: useKeyVault ? storekeys.outputs.CONTENT_SAFETY_KEY_NAME : ''
    speechKeyName: useKeyVault ? storekeys.outputs.SPEECH_KEY_NAME : ''
    useKeyVault: useKeyVault
    keyVaultName: useKeyVault || authType == 'rbac' ? keyvault.outputs.name : ''
    authType: authType
    virutalNetworkSubnetId: usePrivateNetwork ? appServiceSubnet.id : null
    allowPublicAccess: allowPublicAccessToFrontend
    appSettings: union({
      AZURE_BLOB_ACCOUNT_NAME: storageAccountName
      AZURE_BLOB_CONTAINER_NAME: blobContainerName
      AZURE_CONTENT_SAFETY_ENDPOINT: contentsafety.outputs.endpoint
      AZURE_FORM_RECOGNIZER_ENDPOINT: formrecognizer.outputs.endpoint
      AZURE_OPENAI_RESOURCE: azureOpenAIResourceName
      AZURE_OPENAI_MODEL: azureOpenAIModel
      AZURE_OPENAI_MODEL_NAME: azureOpenAIModelName
      AZURE_OPENAI_TEMPERATURE: azureOpenAITemperature
      AZURE_OPENAI_TOP_P: azureOpenAITopP
      AZURE_OPENAI_MAX_TOKENS: azureOpenAIMaxTokens
      AZURE_OPENAI_STOP_SEQUENCE: azureOpenAIStopSequence
      AZURE_OPENAI_SYSTEM_MESSAGE: azureOpenAISystemMessage
      AZURE_OPENAI_API_VERSION: azureOpenAIApiVersion
      AZURE_OPENAI_STREAM: azureOpenAIStream
      AZURE_OPENAI_EMBEDDING_MODEL: azureOpenAIEmbeddingModel
      AZURE_SEARCH_USE_SEMANTIC_SEARCH: azureSearchUseSemanticSearch
      AZURE_SEARCH_SERVICE: 'https://${azureAISearchName}.search.windows.net'
      AZURE_SEARCH_INDEX: azureSearchIndex
      AZURE_SEARCH_CONVERSATIONS_LOG_INDEX: azureSearchConversationLogIndex
      AZURE_SEARCH_SEMANTIC_SEARCH_CONFIG: azureSearchSemanticSearchConfig
      AZURE_SEARCH_INDEX_IS_PRECHUNKED: azureSearchIndexIsPrechunked
      AZURE_SEARCH_TOP_K: azureSearchTopK
      AZURE_SEARCH_ENABLE_IN_DOMAIN: azureSearchEnableInDomain
      AZURE_SEARCH_CONTENT_COLUMNS: azureSearchContentColumns
      AZURE_SEARCH_FILENAME_COLUMN: azureSearchFilenameColumn
      AZURE_SEARCH_FILTER: azureSearchFilter
      AZURE_SEARCH_TITLE_COLUMN: azureSearchTitleColumn
      AZURE_SEARCH_URL_COLUMN: azureSearchUrlColumn
      AZURE_SPEECH_SERVICE_NAME: speechServiceName
      AZURE_SPEECH_SERVICE_REGION: location
      SPEECH_RECOGNIZER_LANGUAGES: recognizedLanguages
      ORCHESTRATION_STRATEGY: orchestrationStrategy
      LOGLEVEL: logLevel
    }, empty(dnsOverride) ? {} : {
      WEBSITE_DNS_SERVER: dnsOverride
    })
  }
}

module adminweb './app/adminweb.bicep' = if (hostingModel == 'code') {
  name: adminWebsiteName
  scope: rg
  params: {
    name: adminWebsiteName
    location: location
    tags: union(tags, { 'azd-service-name': 'adminweb' })
    runtimeName: 'python'
    runtimeVersion: '3.11'
    appServicePlanId: hostingplan.outputs.name
    applicationInsightsName: monitoring.outputs.applicationInsightsName
    azureOpenAIName: openai.outputs.name
    azureAISearchName: search.outputs.name
    storageAccountName: storage.outputs.name
    formRecognizerName: formrecognizer.outputs.name
    contentSafetyName: contentsafety.outputs.name
    speechServiceName: speechService.outputs.name
    openAIKeyName: useKeyVault ? storekeys.outputs.OPENAI_KEY_NAME : ''
    storageAccountKeyName: useKeyVault ? storekeys.outputs.STORAGE_ACCOUNT_KEY_NAME : ''
    formRecognizerKeyName: useKeyVault ? storekeys.outputs.FORM_RECOGNIZER_KEY_NAME : ''
    searchKeyName: useKeyVault ? storekeys.outputs.SEARCH_KEY_NAME : ''
    contentSafetyKeyName: useKeyVault ? storekeys.outputs.CONTENT_SAFETY_KEY_NAME : ''
    speechKeyName: useKeyVault ? storekeys.outputs.SPEECH_KEY_NAME : ''
    useKeyVault: useKeyVault
    keyVaultName: useKeyVault || authType == 'rbac' ? keyvault.outputs.name : ''
    authType: authType
    virutalNetworkSubnetId: usePrivateNetwork ? appServiceSubnet.id : null
    allowPublicAccess: allowPublicAccessToAdmin
    appSettings: union({
      AZURE_BLOB_ACCOUNT_NAME: storageAccountName
      AZURE_BLOB_CONTAINER_NAME: blobContainerName
      AZURE_CONTENT_SAFETY_ENDPOINT: contentsafety.outputs.endpoint
      AZURE_FORM_RECOGNIZER_ENDPOINT: formrecognizer.outputs.endpoint
      AZURE_OPENAI_RESOURCE: azureOpenAIResourceName
      AZURE_OPENAI_MODEL: azureOpenAIModel
      AZURE_OPENAI_MODEL_NAME: azureOpenAIModelName
      AZURE_OPENAI_TEMPERATURE: azureOpenAITemperature
      AZURE_OPENAI_TOP_P: azureOpenAITopP
      AZURE_OPENAI_MAX_TOKENS: azureOpenAIMaxTokens
      AZURE_OPENAI_STOP_SEQUENCE: azureOpenAIStopSequence
      AZURE_OPENAI_SYSTEM_MESSAGE: azureOpenAISystemMessage
      AZURE_OPENAI_API_VERSION: azureOpenAIApiVersion
      AZURE_OPENAI_STREAM: azureOpenAIStream
      AZURE_OPENAI_EMBEDDING_MODEL: azureOpenAIEmbeddingModel
      AZURE_SEARCH_SERVICE: 'https://${azureAISearchName}.search.windows.net'
      AZURE_SEARCH_INDEX: azureSearchIndex
      AZURE_SEARCH_USE_SEMANTIC_SEARCH: azureSearchUseSemanticSearch
      AZURE_SEARCH_SEMANTIC_SEARCH_CONFIG: azureSearchSemanticSearchConfig
      AZURE_SEARCH_INDEX_IS_PRECHUNKED: azureSearchIndexIsPrechunked
      AZURE_SEARCH_TOP_K: azureSearchTopK
      AZURE_SEARCH_ENABLE_IN_DOMAIN: azureSearchEnableInDomain
      AZURE_SEARCH_CONTENT_COLUMNS: azureSearchContentColumns
      AZURE_SEARCH_FILENAME_COLUMN: azureSearchFilenameColumn
      AZURE_SEARCH_FILTER: azureSearchFilter
      AZURE_SEARCH_TITLE_COLUMN: azureSearchTitleColumn
      AZURE_SEARCH_URL_COLUMN: azureSearchUrlColumn
      BACKEND_URL: 'https://${functionName}.azurewebsites.net'
      DOCUMENT_PROCESSING_QUEUE_NAME: queueName
      FUNCTION_KEY: clientKey
      ORCHESTRATION_STRATEGY: orchestrationStrategy
      LOGLEVEL: logLevel
    }, empty(dnsOverride) ? {} : {
      WEBSITE_DNS_SERVER: dnsOverride
    })
  }
}

module adminweb_docker './app/adminweb.bicep' = if (hostingModel == 'container') {
  name: '${adminWebsiteName}-docker'
  scope: rg
  params: {
    name: '${adminWebsiteName}-docker'
    location: location
    tags: union(tags, { 'azd-service-name': 'adminweb-docker' })
    dockerFullImageName: 'fruoccopublic.azurecr.io/rag-adminwebapp'
    appServicePlanId: hostingplan.outputs.name
    applicationInsightsName: monitoring.outputs.applicationInsightsName
    azureOpenAIName: openai.outputs.name
    azureAISearchName: search.outputs.name
    storageAccountName: storage.outputs.name
    formRecognizerName: formrecognizer.outputs.name
    contentSafetyName: contentsafety.outputs.name
    speechServiceName: speechService.outputs.name
    openAIKeyName: useKeyVault ? storekeys.outputs.OPENAI_KEY_NAME : ''
    storageAccountKeyName: useKeyVault ? storekeys.outputs.STORAGE_ACCOUNT_KEY_NAME : ''
    formRecognizerKeyName: useKeyVault ? storekeys.outputs.FORM_RECOGNIZER_KEY_NAME : ''
    searchKeyName: useKeyVault ? storekeys.outputs.SEARCH_KEY_NAME : ''
    contentSafetyKeyName: useKeyVault ? storekeys.outputs.CONTENT_SAFETY_KEY_NAME : ''
    speechKeyName: useKeyVault ? storekeys.outputs.SPEECH_KEY_NAME : ''
    useKeyVault: useKeyVault
    keyVaultName: useKeyVault || authType == 'rbac' ? keyvault.outputs.name : ''
    authType: authType
    virutalNetworkSubnetId: usePrivateNetwork ? appServiceSubnet.id : null
    allowPublicAccess: allowPublicAccessToAdmin
    appSettings: union({
      AZURE_BLOB_ACCOUNT_NAME: storageAccountName
      AZURE_BLOB_CONTAINER_NAME: blobContainerName
      AZURE_CONTENT_SAFETY_ENDPOINT: contentsafety.outputs.endpoint
      AZURE_FORM_RECOGNIZER_ENDPOINT: formrecognizer.outputs.endpoint
      AZURE_OPENAI_RESOURCE: azureOpenAIResourceName
      AZURE_OPENAI_MODEL: azureOpenAIModel
      AZURE_OPENAI_MODEL_NAME: azureOpenAIModelName
      AZURE_OPENAI_TEMPERATURE: azureOpenAITemperature
      AZURE_OPENAI_TOP_P: azureOpenAITopP
      AZURE_OPENAI_MAX_TOKENS: azureOpenAIMaxTokens
      AZURE_OPENAI_STOP_SEQUENCE: azureOpenAIStopSequence
      AZURE_OPENAI_SYSTEM_MESSAGE: azureOpenAISystemMessage
      AZURE_OPENAI_API_VERSION: azureOpenAIApiVersion
      AZURE_OPENAI_STREAM: azureOpenAIStream
      AZURE_OPENAI_EMBEDDING_MODEL: azureOpenAIEmbeddingModel
      AZURE_SEARCH_SERVICE: 'https://${azureAISearchName}.search.windows.net'
      AZURE_SEARCH_INDEX: azureSearchIndex
      AZURE_SEARCH_USE_SEMANTIC_SEARCH: azureSearchUseSemanticSearch
      AZURE_SEARCH_SEMANTIC_SEARCH_CONFIG: azureSearchSemanticSearchConfig
      AZURE_SEARCH_INDEX_IS_PRECHUNKED: azureSearchIndexIsPrechunked
      AZURE_SEARCH_TOP_K: azureSearchTopK
      AZURE_SEARCH_ENABLE_IN_DOMAIN: azureSearchEnableInDomain
      AZURE_SEARCH_CONTENT_COLUMNS: azureSearchContentColumns
      AZURE_SEARCH_FILENAME_COLUMN: azureSearchFilenameColumn
      AZURE_SEARCH_FILTER: azureSearchFilter
      AZURE_SEARCH_TITLE_COLUMN: azureSearchTitleColumn
      AZURE_SEARCH_URL_COLUMN: azureSearchUrlColumn
      BACKEND_URL: 'https://${functionName}-docker.azurewebsites.net'
      DOCUMENT_PROCESSING_QUEUE_NAME: queueName
      FUNCTION_KEY: clientKey
      ORCHESTRATION_STRATEGY: orchestrationStrategy
      LOGLEVEL: logLevel
    }, empty(dnsOverride) ? {} : {
      WEBSITE_DNS_SERVER: dnsOverride
    })
  }
}

module function './app/function.bicep' = if (hostingModel == 'code') {
  name: functionName
  scope: rg
  params: {
    name: functionName
    location: location
    tags: union(tags, { 'azd-service-name': 'function' })
    runtimeName: 'python'
    runtimeVersion: '3.11'
    appServicePlanId: hostingplan.outputs.name
    applicationInsightsName: monitoring.outputs.applicationInsightsName
    azureOpenAIName: openai.outputs.name
    azureAISearchName: search.outputs.name
    storageAccountName: storage.outputs.name
    formRecognizerName: formrecognizer.outputs.name
    contentSafetyName: contentsafety.outputs.name
    speechServiceName: speechService.outputs.name
    clientKey: clientKey
    openAIKeyName: useKeyVault ? storekeys.outputs.OPENAI_KEY_NAME : ''
    storageAccountKeyName: useKeyVault ? storekeys.outputs.STORAGE_ACCOUNT_KEY_NAME : ''
    formRecognizerKeyName: useKeyVault ? storekeys.outputs.FORM_RECOGNIZER_KEY_NAME : ''
    searchKeyName: useKeyVault ? storekeys.outputs.SEARCH_KEY_NAME : ''
    contentSafetyKeyName: useKeyVault ? storekeys.outputs.CONTENT_SAFETY_KEY_NAME : ''
    speechKeyName: useKeyVault ? storekeys.outputs.SPEECH_KEY_NAME : ''
    useKeyVault: useKeyVault
    keyVaultName: useKeyVault || authType == 'rbac' ? keyvault.outputs.name : ''
    authType: authType
    virtualNetworkSubnetId: usePrivateNetwork ? appServiceSubnet.id : null
    allowPublicAccess: !usePrivateNetwork
    appSettings: union({
      AZURE_BLOB_ACCOUNT_NAME: storageAccountName
      AZURE_BLOB_CONTAINER_NAME: blobContainerName
      AZURE_CONTENT_SAFETY_ENDPOINT: contentsafety.outputs.endpoint
      AZURE_FORM_RECOGNIZER_ENDPOINT: formrecognizer.outputs.endpoint
      AZURE_OPENAI_MODEL: azureOpenAIModel
      AZURE_OPENAI_EMBEDDING_MODEL: azureOpenAIEmbeddingModel
      AZURE_OPENAI_RESOURCE: azureOpenAIResourceName
      AZURE_OPENAI_API_VERSION: azureOpenAIApiVersion
      AZURE_SEARCH_INDEX: azureSearchIndex
      AZURE_SEARCH_SERVICE: 'https://${azureAISearchName}.search.windows.net'
      DOCUMENT_PROCESSING_QUEUE_NAME: queueName
      ORCHESTRATION_STRATEGY: orchestrationStrategy
      LOGLEVEL: logLevel
    }, empty(dnsOverride) ? {} : {
      WEBSITE_DNS_SERVER: dnsOverride
    })
  }
}

module function_docker './app/function.bicep' = if (hostingModel == 'container') {
  name: '${functionName}-docker'
  scope: rg
  params: {
    name: '${functionName}-docker'
    location: location
    tags: union(tags, { 'azd-service-name': 'function-docker' })
    dockerFullImageName: 'fruoccopublic.azurecr.io/rag-backend'
    appServicePlanId: hostingplan.outputs.name
    applicationInsightsName: monitoring.outputs.applicationInsightsName
    azureOpenAIName: openai.outputs.name
    azureAISearchName: search.outputs.name
    storageAccountName: storage.outputs.name
    formRecognizerName: formrecognizer.outputs.name
    contentSafetyName: contentsafety.outputs.name
    speechServiceName: speechService.outputs.name
    clientKey: clientKey
    openAIKeyName: useKeyVault ? storekeys.outputs.OPENAI_KEY_NAME : ''
    storageAccountKeyName: useKeyVault ? storekeys.outputs.STORAGE_ACCOUNT_KEY_NAME : ''
    formRecognizerKeyName: useKeyVault ? storekeys.outputs.FORM_RECOGNIZER_KEY_NAME : ''
    searchKeyName: useKeyVault ? storekeys.outputs.SEARCH_KEY_NAME : ''
    contentSafetyKeyName: useKeyVault ? storekeys.outputs.CONTENT_SAFETY_KEY_NAME : ''
    speechKeyName: useKeyVault ? storekeys.outputs.SPEECH_KEY_NAME : ''
    useKeyVault: useKeyVault
    keyVaultName: useKeyVault || authType == 'rbac' ? keyvault.outputs.name : ''
    authType: authType
    virtualNetworkSubnetId: usePrivateNetwork ? appServiceSubnet.id : null
    allowPublicAccess: !usePrivateNetwork
    appSettings: union({
      AZURE_BLOB_ACCOUNT_NAME: storageAccountName
      AZURE_BLOB_CONTAINER_NAME: blobContainerName
      AZURE_CONTENT_SAFETY_ENDPOINT: contentsafety.outputs.endpoint
      AZURE_FORM_RECOGNIZER_ENDPOINT: formrecognizer.outputs.endpoint
      AZURE_OPENAI_MODEL: azureOpenAIModel
      AZURE_OPENAI_EMBEDDING_MODEL: azureOpenAIEmbeddingModel
      AZURE_OPENAI_RESOURCE: azureOpenAIResourceName
      AZURE_OPENAI_API_VERSION: azureOpenAIApiVersion
      AZURE_SEARCH_INDEX: azureSearchIndex
      AZURE_SEARCH_SERVICE: 'https://${azureAISearchName}.search.windows.net'
      DOCUMENT_PROCESSING_QUEUE_NAME: queueName
      ORCHESTRATION_STRATEGY: orchestrationStrategy
      LOGLEVEL: logLevel
    }, empty(dnsOverride) ? {} : {
      WEBSITE_DNS_SERVER: dnsOverride
    })
  }
}


module privateDnsZonesFunctionCode 'core/networking/private-dns-zone.bicep' = if (usePrivateNetwork) {
  name: 'privatelink.azurewebsites.net'
  scope: rg
  params: {
    privateDnsZoneLinkName: 'vnetlink-function'
    privateDnsZoneName: 'privatelink.azurewebsites.net'
    vnetId: vnet.id
    groupIds: [ 'sites' ]
    resourceIds: [(hostingModel == 'code') ? function.outputs.id : function_docker.outputs.id]
    resourceNames: [(hostingModel == 'code') ? function.name : function_docker.name]
    subnetId: privateEndpointSubnet.id
    location: location
    tags: tags
  }
}

module monitoring './core/monitor/monitoring.bicep' = {
  name: 'monitoring'
  scope: rg
  params: {
    applicationInsightsName: applicationInsightsName
    location: location
    tags: {
      'hidden-link:${resourceId('Microsoft.Web/sites', applicationInsightsName)}': 'Resource'
    }
    logAnalyticsName: logAnalyticsName
    applicationInsightsDashboardName: 'dash-${applicationInsightsName}'
  }
}

// USER ROLES
// Storage Blob Data Reader for Document Intelligence
module storageReaderRoleUser 'core/security/role.bicep' = if(usePrivateNetwork) {
  scope: rg
  name: 'storage-read-role-user'
  params: {
    principalId: formrecognizer.outputs.identityPrincipalId
    roleDefinitionId: '2a2b9908-6ea1-4ae2-8e65-a410df84e7d1'
    principalType: 'ServicePrincipal'
  }
}


// Storage Blob Data Contributor
module storageRoleUser 'core/security/role.bicep' = if (authType == 'rbac') {
  scope: rg
  name: 'storage-role-user'
  params: {
    principalId: principalId
    roleDefinitionId: 'ba92f5b4-2d11-453d-a403-e96b0029c9fe'
    principalType: 'User'
  }
}

// Cognitive Services User
module openaiRoleUser 'core/security/role.bicep' = if (authType == 'rbac') {
  scope: rg
  name: 'openai-role-user'
  params: {
    principalId: principalId
    roleDefinitionId: 'a97b65f3-24c7-4388-baec-2e87135dc908'
    principalType: 'User'
  }
}

// Contributor
module openaiRoleUserContributor 'core/security/role.bicep' = if (authType == 'rbac') {
  scope: rg
  name: 'openai-role-user-contributor'
  params: {
    principalId: principalId
    roleDefinitionId: 'b24988ac-6180-42a0-ab88-20f7382dd24c'
    principalType: 'User'
  }
}

// Search Index Data Contributor
module searchRoleUser 'core/security/role.bicep' = if (authType == 'rbac') {
  scope: rg
  name: 'search-role-user'
  params: {
    principalId: principalId
    roleDefinitionId: '8ebe5a00-799e-43f5-93ac-243d3dce84a7'
    principalType: 'User'
  }
}
