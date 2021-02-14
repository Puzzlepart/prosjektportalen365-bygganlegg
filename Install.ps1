Param(
    [Parameter(Mandatory = $true, HelpMessage = "N/A")]
    [string]$Url,
    [Parameter(Mandatory = $false, HelpMessage = "Stored credential from Windows Credential Manager")]
    [string]$GenericCredential,
    [Parameter(Mandatory = $false, HelpMessage = "Use Web Login")]
    [switch]$UseWebLogin,
    [Parameter(Mandatory = $false, HelpMessage = "Do you want to perform an upgrade?")]
    [switch]$Upgrade,
    [Parameter(Mandatory = $false, HelpMessage = "Do you want to include bygg phase check lists and tasks?")]
    [switch]$IncludeBygg,
    [Parameter(Mandatory = $false, HelpMessage = "Do you want to include anlegg phase check lists and tasks?")]
    [switch]$IncludeAnlegg
)

function Connect-SharePoint {
    Param(
        [Parameter(Mandatory = $true)]
        [string]$Url
    )

    Try {
        if (-not [string]::IsNullOrEmpty($CI)) {
            $DecodedCred = ([System.Text.Encoding]::UTF8.GetString([System.Convert]::FromBase64String($CI))).Split("|")
            $Password = ConvertTo-SecureString -String $DecodedCred[1] -AsPlainText -Force
            $Credentials = New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList $DecodedCred[0], $Password
            Connect-PnPOnline -Url $Url -Credentials $Credentials -ErrorAction Stop
        }
        elseif ($UseWebLogin.IsPresent) {
            Connect-PnPOnline -Url $Url -UseWebLogin -ErrorAction Stop
        }
        elseif ($null -ne $PSCredential) {
            Connect-PnPOnline -Url $Url -Credentials $PSCredential -ErrorAction Stop
        }
        elseif ($null -ne $GenericCredential -and $GenericCredential -ne "") {
            Connect-PnPOnline -Url $Url -Credentials $GenericCredential -ErrorAction Stop
        }
        else {
            Connect-PnPOnline -Url $Url -ErrorAction Stop
        }
    }
    Catch {
        Write-Host "[INFO] Failed to connect to [$Url]: $($_.Exception.Message)"
        throw $_.Exception.Message
    }
}

#region Setting variables
[System.Uri]$Uri = $Url
$ManagedPath = $Uri.Segments[1]
$Alias = $Uri.Segments[2].TrimEnd('/')
$AdminSiteUrl = (@($Uri.Scheme, "://", $Uri.Authority) -join "").Replace(".sharepoint.com", "-admin.sharepoint.com")
#endregion

#region Print installation user
Connect-SharePoint -Url $AdminSiteUrl -ErrorAction Stop
$CurrentUser = Get-PnPProperty -Property CurrentUser -ClientObject (Get-PnPContext).Web
Write-Host "[INFO] Installing with user [$($CurrentUser.Email)]"
Disconnect-PnPOnline
#endregion

#region Check if URL specified is root site or admin site or invalid managed path
if ($Alias.Length -lt 2 -or (@("sites/", "teams/") -notcontains $ManagedPath) -or $Uri.Authority.Contains("-admin")) {
    Write-Host "[ERROR] It looks like you're trying to install to a root site or an invalid site. This is not supported." -ForegroundColor Red
    exit 0
}
#endregion

Set-PnPTraceLog -On -Level Debug -LogFile Install_Log.txt  

Connect-SharePoint -Url $AdminSiteUrl -ErrorAction Stop
Set-PnPTenantSite -NoScriptSite:$false -Url $Url -ErrorAction SilentlyContinue >$null 2>&1        
Disconnect-PnPOnline


Connect-SharePoint -Url $Url -ErrorAction Stop

# Applying additional check that we're connected to the correct site before applying templates
$CurrentContext = Get-PnPContext
if ($CurrentContext.Url -ne $Url) {
    Write-Host "[ERROR] Attempted to install to $Url but connection was active against $($CurrentContext.Url)"
    throw "Wrong connection identified - you are not connected to the correct site"
}

$BasePath =  "$PSScriptRoot\Templates"

Write-Host "[INFO] Applying PnP template [Portfolio] to [$Url]"
Apply-PnPProvisioningTemplate "$BasePath\Portfolio\Portfolio.xml" -ErrorAction Stop -Handlers Lists
Write-Host "[SUCCESS] Successfully applied PnP template [Portfolio] to [$Url]" -ForegroundColor Green

if ($IncludeBygg.IsPresent) {
    if ($Upgrade.IsPresent) {
        Write-Host "[INFO] Applying Bygg PnP content template (Handlers:Files) to [$Url]"
        Apply-PnPProvisioningTemplate "$BasePath\Content-Bygg\Content-Bygg.xml" -Handlers Files -ErrorAction Stop
        Write-Host "[SUCCESS] Successfully applied PnP content template to [$Url]" -ForegroundColor Green
    }
    else {
        Write-Host "[INFO] Applying Bygg PnP content template to [$Url]"
        Apply-PnPProvisioningTemplate "$BasePath\Content-Bygg\Content-Bygg.xml" -ErrorAction Stop
        Write-Host "[SUCCESS] Successfully applied PnP content template to [$Url]" -ForegroundColor Green
    }
} elseif ($IncludeAnlegg.IsPresent) {
    if ($Upgrade.IsPresent) {
        Write-Host "[INFO] Applying Anlegg PnP content template (Handlers:Files) to [$Url]"
        Apply-PnPProvisioningTemplate "$BasePath\Content-Anlegg\Content-Anlegg.xml" -Handlers Files -ErrorAction Stop
        Write-Host "[SUCCESS] Successfully applied PnP content template to [$Url]" -ForegroundColor Green
    }
    else {
        Write-Host "[INFO] Applying Anlegg PnP content template to [$Url]"
        Apply-PnPProvisioningTemplate "$BasePath\Content-Anlegg\Content-Anlegg.xml" -ErrorAction Stop
        Write-Host "[SUCCESS] Successfully applied PnP content template to [$Url]" -ForegroundColor Green
    }
}

Disconnect-PnPOnline