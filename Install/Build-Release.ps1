[Diagnostics.CodeAnalysis.SuppressMessageAttribute("PSUseDeclaredVarsMoreThanAssignments", "")]
Param(
    [Parameter(Mandatory = $false, HelpMessage = "CI mode. Installs SharePointPnPPowerShellOnline.")]
    [switch]$CI
)  

$PACKAGE_FILE = Get-Content "$PSScriptRoot/../package.json" -Raw | ConvertFrom-Json

Write-Host "[Building release v$($PACKAGE_FILE.version)]" -ForegroundColor Cyan

#region Paths
$ROOT_PATH                      = "$PSScriptRoot/.."
$PNP_TEMPLATES_BASEPATH         = "$ROOT_PATH/Templates"
$GIT_HASH                       = git log --pretty=format:'%h' -n 1
$RELEASE_NAME                   = "$($PACKAGE_FILE.name)-$($PACKAGE_FILE.version).$($GIT_HASH)"
$RELEASE_PATH                   = "$ROOT_PATH/release/$($RELEASE_NAME)"
#endregion

if ($CI.IsPresent) {
    Write-Host "[Running in CI mode. Installing module SharePointPnPPowerShellOnline.]" -ForegroundColor Yellow
    Install-Module -Name SharePointPnPPowerShellOnline -Force -Scope CurrentUser
}

$sw = [Diagnostics.Stopwatch]::StartNew()

if ($CI.IsPresent) {
    $RELEASE_PATH = "$ROOT_PATH/release"
}

Write-Host "[INFO] Creating release folder $RELEASE_PATH...  " -NoNewline
Remove-Item -Path "$ROOT_PATH/release" -Force -Recurse -ErrorAction SilentlyContinue 
mkdir $RELEASE_PATH >$null 2>&1
$RELEASE_PATH_TEMPLATES     = (mkdir "$RELEASE_PATH/Templates").FullName
Write-Host "DONE" -ForegroundColor Green

#region Copying source files
Write-Host "[INFO] Copying Install.ps1...  " -NoNewline
Copy-Item -Path "$PSScriptRoot/Install.ps1" -Destination $RELEASE_PATH -Force
Write-Host "DONE" -ForegroundColor Green

(Get-Content "$RELEASE_PATH/Install.ps1") -Replace 'VERSION_PLACEHOLDER', $PACKAGE_FILE.version | Set-Content "$RELEASE_PATH/Install.ps1"
#endregion


#region Build PnP templates
Set-Location $PSScriptRoot
Write-Host "[INFO] Building [Portfolio] PnP template...  " -NoNewline
Convert-PnPFolderToProvisioningTemplate -Out "$RELEASE_PATH_TEMPLATES/Portfolio.pnp" -Folder "$PNP_TEMPLATES_BASEPATH/Portfolio" -Force
Write-Host "DONE" -ForegroundColor Green

Write-Host "[INFO] Building PnP content templates...  " -NoNewline
Convert-PnPFolderToProvisioningTemplate -Out "$RELEASE_PATH_TEMPLATES/Content-Anlegg.pnp" -Folder "$PNP_TEMPLATES_BASEPATH/Content-Anlegg" -Force
Convert-PnPFolderToProvisioningTemplate -Out "$RELEASE_PATH_TEMPLATES/Content-Bygg.pnp" -Folder "$PNP_TEMPLATES_BASEPATH/Content-Bygg" -Force
Write-Host "DONE" -ForegroundColor Green

Set-Location $PSScriptRoot
#endregion

$sw.Stop()

if (-not $CI.IsPresent) {
    Add-Type -Assembly "System.IO.Compression.FileSystem"
    [IO.Compression.ZipFile]::CreateFromDirectory($RELEASE_PATH, "$($RELEASE_PATH).zip")  
    Write-Host "Done building release [v$($PACKAGE_FILE.version)] in [$($sw.Elapsed)]" -ForegroundColor Cyan
}
