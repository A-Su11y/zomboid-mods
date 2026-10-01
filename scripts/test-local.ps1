# test-local.ps1
#
# Overlay a mod's `patched/` contents into your local frozen Zomboid install,
# so you can launch and test the patch BEFORE committing/releasing it.
#
# To revert: double-click "Update Frozen Zomboid" on your Desktop. It will
# restore the released version, overwriting the local test overlay.
#
# Usage:
#   .\scripts\test-local.ps1 GunsOfMarz
#   .\scripts\test-local.ps1 GunsOfMarz -FrozenRoot 'D:\ZomboidFrozen'

[CmdletBinding()]
param(
  [Parameter(Mandatory=$true)][string]$Mod,
  [string]$FrozenRoot = "$env:USERPROFILE\ZomboidFrozen"
)

$ErrorActionPreference = 'Stop'

$RepoRoot = Split-Path -Parent $PSScriptRoot
$src = Join-Path $RepoRoot "mods\$Mod\patched"
if (-not (Test-Path $src)) {
  Write-Host "ERROR: no patched/ for '$Mod' at $src" -ForegroundColor Red
  exit 1
}

$modsDir = Join-Path $FrozenRoot 'userprofile\mods'
if (-not (Test-Path $modsDir)) {
  Write-Host "ERROR: no mods dir at $modsDir - is ZomboidFrozen installed?" -ForegroundColor Red
  exit 1
}

$dst = Join-Path $modsDir $Mod
if (Test-Path $dst) {
  $stamp = Get-Date -Format 'yyyyMMddHHmmss'
  $bak = "$dst.before-test-$stamp"
  Write-Host "[test-local] backing up current $Mod -> $(Split-Path $bak -Leaf)" -ForegroundColor Cyan
  Rename-Item -LiteralPath $dst -NewName (Split-Path $bak -Leaf)
}

Write-Host "[test-local] overlaying patched/$Mod -> $dst" -ForegroundColor Cyan
$roboArgs = @($src, $dst, '/E', '/COPY:DAT', '/DCOPY:DAT', '/R:2', '/W:2', '/NFL', '/NDL', '/NJH', '/NP', '/NJS')
& robocopy @roboArgs | Out-Null
if ($LASTEXITCODE -ge 8) {
  Write-Host "ERROR: robocopy failed (exit $LASTEXITCODE)" -ForegroundColor Red
  exit 1
}

# Mark it so the regular updater knows this is a dev overlay and will replace it.
Set-Content -LiteralPath (Join-Path $dst '.zm-version') -Value 'test-overlay' -Encoding ascii

Write-Host ""
Write-Host "Done. Launch Zomboid via your Desktop shortcut and test the patch." -ForegroundColor Green
Write-Host "To revert to the released version: double-click 'Update Frozen Zomboid'." -ForegroundColor Green
