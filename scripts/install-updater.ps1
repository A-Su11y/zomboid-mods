# install-updater.ps1
#
# One-time setup. Downloads the Zomboid patch updater to your frozen-install
# directory and puts a shortcut on your Desktop. Re-running is safe.
#
# Paste this into PowerShell:
#   irm https://raw.githubusercontent.com/A-Su11y/zomboid-mods/main/scripts/install-updater.ps1 | iex
#
# If your frozen install isn't at %USERPROFILE%\ZomboidFrozen, set the env
# var before running:
#   $env:FROZEN_ROOT = 'M:\ZomboidFrozen'
#   irm https://.../install-updater.ps1 | iex

$ErrorActionPreference = 'Stop'

$Repo = 'A-Su11y/zomboid-mods'
$FrozenRoot = if ($env:FROZEN_ROOT) { $env:FROZEN_ROOT } else { "$env:USERPROFILE\ZomboidFrozen" }

Write-Host "Installing Zomboid patches updater -> $FrozenRoot" -ForegroundColor Cyan

if (-not (Test-Path $FrozenRoot)) {
  Write-Host "" -NoNewline
  Write-Host "WARN: no frozen install found at $FrozenRoot" -ForegroundColor Yellow
  Write-Host "If your frozen Zomboid lives elsewhere, press Ctrl-C now and re-run with:" -ForegroundColor Yellow
  Write-Host "  `$env:FROZEN_ROOT = 'D:\path\to\ZomboidFrozen'; irm ... | iex" -ForegroundColor Yellow
  Write-Host "Otherwise this script will create the folder and continue." -ForegroundColor Yellow
  New-Item -ItemType Directory -Path $FrozenRoot -Force | Out-Null
}

$dest = Join-Path $FrozenRoot 'update-frozen-zomboid.ps1'
Invoke-WebRequest "https://raw.githubusercontent.com/$Repo/main/scripts/update-frozen-zomboid.ps1" -OutFile $dest -UseBasicParsing
Write-Host "  downloaded updater -> $dest"

$shortcut = Join-Path ([Environment]::GetFolderPath('Desktop')) 'Update Frozen Zomboid.lnk'
$sh = New-Object -ComObject WScript.Shell
$lnk = $sh.CreateShortcut($shortcut)
$lnk.TargetPath = 'powershell.exe'
$lnk.Arguments = "-NoProfile -ExecutionPolicy Bypass -File `"$dest`" -FrozenRoot `"$FrozenRoot`""
$lnk.WorkingDirectory = $FrozenRoot
$lnk.Description = 'Pull the latest Zomboid patches into your frozen client'
$lnk.Save()
Write-Host "  created shortcut   -> $shortcut"

Write-Host ""
Write-Host "Done. Each time a patch drops, double-click 'Update Frozen Zomboid'" -ForegroundColor Green
Write-Host "on your Desktop BEFORE launching Zomboid." -ForegroundColor Green
