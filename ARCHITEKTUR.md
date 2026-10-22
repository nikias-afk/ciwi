# Pingu OS 0.3 Ã¢â‚¬â€œ Architektur

## Boot und AusfÃƒÂ¼hrung

Ein 512-Byte-BIOS-Bootsektor lÃƒÂ¤dt vier Loader-Sektoren nach 0x8000. Der Loader lÃƒÂ¤dt 896 Sektoren ab LBA 5 nach 0x10000, richtet VBE 1024Ãƒâ€”768Ãƒâ€”32 ein, aktiviert A20 und wechselt ÃƒÂ¼ber eine eigene GDT in den Protected Mode. Linker-Limit: 448 KiB geladener Kernel. BSS beginnt bei 0x200000, Stack bei 0x1f0000. QEMU erhÃƒÂ¤lt 128 MiB RAM.

Der Kernel benutzt statische Speicherbereiche ohne Paging/Heap oder Prozessisolation. IRQs sammeln Eingaben in einem Ringpuffer; der Hauptloop verarbeitet Eingaben, Netzwerk und App-ZustÃƒÂ¤nde kooperativ. ZwÃƒÂ¶lf Fenster sind mÃƒÂ¶glich. Es handelt sich um GUI-Multitasking im selben Adressraum, nicht um isolierte Windows-artige Prozesse. Eine blockierende EXE blockiert daher das System.

## Grafik und Eingabe

Software-Rendering in einem maximal 2560Ãƒâ€”1600 groÃƒÅ¸en ARGB-Puffer. Der Bochs-DISPI-Treiber schaltet die unterstÃƒÂ¼tzten QEMU-AuflÃƒÂ¶sungen um. SVGs werden beim Build mit resvg in PNG und anschlieÃƒÅ¸end ARGB-Arrays umgewandelt. Inter wird in drei SchriftgrÃƒÂ¶ÃƒÅ¸en rasterisiert. Keine GPU-Beschleunigung.

Fenster haben Z-Reihenfolge, Fokus, alte Geometrie, Minimierungszustand und App-Daten. Andocken nutzt halbe Bildschirmbreite. Die FensterÃƒÂ¼bersicht verwendet verkleinerte echte Renderinhalte. Anwendungen werden geclippt; sehr schmale angedockte Fenster kÃƒÂ¶nnen Teile der App-OberflÃƒÂ¤che abschneiden. Maus: PS/2 mit ausgehandeltem Vier-Byte-IntelliMouse-Protokoll und Mausrad; RÃƒÂ¼ckfall auf drei Bytes. Tastatur: Scan-Code-Satz 1, begrenztes ASCII-QWERTZ-Layout.

Die Szenenpixel enthalten keinen dauerhaft eingezeichneten Mauszeiger. Zum PrÃƒÂ¤sentieren des Zeigers werden hÃƒÂ¶chstens zwei 72Ãƒâ€”72-Bereiche aktualisiert; der Szenenpuffer wird anschlieÃƒÅ¸end wiederhergestellt. Statische Szenen werden nicht mehr jede Sekunde vollstÃƒÂ¤ndig neu gezeichnet. Die Uhr und laufende Zeitwerkzeuge lÃƒÂ¶sen bedarfsabhÃƒÂ¤ngig Aktualisierungen aus.

Rechtecke verwenden zusammenhÃƒÂ¤ngende ZeilenfÃƒÂ¼llungen mit REP STOSL; die Ausgabe kopiert Zeilen mit REP MOVSL. Abgerundete FlÃƒÂ¤chen berechnen nur die Eckbereiche. Beim Ziehen wird die Vereinigung alter und neuer Fenstergrenzen neu aufgebaut. Ein zwischengespeicherter Hintergrund und ein Fensterbild beschleunigen Fenster bis 1920Ãƒâ€”1080; grÃƒÂ¶ÃƒÅ¸ere Fenster verwenden die normale Teil-Neuzeichnung. Der Hintergrundpuffer dient auÃƒÅ¸erhalb des Ziehens zugleich als Desktop-Cache. Der Linker verhindert eine ÃƒÅ“berlappung dieser Puffer mit dem reservierten PE-Bereich bei 64 MiB.

Der Starter unterstÃƒÂ¼tzt WHPX mit deaktiviertem Kernel-IRQ-Chip. Der Gast bleibt ein eigener Kernel und rendert weiterhin in Software; WHPX ist CPU-Virtualisierung, keine GPU-Beschleunigung. Der PS/2-Treiber leert mehrere bereitliegende Bytes je Interrupt und prÃƒÂ¼ft den Controller zusÃƒÂ¤tzlich im Hauptloop. ATA-PIO verwendet gebÃƒÂ¼ndelte REP-INSW/OUTSW-Transfers.

