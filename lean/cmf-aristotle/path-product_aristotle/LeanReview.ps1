$ErrorActionPreference = "Stop"

$projectRoot = Split-Path -Parent $MyInvocation.MyCommand.Path
$reviewPath = Join-Path $projectRoot "RequestProject/PathProducts-LeanReview.md"

if (-not (Test-Path $reviewPath)) {
  Write-Error "LeanReview file not found at: $reviewPath"
}

Write-Host "Opening LeanReview: $reviewPath" -ForegroundColor Cyan
Get-Content -Path $reviewPath
