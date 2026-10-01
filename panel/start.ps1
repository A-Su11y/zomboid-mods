# start.ps1 - launch the local control panel.
#
# Idempotent: if the panel is already running on 127.0.0.1:8087, just opens
# the browser. Otherwise creates/updates the venv, starts the panel in the
# background, waits for it to come up, then opens the browser.

[CmdletBinding()]
param(
  [switch]$NoBrowser
)

$ErrorActionPreference = 'Stop'
Set-Location -LiteralPath $PSScriptRoot

function Test-PanelUp {
  try {
    $r = Invoke-WebRequest -Uri 'http://127.0.0.1:8087/api/status' -UseBasicParsing -TimeoutSec 2
    return $r.StatusCode -eq 200
  } catch {
    return $false
  }
}

if (Test-PanelUp) {
  Write-Host "[panel] already running at http://127.0.0.1:8087/" -ForegroundColor Green
  if (-not $NoBrowser) { Start-Process 'http://127.0.0.1:8087/' }
  exit 0
}

if (-not (Test-Path .venv)) {
  Write-Host "[panel] creating venv" -ForegroundColor Cyan
  python -m venv .venv
}

Write-Host "[panel] installing/updating dependencies" -ForegroundColor Cyan
& .\.venv\Scripts\python -m pip install -q --disable-pip-version-check -r requirements.txt

if (-not (Test-Path .env)) {
  if (Test-Path .env.example) {
    Write-Host "[panel] WARNING: no .env found. Copy .env.example to .env and edit FROZEN_ROOT + REPO_ROOT before next start." -ForegroundColor Yellow
    Write-Host "[panel] see $PSScriptRoot\.env.example" -ForegroundColor Yellow
    exit 1
  }
}

Write-Host "[panel] starting background process" -ForegroundColor Cyan
$py = (Resolve-Path '.\.venv\Scripts\python.exe').Path
$app = (Resolve-Path '.\app.py').Path
Start-Process -FilePath $py -ArgumentList $app -WindowStyle Hidden -WorkingDirectory $PSScriptRoot | Out-Null

$deadline = (Get-Date).AddSeconds(15)
while ((Get-Date) -lt $deadline) {
  if (Test-PanelUp) { break }
  Start-Sleep -Milliseconds 400
}

if (-not (Test-PanelUp)) {
  Write-Host "[panel] FAILED to come up in 15s. Run app.py manually to see the error:" -ForegroundColor Red
  Write-Host "        $py $app" -ForegroundColor Red
  exit 1
}

Write-Host "[panel] up at http://127.0.0.1:8087/" -ForegroundColor Green
if (-not $NoBrowser) { Start-Process 'http://127.0.0.1:8087/' }
