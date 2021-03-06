function Get-TargetResource
{
    [CmdletBinding()]
    [OutputType([System.Collections.Hashtable])]
    param
    (
        [parameter(Mandatory = $true)]
        [System.String]
        $AzureSubscriptionId,

        [parameter(Mandatory = $true)]
        [System.String]
        $AzureFileSyncResourceGroup,

        [parameter(Mandatory = $true)]
        [System.String]
        $AzureFileSyncInstanceName,

        [parameter(Mandatory = $true)]
        [System.Management.Automation.PSCredential]
        $AzureCredential
    )

    $null = Import-Module "C:\Program Files\Azure\StorageSyncAgent\StorageSync.Management.PowerShell.Cmdlets.dll" -WarningAction SilentlyContinue

    $null = Login-AzureRmStorageSync -SubscriptionId $AzureSubscriptionId -Credential $AzureCredential


    Write-Verbose "ComputerName for verifying if node is already registered with Azure: $($env:COMPUTERNAME)"

    $Registered = Get-AzureRmStorageSyncServer -SubscriptionId $AzureSubscriptionId -ResourceGroupName $AzureFileSyncResourceGroup -StorageSyncServiceName $AzureFileSyncInstanceName | Select-Object *,@{n='ComputerName';e={$PSitem.DisplayName.Split('.')[0]}} | Where-Object ComputerName -eq $env:COMPUTERNAME

    Write-Verbose "Number of registered instances with ComputerName $($env:COMPUTERNAME) : $(@($Registered).Count)"

     $returnValue = @{
        AzureSubscriptionId = $AzureSubscriptionId
        AzureFileSyncResourceGroup = $AzureFileSyncResourceGroup
        AzureFileSyncInstanceName = $AzureFileSyncInstanceName
        AzureCredential = $AzureCredential
    }

    $returnValue

}


function Set-TargetResource
{
    [CmdletBinding()]
    param
    (
        [parameter(Mandatory = $true)]
        [System.String]
        $AzureSubscriptionId,

        [parameter(Mandatory = $true)]
        [System.String]
        $AzureFileSyncResourceGroup,

        [parameter(Mandatory = $true)]
        [System.String]
        $AzureFileSyncInstanceName,

        [parameter(Mandatory = $true)]
        [System.Management.Automation.PSCredential]
        $AzureCredential
    )


    $null = Import-Module "C:\Program Files\Azure\StorageSyncAgent\StorageSync.Management.PowerShell.Cmdlets.dll" -WarningAction SilentlyContinue

    $null = Login-AzureRmStorageSync -SubscriptionId $AzureSubscriptionId -Credential $AzureCredential

    $null = Register-AzureRmStorageSyncServer -SubscriptionId $AzureSubscriptionId -ResourceGroupName $AzureFileSyncResourceGroup -StorageSyncServiceName $AzureFileSyncInstanceName


}


function Test-TargetResource
{
    [CmdletBinding()]
    [OutputType([System.Boolean])]
    param
    (
        [parameter(Mandatory = $true)]
        [System.String]
        $AzureSubscriptionId,

        [parameter(Mandatory = $true)]
        [System.String]
        $AzureFileSyncResourceGroup,

        [parameter(Mandatory = $true)]
        [System.String]
        $AzureFileSyncInstanceName,

        [parameter(Mandatory = $true)]
        [System.Management.Automation.PSCredential]
        $AzureCredential
    )

    Write-Verbose "Variable AzureFileSyncSubscriptionId is $AzureSubscriptionId"
    Write-Verbose "Variable AzureFileSyncResourceGroup is $AzureFileSyncResourceGroup"
    Write-Verbose "Variable AzureFileSyncInstanceName is $AzureFileSyncInstanceName"
    Write-Verbose "Username for credential object AzureCredential is $($AzureCredential.UserName)"

    $null = Import-Module "C:\Program Files\Azure\StorageSyncAgent\StorageSync.Management.PowerShell.Cmdlets.dll" -WarningAction SilentlyContinue

    $null = Login-AzureRmStorageSync -SubscriptionId $AzureSubscriptionId -Credential $AzureCredential

    Write-Verbose "ComputerName for verifying if node is already registered with Azure: $($env:COMPUTERNAME)"

    $Registered = Get-AzureRmStorageSyncServer -SubscriptionId $AzureSubscriptionId -ResourceGroupName $AzureFileSyncResourceGroup -StorageSyncServiceName $AzureFileSyncInstanceName | Select-Object *,@{n='ComputerName';e={$PSitem.DisplayName.Split('.')[0]}} | Where-Object ComputerName -eq $env:COMPUTERNAME

    Write-Verbose "Number of registered instances with ComputerName $($env:COMPUTERNAME) : $(@($Registered).Count)"

    if (@($Registered).Count -eq 1) {

        Write-Verbose "Registered DisplayName $DisplayName : $($Registered.DisplayName)"

        $true

    } else {

        $false

    }

}


Export-ModuleMember -Function *-TargetResource
