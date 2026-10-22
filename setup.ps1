$ErrorActionPreference = 'Stop'
Set-Location $PSScriptRoot
python scripts/setup.py
if ($LASTEXITCODE -ne 0) { throw 'Toolchain-Setup fehlgeschlagen.' }
