# Werkzeuge und Fremdkomponenten

Der Kernel und die SVG-Icons und Demo-Medien wurden für dieses Projekt erstellt. Er benötigt zur Laufzeit keine Bibliothek und kein anderes Betriebssystem.

- **Inter** von Rasmus Andersson, SIL Open Font License 1.1. Originalschrift in `assets/Inter.ttf`, Lizenz in `assets/FONT-LICENSE.txt`. Quelle: https://github.com/google/fonts/tree/main/ofl/inter
- **Zig 0.13.0 / Clang / LLD** als Compiler und Linker, über das Paket `ziglang`. https://ziglang.org/download/0.13.0/
- **NASM 2.16.03**, BSD-Lizenz; nur Build-Werkzeug. https://www.nasm.us/
- **QEMU 10.2.0**, GPLv2 und komponentenspezifische Lizenzen; Emulator, nicht Bestandteil des Pingu-Kernels. Windows-Build: https://qemu.weilnetz.de/w64/2025/ ; Projekt und Quellen: https://www.qemu.org/
- **7-Zip** zum lokalen Entpacken der Werkzeuge. Lizenztexte liegen in `tools/7zip-full/`. https://www.7-zip.org/
- **resvg-py 0.5.0** zum SVG-Rasterisieren; **Pillow 12.3.0** für Schriftmasken und Screenshots. Ihre Paketlizenzen gelten für die Build-Werkzeuge.

Die heruntergeladenen Werkzeugarchive sind mit SHA-256 in `scripts/toolchain.json` fixiert. Die ursprünglichen Lizenzdateien bleiben in den entpackten Werkzeugverzeichnissen erhalten.


## 7-Zip-Entpacker im Pingu-Kernel (26.03)

Der native Installationspfad verwendet unveraenderte Decoderdateien aus dem offiziellen
7-Zip-Quellarchiv `7z2603-src.tar.xz` (Igor Pavlov), Quelle:
https://github.com/ip7z/7zip/releases/download/26.03/7z2603-src.tar.xz
Die eingebundenen Decoderdateien kennzeichnen sich als Public Domain. Der vollstaendige
mitgelieferte Lizenzhinweis steht in `third_party/7zip/DOC/License.txt`; die Quellen in
`third_party/7zip/C`. Nicht alle dort enthaltenen Dateien werden gelinkt.
`src/sevenzip.c` und die freestanding Header sind Pingu-Adapter.

Das Windows-Setup `downloads/7z2603.exe` und seine entpackten Originaldateien behalten
ihre eigenen 7-Zip-Lizenzen. `License.txt` wird mit installiert. Das Windows-Setup wird
nicht ausgefuehrt; dies ist keine Wine-Integration und keine Windows-API-Erweiterung.

- **Source Code Pro Regular**, Adobe, SIL Open Font License 1.1. Terminalschrift: `assets/SourceCodePro-Regular.ttf`; Lizenz: `assets/SOURCE-CODE-PRO-LICENSE.md`. Quelle: https://github.com/adobe-fonts/source-code-pro/tree/release .
