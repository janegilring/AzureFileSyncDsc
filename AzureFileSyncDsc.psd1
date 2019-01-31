@{
    # Version number of this module.
    moduleVersion     = '1.0.0.1'

    # ID used to uniquely identify this module.
    GUID              = '70b9e862-92a5-496e-a44a-c5f3c77eaa36'

    # Author of this module
    Author = 'Jan Egil Ring'

    # Company or vendor of this module
    CompanyName = 'PSCommunity'

    # Copyright statement for this module
    Copyright = '(c) 2019 Jan Egil Ring. All rights reserved.'

    # Description of the functionality provided by this module
    Description       = 'DSC Resource Module for installing and configuring Azure File Sync agent'

    # Minimum version of the Windows PowerShell engine required by this module
    PowerShellVersion = '4.0'

    # Minimum version of the common language runtime (CLR) required by this module
    CLRVersion        = '4.0'

    # Functions to export from this module
    FunctionsToExport = '*.TargetResource'

    # Cmdlets to export from this module
    CmdletsToExport = @()

    # Private data to pass to the module specified in RootModule/ModuleToProcess. This may also contain a PSData hashtable with additional module metadata used by PowerShell.
    PrivateData       = @{

        PSData = @{

            # Tags applied to this module. These help with module discovery in online galleries.
            Tags         = @('DesiredStateConfiguration', 'DSC', 'DSCResource', 'Azure', 'AzureFileSync')

            # A URL to the license for this module.
            LicenseUri   = 'https://github.com/janegilring/AzureFileSyncDsc/blob/master/LICENSE'

            # A URL to the main website for this project.
            ProjectUri   = 'https://github.com/janegilring/AzureFileSyncDsc'

            # ReleaseNotes of this module
            ReleaseNotes = ''

        } # End of PSData hashtable

    } # End of PrivateData hashtable
}
