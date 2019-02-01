# AzureFileSyncDsc

AzureFileSyncDsc is a PowerShell DSC resource module for managing different aspects within the Azure File Sync service, such as installing and registering agents, as well as adding server endpoints.

This project has adopted [this code of conduct](CODE_OF_CONDUCT.md).

## Branches

### master

[![Build Status](https://dev.azure.com/janegilring/AzureFileSyncDsc/_apis/build/status/janegilring.AzureFileSyncDsc?branchName=master)](https://dev.azure.com/janegilring/AzureFileSyncDsc/_build/latest?definitionId=3?branchName=master)
[![PowerShell Gallery](https://img.shields.io/powershellgallery/v/AzureFileSyncDsc.svg)](https://www.powershellgallery.com/packages/AzureFileSyncDsc)

This is the branch containing the latest release -
no contributions should be made directly to this branch.

### dev

[![Build Status](https://dev.azure.com/janegilring/AzureFileSyncDsc/_apis/build/status/janegilring.AzureFileSyncDsc?branchName=dev)](https://dev.azure.com/janegilring/AzureFileSyncDsc/_build/latest?definitionId=3?branchName=dev)

This is the development branch
to which contributions should be proposed by contributors as pull requests.
This development branch will periodically be merged to the master branch,
and be released to [PowerShell Gallery](https://www.powershellgallery.com/).

## How to Contribute

If you would like to contribute to this repository, please read the [contributing guidelines](https://github.com/janegilring/AzureFileSyncDsc/blob/master/CONTRIBUTING.md).

## Resources

- **[AzureFileSyncAgent](https://github.com/janegilring/AzureFileSyncDsc/tree/master/DSCResources/AzureFileSyncAgent)**: This resource can be used to install and configure the Azure File Sync agent.
- **[AzureFileSyncServerEndpoint](https://github.com/janegilring/AzureFileSyncDsc/tree/master/DSCResources/AzureFileSyncServerEndpoint)**: This resource can be used to create an Azure File Sync Server Endpoint in Azure.

### AzureFileSyncAgent

This resource can be used to install and configure the Azure File Sync agent on a server running Windows Server 2012 R2, Windows Server 2016 or Windows Server 2019.

- **`[String]` AzureSubscriptionId** (_Required_): The ID of the Azure subscription where the agent will be enrolled
- **`[String]` AzureFileSyncResourceGroup** (_Required_): The name of the Azure resource group where the Azure File Sync service is provisioned
- **`[Key]` AzureFileSyncInstanceName** : The name of the Azure File Sync service the agent will be registered in
- **`[PSCredential]` AzureCredential** (_Required_): Credential object which has permissions to the Azure File Sync service the agent will be registered in

#### AzureFileSyncAgent Examples

- [Install Azure File Sync Agent](https://github.com/janegilring/AzureFileSyncDsc/blob/master/Examples/Resources/AzureFileSyncAgent/1%20-%20AzureFileSyncAgent.ps1)

### AzureFileSyncServerEndpoint

This resource can be used to create an Azure File Sync Server Endpoint in Azure.

- **`[String]` AzureSubscriptionId** (_Required_): The ID of the Azure subscription where the agent will be enrolled
- **`[String]` AzureFileSyncResourceGroup** (_Required_): The name of the Azure resource group where the Azure File Sync service is provisioned
- **`[Key]` AzureFileSyncInstanceName** : The name of the Azure File Sync service the agent will be registered in
- **`[PSCredential]` AzureCredential** (_Required_): Credential object which has permissions to the Azure File Sync service the agent will be registered in
- **`[String]` TierFilesOlderThanDays** (_Write_) : The name of the Azure File Sync service the agent will be registered in
- **`[Bool]` CloudTiering** (_Write_) : The name of the Azure File Sync service the agent will be registered in
- **`[String]` VolumeFreeSpacePercent** (_Write_) : The name of the Azure File Sync service the agent will be registered in
- **`[String]` ServerLocalPath** (_Required_) : The name of the Azure File Sync service the agent will be registered in
- **`[String]` AzureFileSyncGroup** (_Key_) : The name of the Azure File Sync service the agent will be registered in

#### AzureFileSyncServerEndpoint Examples

- [Register Azure FileSync Server Endpoint](https://github.com/janegilring/AzureFileSyncDsc/blob/master/Examples/Resources/AzureFileSyncServerEndpoint/1%20-%20AzureFileSyncServerEndpoint.ps1)
