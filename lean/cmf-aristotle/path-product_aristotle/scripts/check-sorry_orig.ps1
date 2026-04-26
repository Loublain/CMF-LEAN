$ErrorActionPreference = "Stop"

$projectRoot = Split-Path -Parent $PSScriptRoot
Set-Location $projectRoot

$target = "RequestProject"
$files = Get-ChildItem -Path $target -Filter *.lean -Recurse -File
$hits = foreach ($file in $files) {
  Select-String -Path $file.FullName -Pattern "\bsorry\b" | ForEach-Object {
    "{0}:{1}: {2}" -f (Resolve-Path -Relative $_.Path), $_.LineNumber, $_.Line.Trim()
  }
}

if ($hits.Count -gt 0) {
  Write-Host "Found TODO proofs (`sorry`) in ${target}:" -ForegroundColor Yellow
  $hits | ForEach-Object { Write-Host $_ }
  exit 1
} else {
  Write-Host "No sorry found. You done good. Here's a donut: (donut)" -ForegroundColor Green
  exit 0
}
