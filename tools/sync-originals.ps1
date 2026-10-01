# sync-originals.ps1
#
# Refreshes mods/<Name>/original/ from the frozen bundle on A:\ or the NAS,
# so diffs against patched/ stay accurate when upstream mods change.
#
# Original folders are the pristine reference, not shipped. They're committed
# to the repo so patch diffs are visible, but this script lets you refresh
# them if the mod author updates on Workshop and you decide to rebase.

[CmdletBinding()]
param(
  [string]$BundleRoot = 'A:\ZomboidFrozen\mods'
)

$ErrorActionPreference = 'Stop'
$RepoRoot = Split-Path -Parent $PSScriptRoot
$ModsDir  = Join-Path $RepoRoot 'mods'

if (-not (Test-Path $BundleRoot)) { Write-Host "no bundle at $BundleRoot" -ForegroundColor Red; exit 1 }

foreach ($mod in Get-ChildItem $ModsDir -Directory) {
  $src = Join-Path $BundleRoot $mod.Name
  if (-not (Test-Path $src)) { Write-Host "skip $($mod.Name) (not in bundle)" -ForegroundColor Yellow; continue }
  $dst = Join-Path $mod.FullName 'original'
  if (Test-Path $dst) { Remove-Item $dst -Recurse -Force }
  Write-Host "sync $($mod.Name)" -ForegroundColor Cyan
  robocopy $src $dst /E /NFL /NDL /NJH /NP /NJS | Out-Null
}
Write-Host "done" -ForegroundColor Green
