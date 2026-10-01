# build.ps1 - package patched mods into zips, update manifest, publish release.
#
# Usage:
#   .\scripts\build.ps1                 # build everything that changed, release
#   .\scripts\build.ps1 -DryRun         # build + manifest, no git/gh
#   .\scripts\build.ps1 -NoRelease      # commit + push, skip gh release
#
# Idempotent: unchanged mods keep their current version number.

[CmdletBinding()]
param(
  [switch]$DryRun,
  [switch]$NoRelease
)

$ErrorActionPreference = 'Stop'

$RepoRoot = Split-Path -Parent $PSScriptRoot
$ModsDir  = Join-Path $RepoRoot 'mods'
$DistDir  = Join-Path $RepoRoot 'dist'
$Manifest = Join-Path $DistDir 'manifest.json'

function Log($msg) { Write-Host "[build] $msg" -ForegroundColor Cyan }
function Fail($msg) { Write-Host "ERROR: $msg" -ForegroundColor Red; exit 1 }

if (-not (Test-Path $ModsDir)) { Fail "No mods/ dir." }
New-Item -ItemType Directory -Path $DistDir -Force | Out-Null

function Get-DirHash($dir) {
  $files = Get-ChildItem -LiteralPath $dir -Recurse -File | Sort-Object FullName
  $sha = [System.Security.Cryptography.SHA256]::Create()
  $ms = New-Object System.IO.MemoryStream
  foreach ($f in $files) {
    $rel = $f.FullName.Substring($dir.Length).Replace('\','/')
    $relBytes = [Text.Encoding]::UTF8.GetBytes($rel + "`0")
    $ms.Write($relBytes, 0, $relBytes.Length)
    $content = [IO.File]::ReadAllBytes($f.FullName)
    $ms.Write($content, 0, $content.Length)
    $ms.WriteByte(0)
  }
  $ms.Position = 0
  $hash = $sha.ComputeHash($ms)
  ($hash | ForEach-Object { $_.ToString('x2') }) -join ''
}

# Load existing manifest if any.
$existing = @{}
if (Test-Path $Manifest) {
  $json = Get-Content $Manifest -Raw | ConvertFrom-Json
  foreach ($entry in $json.mods) { $existing[$entry.name] = $entry }
}

$mods = Get-ChildItem $ModsDir -Directory
$manifestOut = [ordered]@{
  schema  = 1
  updated = (Get-Date).ToString('yyyy-MM-ddTHH:mm:ssZ')
  mods    = @()
}

$changed = @()

foreach ($mod in $mods) {
  $patched = Join-Path $mod.FullName 'patched'
  if (-not (Test-Path $patched)) {
    Log "skip $($mod.Name) - no patched/ dir"
    continue
  }
  $hash = Get-DirHash $patched
  $prev = $existing[$mod.Name]
  $version = if ($prev -and $prev.hash -eq $hash) { $prev.version } else {
    $next = if ($prev) { [int]$prev.version + 1 } else { 1 }
    $next
  }
  $zipName = "$($mod.Name)-v$version.zip"
  $zipPath = Join-Path $DistDir $zipName

  if (-not (Test-Path $zipPath) -or ($prev -and $prev.hash -ne $hash)) {
    if (Test-Path $zipPath) { Remove-Item $zipPath }
    Log "zipping $($mod.Name) -> $zipName"
    # Zip the mod folder itself (so extract into mods/ places it correctly)
    # Zoomboid wants the mod folder at the top of the archive.
    $staging = Join-Path $env:TEMP "zm-stage-$([guid]::NewGuid().ToString('N'))"
    New-Item -ItemType Directory -Path $staging -Force | Out-Null
    try {
      $target = Join-Path $staging $mod.Name
      Copy-Item -LiteralPath $patched -Destination $target -Recurse
      Compress-Archive -Path $target -DestinationPath $zipPath -CompressionLevel Optimal
    } finally {
      Remove-Item $staging -Recurse -Force -ErrorAction SilentlyContinue
    }
    $changed += $mod.Name
  } else {
    Log "unchanged $($mod.Name) v$version"
  }

  $size = (Get-Item $zipPath).Length
  $manifestOut.mods += [ordered]@{
    name    = $mod.Name
    version = $version
    hash    = $hash
    zip     = $zipName
    bytes   = $size
  }
}

$manifestOut | ConvertTo-Json -Depth 5 | Set-Content -LiteralPath $Manifest -Encoding utf8
Log "wrote $Manifest"

if ($DryRun) {
  Log "dry-run: skipping git + release"
  exit 0
}

Push-Location $RepoRoot
try {
  if ($changed.Count -eq 0) {
    Log "no changes; nothing to commit or release"
    exit 0
  }

  git add .
  $tag = "v" + (Get-Date).ToString('yyyyMMdd-HHmm')
  $summary = ($changed -join ', ')
  git commit -m "release $tag`n`nchanged: $summary"
  git push

  if ($NoRelease) {
    Log "release skipped (-NoRelease)"
    exit 0
  }

  git tag $tag
  git push origin $tag

  $notes = "Updated mods: $summary"
  $zipArgs = Get-ChildItem $DistDir -Filter '*.zip' | ForEach-Object { $_.FullName }
  gh release create $tag $zipArgs --title $tag --notes $notes
  Log "released $tag"
} finally {
  Pop-Location
}
