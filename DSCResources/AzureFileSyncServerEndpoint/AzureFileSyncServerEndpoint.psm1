function Get-TargetResource {
    [CmdletBinding()]
    [OutputType([System.Collections.Hashtable])]
    param
    (
        [parameter(Mandatory = $true)]
        [System.String]
        $AzureFileSyncGroup,

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
        [System.String]
        $ServerLocalPath,

        [parameter(Mandatory = $true)]
        [System.Management.Automation.PSCredential]
        $AzureCredential
    )

    $null = Import-Module "C:\Program Files\Azure\StorageSyncAgent\StorageSync.Management.PowerShell.Cmdlets.dll" -WarningAction SilentlyContinue

    $null = Login-AzureRmStorageSync -SubscriptionId $AzureSubscriptionId -Credential $AzureCredential


    Write-Verbose "ComputerName for verifying if node is already registered with Azure: $($env:COMPUTERNAME)"

    $Registered = Get-AzureRmStorageSyncServer -SubscriptionId $AzureSubscriptionId -ResourceGroupName $AzureFileSyncResourceGroup -StorageSyncServiceName $AzureFileSyncInstanceName | Select-Object *, @{n = 'ComputerName'; e = {$PSitem.DisplayName.Split('.')[0]}} | Where-Object ComputerName -eq $env:COMPUTERNAME

    Write-Verbose "Number of registered instances with ComputerName $($env:COMPUTERNAME) : $(@($Registered).Count)"

       if (Get-AzureRmStorageSyncServerEndpoint -ResourceGroupName $AzureFileSyncResourceGroup -StorageSyncServiceName $AzureFileSyncInstanceName -SyncGroupName $AzureFileSyncGroup | Select-Object *,@{n='ComputerName';e={$PSitem.DisplayName.Split('.')[0]}} | Where-Object ComputerName -eq $env:COMPUTERNAME) {

        $AzureStorageSyncServerEndpoint = $true

    } else {

        $AzureStorageSyncServerEndpoint = $false

    }

    $returnValue = @{
        AzureSubscriptionId        = $AzureSubscriptionId
        AzureFileSyncResourceGroup = $AzureFileSyncResourceGroup
        AzureFileSyncInstanceName  = $AzureFileSyncInstanceName
        AzureCredential            = $AzureCredential.UserName
        AzureStorageSyncServerEndpointCompliant = $AzureStorageSyncServerEndpoint
    }

    $returnValue
}


function Set-TargetResource {
    [CmdletBinding()]
    param
    (
        [System.String]
        $TierFilesOlderThanDays,

        [System.Boolean]
        $CloudTiering,

        [System.String]
        $VolumeFreeSpacePercent,

        [parameter(Mandatory = $true)]
        [System.String]
        $AzureFileSyncGroup,

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
        [System.String]
        $ServerLocalPath,

        [parameter(Mandatory = $true)]
        [System.Management.Automation.PSCredential]
        $AzureCredential
    )

    $null = Import-Module "C:\Program Files\Azure\StorageSyncAgent\StorageSync.Management.PowerShell.Cmdlets.dll" -WarningAction SilentlyContinue

    $null = Login-AzureRmStorageSync -SubscriptionId $AzureSubscriptionId -Credential $AzureCredential

    Write-Verbose "Variable AzureFileSyncSubscriptionId is $AzureSubscriptionId"
    Write-Verbose "Variable AzureFileSyncResourceGroup is $AzureFileSyncResourceGroup"
    Write-Verbose "Variable AzureFileSyncInstanceName is $AzureFileSyncInstanceName"
    Write-Verbose "Username for credential object AzureCredential is $($AzureCredential.UserName)"

    $null = Import-Module "C:\Program Files\Azure\StorageSyncAgent\StorageSync.Management.PowerShell.Cmdlets.dll" -WarningAction SilentlyContinue

    $null = Login-AzureRmStorageSync -SubscriptionId $AzureSubscriptionId -Credential $AzureCredential


    $Registered = Get-AzureRmStorageSyncServer -SubscriptionId $AzureSubscriptionId -ResourceGroupName $AzureFileSyncResourceGroup -StorageSyncServiceName $AzureFileSyncInstanceName | Select-Object *, @{n = 'ComputerName'; e = {$PSitem.DisplayName.Split('.')[0]}} | Where-Object ComputerName -eq $env:COMPUTERNAME

    $Parameters = @{}
    $Parameters.Add('ResourceGroupName',$AzureFileSyncResourceGroup)
    $Parameters.Add('StorageSyncServiceName',$AzureFileSyncInstanceName)
    $Parameters.Add('SyncGroupName',$AzureFileSyncGroup)
    $Parameters.Add('ServerId',$Registered.Id)
    $Parameters.Add('ServerLocalPath',$ServerLocalPath)

if ($PSBoundParameters.ContainsKey('CloudTiering')) {

    $Parameters.Add('CloudTiering',$CloudTiering)

}

if ($PSBoundParameters.ContainsKey('VolumeFreeSpacePercent')) {

    $Parameters.Add('VolumeFreeSpacePercent',$VolumeFreeSpacePercent)

}

if ($PSBoundParameters.ContainsKey('TierFilesOlderThanDays')) {

    $Parameters.Add('TierFilesOlderThanDays',$TierFilesOlderThanDays)

}

New-AzureRmStorageSyncServerEndpoint @Parameters

}