## DatentrÃƒÂ¤ger

64-MiB-RAW-Image, eigenes PinguFS, keine Partitionstabelle. Version 2 enthÃƒÂ¤lt ein Profil, Einstellungen, Installationsflags und 80 Datei-/OrdnereintrÃƒÂ¤ge. Text liegt inline; BMP/AVI/EXE liegen in zugewiesenen Sektoren. Reservierte Bereiche:

| Bereich | LBA |
|---|---|
| Boot + Loader | 0Ã¢â‚¬â€œ4 |
| Kernel | 5Ã¢â‚¬â€œ900 |
| Alte v1-BÃƒÂ¤nke zur Migration | 2048 / 2176 |
| v2-BÃƒÂ¤nke, je 1536 Sektoren | 4096 / 5632 |
| GebÃƒÂ¼ndelte Demo-Medien | ab 32768 |
| Neue Medien | ab 49152 |

Speichern invalidiert die Zielbank, schreibt und flusht den Payload, schreibt anschlieÃƒÅ¸end einen gÃƒÂ¼ltigen Header mit Generation und FNV-1a-PrÃƒÂ¼fsummen. Laden prÃƒÂ¼ft beide BÃƒÂ¤nke und nimmt die neueste gÃƒÂ¼ltige. Die vorherige Bank bleibt erhalten. Dies ist kein journalisiertes allgemeines Dateisystem. MedienblÃƒÂ¶cke werden angehÃƒÂ¤ngt und noch nicht wiederverwendet. Alte v1-Textdateien werden beim ersten v2-Start ÃƒÂ¼bernommen; eine Sicherung der v0.1 liegt in backups.

## Profil

Gesalzener PBKDF2-HMAC-SHA256-Hash mit 4096 Iterationen, kein gespeichertes Klartextpasswort. Salt-Erzeugung verwendet einen einfachen Kernel-Zufallszustand und ist nicht kryptografisch abgesichert. Nach drei Fehlversuchen kurze Pause. Die Sperre verschlÃƒÂ¼sselt nichts und schÃƒÂ¼tzt nicht gegen direkten Imagezugriff oder Kernelcode. Keine belastbare Sicherheitsarchitektur.

## Netzwerk

Eigener RTL8139-PCI/I/O-Treiber mit RX-Ring und vier TX-Puffern. QEMU-NAT: 10.0.2.15, Gateway 10.0.2.2, DNS 10.0.2.3. ARP, IPv4, UDP/DNS und einfacher TCP/HTTP-Client. Eine Anfrage gleichzeitig; beschrÃƒÂ¤nkte Puffer, Timeouts und begrenzte Wiederholung. HTML wird zu Text reduziert. Kein TLS, CSS, JavaScript, Cookies oder vollstÃƒÂ¤ndiger TCP/Web-Standard.

## Apps und EXE

100 KatalogeintrÃƒÂ¤ge: Systemprogramme, Medien, drei einfache Office-Apps, Spiele, Zeitwerkzeuge, Texttransformationen, Umrechner und Rechner. Mehrere Anwendungen verwenden dieselben geprÃƒÂ¼ften Engines mit unterschiedlichen Parametern. App Deploy setzt persistente Installationsflags fÃƒÂ¼r gebÃƒÂ¼ndelte Apps.

Sheets verwendet sechs Spalten und zwÃƒÂ¶lf Zeilen sowie Festkommaarithmetik mit drei Nachkommastellen. Write speichert einfachen Text. Slides trennt Folien mit Form Feed. BMP und unkomprimiertes 24-Bit-AVI werden direkt dekodiert. Kein Audio.

PE32-Dateien werden bei 0x04000000 geladen, maximal 2 MiB Image. Der Loader prÃƒÂ¼ft Header, Sektionen, Einstieg und Imports und unterstÃƒÂ¼tzt HIGHLOW-Relocations. UnterstÃƒÂ¼tzte Imports: GetStdHandle, WriteFile, ExitProcess, GetTickCount und MessageBoxA (Textausgabe). Keine allgemeine Win32-KompatibilitÃƒÂ¤t und keine Isolation gegen fehlerhaften oder bÃƒÂ¶sartigen Code. Die mitgelieferte HelloPingu.exe lÃƒÂ¤uft sowohl unter Windows als auch ÃƒÂ¼ber diesen Loader.

