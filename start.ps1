param([switch]$Headless, [switch]$Software, [switch]$Windowed)
$ErrorActionPreference = 'Stop'
Set-Location $PSScriptRoot
$qemu = Join-Path $PSScriptRoot 'tools/qemu/qemu-system-i386.exe'
if (!(Test-Path $qemu)) { throw 'QEMU fehlt. Bitte zuerst setup.ps1 ausfuehren.' }
if (!(Test-Path 'build/pingu-os.img')) { & "$PSScriptRoot/build.ps1" }
# Prevent Windows from bitmap-scaling the emulator window a second time.
$env:SDL_WINDOWS_DPI_AWARENESS = 'permonitorv2'
$qargs = @('-name','Ciwi OS','-machine','pc','-m','1024','-vga','std','-netdev','user,id=net0','-device','rtl8139,netdev=net0','-drive','file=build/pingu-os.img,format=raw,if=ide','-serial','file:build/serial.log','-rtc','base=localtime')
try {
    & "$PSScriptRoot/scripts/detect-display.ps1" | Write-Host
    $qargs += @('-fw_cfg','name=opt/pingu/display,file=build/host-display.bin')
} catch { Write-Host 'Monitorerkennung nicht verfuegbar; nutze gespeicherte Anzeige.' }
if ($Headless) { $qargs += @('-display','none') } else {
    $qargs += @('-display','sdl,gl=off')
    if (!$Windowed) { $qargs += '-full-screen' }
}
if ($Software) {
    & $qemu @qargs -accel tcg
} else {
    & $qemu @qargs -accel 'whpx,kernel-irqchip=off'
    if ($LASTEXITCODE -ne 0) {
        Write-Host 'Hardwarebeschleunigung nicht verfuegbar. Starte Softwaremodus.'
        & $qemu @qargs -accel tcg
    }
}


