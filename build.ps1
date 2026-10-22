$ErrorActionPreference = 'Stop'
Set-Location $PSScriptRoot
python scripts/build.py
if ($LASTEXITCODE -ne 0) { throw 'Build fehlgeschlagen.' }
