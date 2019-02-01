Configuration HybridFileServer
{
    param (
        $AzureCredential = (Get-Credential)
    )

    Import-DscResource -ModuleName xPSDesiredStateConfiguration -ModuleVersion 8.4.0.0
    Import-DscResource -ModuleName PSDesiredStateConfiguration
    Import-DscResource -ModuleName PackageManagement -ModuleVersion 1.2.4
    Import-DscResource -ModuleName AzureFileSyncAgentDsc -ModuleVersion 1.1.5
    Import-DscResource -ModuleName StorageDsc -ModuleVersion 4.4.0.0

    Node FS01 {

        AzureFileSyncServerEndpoint Data {

            AzureSubscriptionId = 'c0fda861-1234-5678-9ede-fa1908101500'
            AzureFileSyncResourceGroup = 'File-Sync-Rg'
            AzureFileSyncInstanceName = 'FileSync01'
            AzureFileSyncGroup = 'FileServers'
            AzureCredential = $AzureCredential
            ServerLocalPath = 'D:\Data'
            CloudTiering = $true
            TierFilesOlderThanDays = '365'

      }

    }

}
