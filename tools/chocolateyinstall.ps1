$ErrorActionPreference = 'Stop';

$packageName = 'EasyLogUSB'
$toolsDir    = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url         = 'https://s3.amazonaws.com/lascar_downloads/EasyLogUSB+Installer.exe' 
$checkSum    = '134e5dbc3a7489e8b0851c454f9e3330e888752362808cf4fdb5c48d09cf15d0'
$workSpace   = Join-Path $env:TEMP "$packageName.$env:chocolateyPackageVersion"

$webFileArgs = @{
  packageName         = $packageName
  fileFullPath        = Join-Path $WorkSpace "$packageName+Installer.exe"
  url                 = $url
  checksum            = $checkSum
  checksumType        = 'sha256'
  getOriginalFileName = $true
}

$packedInstaller = Get-ChocolateyWebFile @webFileArgs

# Extract the .msi EasyLogUSB+Installer.exe /s /x /b"." /v"/qn"
#
$statement = '/s /x /b"' + $workSpace + '" /v"/qn"'
Start-ChocolateyProcessAsAdmin -Statements "$statement" -ExeToRun "$packedInstaller" -ValidExitCodes @(0,1605)

$installArgs = @{
  packageName    = $packageName
  file           = Join-Path $WorkSpace "EasyLog USB.msi"
  fileType       = 'MSI'
  silentArgs     = "/qb /norestart /l*v `"$($env:TEMP)\$($packageName).$($env:chocolateyPackageVersion).MsiInstall.log`""
  validExitCodes = @(0, 3010, 1641)
}

Install-ChocolateyInstallPackage @installArgs

# silent install of EasyLog USB Device Driver requires AutoIT
#
$autoitExe = 'AutoIt3.exe'
$autoitFile = Join-Path $toolsDir 'LoggingEasyLogUSB.au3'
$fileFullPath = Join-Path $WorkSpace $fullPackage
Write-Debug "$autoitFile"
Write-Debug "$fileFullPath"
$autoitProc = Start-Process -FilePath $autoitExe -ArgumentList "$autoitFile" -PassThru
$autoitId = $autoitProc.Id
Write-Debug "$autoitExe start time:`t$($autoitProc.StartTime.ToShortTimeString())"
Write-Debug "Process ID: `t$autoitId"