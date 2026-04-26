$ErrorActionPreference = "Stop"

$projectRoot = Split-Path -Parent $MyInvocation.MyCommand.Path
$reviewPath = Join-Path $projectRoot "RequestProject/PathProducts-ELI5-Review.md"

if (-not (Test-Path $reviewPath)) {
  Write-Error "ELI5 review file not found at: $reviewPath"
}

Write-Host "Opening ELI5 review: $reviewPath" -ForegroundColor Cyan
Get-Content -Path $reviewPath