## Quellstruktur

- src/kernel.c: Komponenten und Hauptloop
- src/include: Hardware, Speicher, Grafik, Parser, Shell und Eingabe
- src/apps: App-ZustÃƒÂ¤nde, Darstellung und Aktionen
- scripts/assets.py, catalog.py, media.py: reproduzierbare Ressourcen
- scripts/test_engines.py: direkte Tests der C-Rechen-/Text-/Hash-Engines
- scripts/test_os_v2.py: echte Emulatorbedienung und RAM-/DatentrÃƒÂ¤gerprÃƒÂ¼fung
- scripts/test_apps.py: alle Apps ÃƒÂ¼ber Startsuche ÃƒÂ¶ffnen und schlieÃƒÅ¸en
- scripts/files.py: Offline-Dateiaustausch

## Spezifikationen

[QEMU Standard VGA](https://www.qemu.org/docs/master/specs/standard-vga.html), [Microsoft PE-Format](https://learn.microsoft.com/en-us/windows/win32/debug/pe-format), [TCP RFC 9293](https://www.rfc-editor.org/rfc/rfc9293), [HTTP/1.1 RFC 9112](https://www.rfc-editor.org/rfc/rfc9112). Die Implementierung unterstÃƒÂ¼tzt jeweils nur die oben beschriebenen Teilmengen.


## Desktop 0.4: kompatible Erweiterungen

Die festen File-/Volume-Strukturen und PinguFS-Version 2 bleiben bestehen. Das Datenfeld des Wurzelordners (Datei 0) enthÃ¤lt ab Offset 0 die Signatur `0x344b5344`, ab Offset 16 je zwei 16-Bit-Werte pro Dateislot (x+1, y+1; null bedeutet automatisch angeordnet). Einmalige Initialisierung aktiviert Full HD; danach bleibt die NutzerauflÃ¶sung bestehen. Dateianlage setzt die Position des wiederverwendeten Slots zurÃ¼ck.

VerknÃ¼pfungen verwenden Typ 5, ein Byte Zielindex und GrÃ¶ÃŸe 1. Der Loader prÃ¼ft Ziel, Existenz und Typ und folgt keinen weiteren VerknÃ¼pfungen. LÃ¶schen des Ziels setzt die Linkziele auf null, damit neue Dateien im gleichen Slot nicht versehentlich geÃ¶ffnet werden. Kopierte Medien verweisen auf die bestehenden unverÃ¤nderlichen MedienblÃ¶cke; spÃ¤tere MedienÃ¤nderungen verwenden neue BlÃ¶cke.

Desktopbewegungen werden beim Loslassen gespeichert. Der Editor hÃ¤lt pro Fenster einen Textstand fÃ¼r RÃ¼ckgÃ¤ngig/Wiederholen und eine Auswahlmarke im RAM. Diese Erweiterung bietet keine Prozessisolation oder VerschlÃ¼sselung. Audio bleibt ausdrÃ¼cklich ohne GerÃ¤t/Treiber; der Netzwerkschalter beeinflusst den tatsÃ¤chlichen Netzwerkstack und wird gespeichert.


## Grid 0.5

Desktopkoordinaten verwenden weiterhin die kompatiblen Metadaten im Wurzelordner. Das Raster beginnt bei (20,25), mit 116 Pixel Spalten- und 100 Pixel Zeilenabstand. Gespeicherte Einträge werden zuerst platziert, neue danach. Gruppenbewegungen suchen eine gültige gemeinsame Rasterverschiebung mit minimalem Abstand zum gewünschten Ablagepunkt. Passt keine Verschiebung, bleibt die Gruppe an der ursprünglichen Position.

Der Icon-Renderer nutzt 32 Cacheeinträge für konkrete Symbolgrößen bis 80 Pixel. Bilineare Filterung gewichtet Farbkanäle mit Alpha, um dunkle Ränder an transparenten Pixeln zu vermeiden. Geglättete Bedienelemente verwenden 4×4-Abtastung nur in ihren Ecken. Die bisherigen rechteckigen Schadensbereiche und Fenster-Caches bleiben erhalten.

Die Startsuche unterscheidet Apps (0–99), Einstellungsbereiche (100–108) und Dateien (200+Index). Der Benachrichtigungspuffer enthält maximal zwölf tatsächliche Meldungen im RAM. Die Fokusfrist verwendet den Kernel-Tickzähler. Keine Verbindung zu Windows-Benachrichtigungen oder Microsoft-Konten.
