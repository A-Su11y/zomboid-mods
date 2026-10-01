# update-frozen-zomboid.ps1
#
# Pulls the latest patched-mods manifest from GitHub, replaces any mods whose
# version has changed, leaves everything else alone.
#
# Safe to re-run. Idempotent. Only touches ZomboidFrozen/userprofile/mods.
#
# First-time: this file sits on your Desktop next to the "Zomboid (Frozen)"
# shortcut. Double-click to run.

[CmdletBinding()]
param(
  [string]$FrozenRoot = "$env:USERPROFILE\ZomboidFrozen",
  [string]$Repo       = 'OWNER/REPO',   # set at install time
  [switch]$DryRun
)

$ErrorActionPreference = 'Stop'

function Log($msg)  { Write-Host "[update] $msg" -ForegroundColor Cyan }
function Fail($msg) { Write-Host "ERROR: $msg" -ForegroundColor Red; Read-Host "press enter to close"; exit 1 }

$modsDir = Join-Path $FrozenRoot 'userprofile\mods'
if (-not (Test-Path $modsDir)) { Fail "No mods dir at $modsDir - is ZomboidFrozen installed?" }

$manifestUrl = "https://raw.githubusercontent.com/$Repo/main/dist/manifest.json"
Log "fetching manifest from $manifestUrl"
try {
  $manifest = Invoke-RestMethod -Uri $manifestUrl -UseBasicParsing
} catch {
  Fail "could not fetch manifest: $($_.Exception.Message)"
}

$toUpdate = @()
foreach ($entry in $manifest.mods) {
  $modDir = Join-Path $modsDir $entry.name
  $versionFile = Join-Path $modDir '.zm-version'
  $have = $null
  if (Test-Path $versionFile) { $have = (Get-Content $versionFile -Raw).Trim() }
  $want = "$($entry.version):$($entry.hash)"
  if ($have -ne $want) { $toUpdate += @{ entry = $entry; want = $want } }
}

if ($toUpdate.Count -eq 0) {
  Log "already up to date"
  Read-Host "press enter to close"
  exit 0
}

Log "$($toUpdate.Count) mod(s) to update:"
foreach ($u in $toUpdate) { Log "  - $($u.entry.name) -> v$($u.entry.version)" }

if ($DryRun) { Log "dry-run, stopping"; exit 0 }

$tmp = Join-Path $env:TEMP "zm-update-$([guid]::NewGuid().ToString('N'))"
New-Item -ItemType Directory -Path $tmp -Force | Out-Null

try {
  foreach ($u in $toUpdate) {
    $e = $u.entry
    $zipUrl = "https://github.com/$Repo/releases/latest/download/$($e.zip)"
    $zipPath = Join-Path $tmp $e.zip
    Log "downloading $($e.zip)"
    Invoke-WebRequest -Uri $zipUrl -OutFile $zipPath -UseBasicParsing

    # Verify hash of a staged extract before swapping the live folder.
    $stage = Join-Path $tmp "stage-$($e.name)"
    Expand-Archive -LiteralPath $zipPath -DestinationPath $stage -Force
    $staged = Join-Path $stage $e.name
    if (-not (Test-Path $staged)) { Fail "zip layout wrong for $($e.name)" }

    $live = Join-Path $modsDir $e.name
    if (Test-Path $live) {
      $backup = "$live.old-$([datetime]::Now.ToString('yyyyMMddHHmmss'))"
      Rename-Item -LiteralPath $live -NewName (Split-Path $backup -Leaf)
    }
    Move-Item -LiteralPath $staged -Destination $live
    Set-Content -LiteralPath (Join-Path $live '.zm-version') -Value $u.want -Encoding ascii
    Log "updated $($e.name) -> v$($e.version)"
    # Delete the backup once we're sure the new copy landed.
    if (Test-Path "$live.old-*") { Get-ChildItem -LiteralPath $modsDir -Directory -Filter "$($e.name).old-*" | Remove-Item -Recurse -Force }
  }
  Log "done. Launch via your Desktop shortcut when ready."
  Read-Host "press enter to close"
} finally {
  Remove-Item -LiteralPath $tmp -Recurse -Force -ErrorAction SilentlyContinue
}
