# Pingu OS 0.9 PEX – Testbericht

26.09.2026, QEMU/WHPX, 1920 x 1080, eigener x86-Kernel.

- 22 PEX-/Runtime-/Tray-Pruefungen bestanden: unveraenderter PE-Payload, Paketmigration, nativer synchroner Dialog, Heap-Freigabe, Exitcode 123, Verpacken in Pingu, Schutz vor Ueberschreiben, Startsuche, direkte EXE, defektes Paket, unbekannte DLL, vier Tooltips, persistentes Ethernet-Umschalten, helle Darstellung und pixelgenaue Overlay-Bereinigung.
- 21 bestehende Animationspruefungen bestanden.
- 12 bestehende Grafik-/Desktoppruefungen bestanden, darunter Teil-/Vollneuzeichnung, Cursorreste, Andocken und stabile Taskleistenreihenfolge.
- Build mit Warnungen als Fehler; Kernel 438596 Bytes. SHA-256: f03821a8e0fb021a21a77e1091bcd0c863e5217d88546607a3b789fc87e6e637.

Nachweise: build/pex09-results.json, build/pex09-motion-results.json, build/flow-results.json. Echte Gastaufnahmen: screenshots/pex09-native-messagebox.png, pex09-quick-dark.png, pex09-quick-light.png, pex09-tray-tooltip.png.

Grenzen: dokumentierte kleine Win32-Teilmenge ohne Prozessisolation, ELF-Userspace, Wine, Threads, Registry oder dynamische DLLs. Paketpruefsumme ist keine Signatur. Statusanzeigen ersetzen keine WLAN-/Audio-/Akkutreiber. Keine allgemeine Fehlerfreiheits- oder Langzeitstabilitaetsgarantie.
