$ErrorActionPreference = "Stop"

$projectRoot = Split-Path -Parent $PSScriptRoot
Set-Location $projectRoot

$target = "RequestProject"

# Stage 1: sorry check
$files = Get-ChildItem -Path $target -Filter *.lean -Recurse -File
$hits = foreach ($file in $files) {
  Select-String -Path $file.FullName -Pattern "\bsorry\b" |
    Where-Object { $_.Line.Trim() -notmatch "^--" } |
    ForEach-Object {
      "{0}:{1}: {2}" -f (Resolve-Path -Relative $_.Path), $_.LineNumber, $_.Line.Trim()
    }
}

if ($hits.Count -gt 0) {
  Write-Host "Found TODO proofs (sorry) in ${target}:" -ForegroundColor Yellow
  $hits | ForEach-Object { Write-Host $_ }
  exit 1
}

Write-Host "No sorry found. You done good. Donut: (donut)" -ForegroundColor Green

# Stage 2: axiom audit
$auditFile = Join-Path $target "Audit.lean"
if (-not (Test-Path $auditFile)) {
  Write-Host "Audit.lean not found - skipping axiom check." -ForegroundColor Yellow
  exit 0
}

Write-Host "Running axiom audit..." -ForegroundColor Cyan
$auditOutput = lake env lean $auditFile 2>&1
$allowedAxioms = @("propext", "Classical.choice", "Quot.sound")

$badLines = $auditOutput | Where-Object {
  $line = $_.ToString().Trim()
  $line -ne "" -and
  $line -notmatch "^#print" -and
  -not ($allowedAxioms | Where-Object { $line -match [regex]::Escape($_) })
}

if ($badLines.Count -gt 0) {
  Write-Host "Unexpected axioms found:" -ForegroundColor Red
  $badLines | ForEach-Object { Write-Host $_ }
  exit 1
}

Write-Host "Axiom audit clean. Standard Mathlib baseline only." -ForegroundColor Green
exit 0