function Test-TargetResource {
    [CmdletBinding()]
    [OutputType([System.Boolean])]
    param
    (
        [System.String]
        $TierFilesOlderThanDays,

        [System.Boolean]
        $CloudTiering,

        [System.String]
        $VolumeFreeSpacePercent,

        [parameter(Mandatory = $true)]
        [System.String]
        $AzureFileSyncGroup,

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
        [System.String]
        $ServerLocalPath,

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

    $Registered = Get-AzureRmStorageSyncServer -SubscriptionId $AzureSubscriptionId -ResourceGroupName $AzureFileSyncResourceGroup -StorageSyncServiceName $AzureFileSyncInstanceName | Select-Object *, @{n = 'ComputerName'; e = {$PSitem.DisplayName.Split('.')[0]}} | Where-Object ComputerName -eq $env:COMPUTERNAME

    Write-Verbose "Number of registered instances with ComputerName $($env:COMPUTERNAME) : $(@($Registered).Count)"

    if (@($Registered).Count -eq 1) {

        Write-Verbose "Found server with registered DisplayName $DisplayName : $($Registered.DisplayName)"

        $AzureStorageSyncGroup = Get-AzureRmStorageSyncGroup -ResourceGroupName $AzureFileSyncResourceGroup -StorageSyncServiceName $AzureFileSyncInstanceName

        if (@($AzureStorageSyncGroup).Count -ge 1) {

            $AzureStorageSyncServerEndpoint = Get-AzureRmStorageSyncServerEndpoint -ResourceGroupName $AzureFileSyncResourceGroup -StorageSyncServiceName $AzureFileSyncInstanceName -SyncGroupName $AzureFileSyncGroup | Select-Object *, @{n = 'ComputerName'; e = {$PSitem.DisplayName.Split('.')[0]}} | Where-Object ComputerName -eq $env:COMPUTERNAME

            if (@($AzureStorageSyncServerEndpoint).Count -eq 1) {

                $LocalServerCurrentRegistration = Get-Item HKLM:\SOFTWARE\Microsoft\Azure\StorageSync\ServerRegistration | where Property -like ServerRegistration*

                if ($LocalServerCurrentRegistration) {

                    Write-Verbose "Local server is already registered - skipping registration"
                    $true

                } else {

                    Write-Verbose "Local server is not registered, adding even though existing server is present"
                    $false

                }


            }
            else {

                Write-Verbose "Sync group with name $AzureFileSyncGroup found, but server endpoint for $($env:COMPUTERNAME) is not present - returning false"

                $false

            }

        }
        else {

            Write-Verbose "No sync group with name $AzureFileSyncGroup found"
            Write-Verbose "Unable to find or add server endpoint - returning false"

            $false

        }



    }
    else {

        Write-Verbose "No server registered with DisplayName $DisplayName : $($Registered.DisplayName)"
        Write-Verbose "Unable to find or add server endpoint - returning false"

        $false

    }

}


Export-ModuleMember -Function *-TargetResource
