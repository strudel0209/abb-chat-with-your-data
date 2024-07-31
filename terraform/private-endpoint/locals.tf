locals {
    zone_map = {
        blob = {
            name = "blob"
            zone = "privatelink.blob.core.windows.net"
        }
        queue = {
            name = "queue"
            zone = "privatelink.queue.core.windows.net"
        }
        account = {
            name = "account"
            zone = "privatelink.cognitiveservices.azure.com"
        }
        openai = {
            name = "account"
            zone = "privatelink.openai.azure.com"
        }
        search = {
            name = "searchService"
            zone = "privatelink.search.windows.net"
        }
    }
}