# Aktuell: Ciwi OS

**Win32-Ausbau 27:** groessere Heaps, VirtualAlloc/VirtualFree, Stackreserven bis
2 MiB, Verzeichnis-/Datei-APIs sowie echte Bitmaps, Icons und ImageLists.
Die Original-EXE von 7-Zip kommt jetzt an ImageList_ReplaceIcon vorbei, stoppt
aber weiterhin bei InitCommonControlsEx. **7-Zip ist noch nicht lauffaehig.**
[Implementierter Umfang, Tests und offene Arbeit](docs/WIN32-APIS27.md).

Neu: **Win32-Fenstergrundlage** mit echten PE32-Fenstern, Nachrichtenverarbeitung
und einem kleinen GDI-Textpfad. `Programme/Win32Window.exe` ist eine installierte
Testanwendung, keine 7-Zip-Ersatzoberflaeche. Die originale 7-Zip-UI ist weiterhin
nicht lauffaehig. [Umfang, Nachweise und Grenzen](docs/WIN32-GUI.md).

Core 25 behaelt auf ausdruecklichen Wunsch den eigenen Kernel bei. Neu sind
**1 GiB Gast-RAM**, logische numerische Tabellenformeln und begrenzte,
zwischengespeicherte Zellauswertung. Die Darstellung bleibt unveraendert.
HTTP wurde gegen einen lokalen Server und example.com getestet; HTTPS, Zen und
allgemeine Windows-Kompatibilitaet sind **nicht** implementiert.

[Core 25: Ergebnisse, Formeln und offene Grundlagen](docs/CORE25.md).

Ciwi 24 verwendet die bereitgestellten 3D-Fluency-Icons, das originale Vogel-Logo,
den mitgelieferten Hintergrund und ausschliesslich die mitgelieferte
Segoe-UI-This-Schrift. Der Login folgt der Referenz mit freistehender Begruessung,
rundem Benutzerbild und Passwortfeld mit Pfeiltaste statt einer grossen Karte.

Das vorhandene Benutzerprofil ist wieder auf **Hell bei 120%** eingestellt.
Die gewuenschten grossen Fensterabmessungen sind wiederhergestellt; die bisherigen
Animationen, Windows-Fensterknoepfe rechts und der Dunkelmodus bleiben erhalten.

Start: **Ciwi OS starten.cmd**. Der bisherige Starter funktioniert weiterhin.
Benutzerdateien und das interne PinguFS-Format werden nicht umbenannt.

[Aenderungen, Abmessungen und Pruefung](docs/CIWI24.md).

# Frueherer Stand: Desktop 20

Native Schrift- und Symbolausgabe statt Vergroesserung des gesamten Bildes.
Monitorerkennung beim Start, 120% als gewuenschte Voreinstellung im vorhandenen
Benutzerprofil; Auto / 100 / 120 / 150% in den Einstellungen. Auf kleinen
Bildschirmen wird die Skalierung fuer bedienbare Fenster auf 100% begrenzt.

Neue SVG-Pfeile, runde Fensterknoepfe links, ruhigeres Startmenue und
Werkzeugleisten, Explorer-Verlauf, aufgeraeumter Editor und Task-Manager.
Start: **Pingu OS starten.cmd**. Der Emulator verwendet jetzt 160 MiB RAM.

[Umsetzung, Messungen und Grenzen](docs/DESKTOP20.md).
Die folgenden Abschnitte beschreiben aeltere Entwicklungsstaende.

# Frueherer Stand: Motion 19

Laptop-Profil: 2560 x 1600 mit 150% Oberflaechengroesse. Kurzes Oeffnen im
Windows-Stil, Trichter zur Taskleiste beim Minimieren und Schliessen,
umgekehrter Trichter beim Wiederherstellen. [Details und Grenzen](docs/MOTION19.md).

Die originale 7-Zip-GUI, Zen und Steam bleiben im eigenen Kernel nicht lauffaehig.
Die folgenden Abschnitte beschreiben auch aeltere Entwicklungsstaende.

# Pingu OS 0.9 PEX

Ein bootfÃƒÂ¤higes Experiment mit eigenem 32-Bit-x86-Kernel in C und Assembler. Die OberflÃƒÂ¤che orientiert sich an einem einfachen Windows-Desktop. Pingu ist noch kein Ersatz fÃƒÂ¼r Windows.

## Display 15

1920 x 1080 passend zum aktuellen Monitor, groessere Schrift und flaechengemittelte
Icon-Verkleinerung. Original-7-Zip-GUI weiterhin nicht lauffaehig.
[Darstellungsfehler und echte Screenshots](docs/DISPLAY15.md).

## Runtime 14

Echte Win32-Dateioperationen im eigenen Kernel, korrigierte Desktop-Metadaten,
gemeinsame Geometrie der Einstellungskarten und verbesserte Textkontraste.
Die Originaldateien von 7-Zip sind installiert; seine Windows-Oberflaeche sowie
Steam, Zen, DirectX/Vulkan und native WLAN-Treiber sind noch nicht lauffaehig.
[Implementierung, Tests und notwendige Grundlagen](docs/RUNTIME14.md).

## Desktop 13

Native 2560 x 1600-Anzeige auf diesem Laptop, Datei-/Ordner-Drag-and-drop, Auswahlmenues und ueberarbeitetes Terminal. [Aenderungen, Tests und offene Grenzen](docs/DESKTOP13.md).

## Native 7-Zip-Dateiinstallation

Der Originalinstaller kann seine 106 Dateien jetzt nativ nach Programme/7-Zip installieren. Die Windows-Programme selbst sind noch nicht lauffaehig. [Bedienung, Grenzen und Tests](docs/INSTALLER12.md).

## Neu in PEX 0.9

- `.pex`-Pakete mit unveraenderten PE32-Dateien; direkt aus Datei-/Startsuche starten oder mit `pack Datei.exe` in Pingu CMD erzeugen. Quelldatei bleibt erhalten, bestehende Pakete werden nicht ueberschrieben.
- Pingu Win Runtime 0.1: nativer synchroner MessageBoxA-Dialog, kleiner Prozessheap (GetProcessHeap/HeapAlloc/HeapFree), Fehlercodes und korrekter Entry-Rueckgabewert. Demo unter Programme/HelloWindows.pex.
- Neuer rechter Taskleistenbereich mit separaten Netzwerk-, Audio-, Akku- und Uhr-Hinweisen. Einfarbige SVG-Symbole weiss auf dunklem und schwarz auf hellem Hintergrund; mehr Abstand und gemeinsame Schnellsteuerung.
- Netzwerkstatus zeigt Ethernet/RTL8139. WLAN, Audio und Akku-Telemetrie werden nicht vorgetaeuscht; fehlende Unterstuetzung wird benannt.

Details, Paketformat und bewusst begrenzter API-Umfang: [PEX-FORMAT](docs/PEX-FORMAT.md). Kein Wine-Port und keine allgemeine Windows-Kompatibilitaet.

## Neu in Visual 0.8

- Kontextcursor aus dem bereitgestellten Cursor-Ordner: Pfeil, Text, Hand, Verschieben, vier Richtungen fuer Groessenaenderung, Zeichenstift, Auswahlkreuz und animierter Arbeitszeiger. Native Alpha-Kanaele und Hotspots bleiben erhalten; drei Zeigergroessen.
- Fenster an allen vier Kanten und Ecken vergroessern/verkleinern. Der Cursor erreicht nun jeden Bildschirmrand.
- Taskleiste mit geglaetteten Flaechen, aktivem App-Indikator, Netzwerk-/Audio-Symbolen und Fenstervorschau beim Darueberfahren. Die Symbole oeffnen die bestehende Schnellsteuerung; sie fuegen keine Hardwaretreiber hinzu.
- Einstellungen mit eigener SVG-Navigation, Kartenuebersicht, klareren Ueberschriften und Cursorvorschau. Sechs neue originale SVG-Symbole.
- Weiche Ueberblendung beim Wechsel der Einstellungsseite und beim Weiterblaettern von Fotos, zusaetzlich zu den bisherigen Fenster- und Menueanimationen.
- Bilder und Video werden pixelzentriert bilinear skaliert, mit korrekter Drehung und Begrenzung auf den sichtbaren Bereich. Zu kurze AVI-Frame-Chunks werden abgelehnt.
- Alphageglaettete Fensterecken werden beim Ziehen gegen den aktuellen Hintergrund neu berechnet; komprimierte Icon-Daten werden verlustfrei dekodiert und weiterhin groessenspezifisch zwischengespeichert.

Unterstuetzte Medien bleiben 24-Bit-BMP und unkomprimiertes RGB-AVI, maximal 4 MiB je geladenem Medium, ohne Audio. JPEG, PNG als Benutzerdatei, MP4 und moderne Videocodecs sind damit noch nicht implementiert. PNG/SVG-Oberflaechengrafiken werden beim Bauen in Kernel-Assets umgewandelt.

## Neu in Motion 0.7

- 26 passende PNG-Symbole aus dem vom Nutzer bereitgestellten Desktop-Ordner: Apps, Dateien, Ordner, Seitenleiste, Suche, Konto, KontextmenÃ¼s, Energie, Speicher und Benachrichtigungen. Zuordnung und Originale: assets/user-icons.
- FlÃ¼ssig verformtes Einziehen zum jeweiligen Taskleistensymbol beim Minimieren und umgekehrte Bewegung beim Wiederherstellen. SchlieÃŸen zieht das Fenster mit zusÃ¤tzlichem Ausblenden ein.
- Kurze Zoom-/Ãœberblendungen beim Ã–ffnen, Maximieren und Andocken; StartmenÃ¼, Ein-/Aus-MenÃ¼, KontextmenÃ¼s, Schnellsteuerung, Benachrichtigungen, Dialoge und FensterÃ¼bersicht erhalten ÃœbergÃ¤nge.
- Animationen laufen im normalen Ereigniszyklus; neue Klicks/Tasten dÃ¼rfen sie abbrechen. Sperren beendet die Darstellung unmittelbar. Nach jedem Ãœbergang wird die echte OberflÃ¤che wieder nativ gezeichnet.
- Einstellungen â†’ Darstellung â†’ Animationen: FlieÃŸend / Reduziert. Die Auswahl wird im Benutzerimage gespeichert. Standarddauern: 180 ms fÃ¼r Panels/Ã–ffnen, 240 ms SchlieÃŸen, 320 ms Minimieren/Wiederherstellen.

Animationen sind eigene Softwareeffekte nach dem gewÃ¼nschten Stil, kein macOS-Code. Die tatsÃ¤chliche Bildrate hÃ¤ngt vom QEMU-Beschleuniger und Host ab; Zwischenbilder werden bei groÃŸen Fenstern aus einem maximal 1280Ã—720 groÃŸen Abbild berechnet. Der fertige Desktop bleibt nativ 1920Ã—1080 beziehungsweise in der gewÃ¤hlten AuflÃ¶sung. Seit 0.8 kommen die Zeiger aus dem bereitgestellten Cursor-Ordner; Pingu-Maskottchen und Terminal bleiben eigene Grafiken.

## Neu in Aurora 0.6

- Native 1920Ãƒâ€”1080 ab dem grafischen Bootbildschirm. Bestehende Profile werden einmal auf Full HD aktualisiert; spÃƒÂ¤tere bewusste AuflÃƒÂ¶sungsÃƒÂ¤nderungen bleiben erhalten.
- Neuer heller/dunkler Aurora-Hintergrund mit kontinuierlichen LichtverlÃƒÂ¤ufen, ÃƒÂ¼berarbeitete Ordner-/Dokument-/Einstellungssymbole und dreifach supersampelte SVG-Rasterisierung.
- OpenBSD-Zeichenkettenfunktionen sind in den eigenen Kernel integriert. Herkunft, Anpassungen und vollstÃƒÂ¤ndige Lizenzen: [BSD-Komponenten](docs/BSD-KOMPONENTEN.md).
- Dateimanager: vollstÃƒÂ¤ndiger Ordnerpfad und Sortierknopf fÃƒÂ¼r ursprÃƒÂ¼ngliche Reihenfolge, Name AÃ¢â‚¬â€œZ, Name ZÃ¢â‚¬â€œA und GrÃƒÂ¶ÃƒÅ¸e; Ordner stehen bei aktiver Sortierung zuerst.
- Ganze OrdnerbÃƒÂ¤ume kopieren, inklusive Unterordnern und interner VerknÃƒÂ¼pfungen. VorabprÃƒÂ¼fung der freien EintrÃƒÂ¤ge, Ablehnung doppelter Namen und von Zielen im Quellordner; VerÃƒÂ¶ffentlichung als eine Dateisystemtransaktion.

Die Sortierung gilt pro geÃƒÂ¶ffnetem Dateifenster. Das Dateisystem bleibt auf 80 EintrÃƒÂ¤ge begrenzt. LÃƒÂ¶schen nichtleerer Ordner wird weiterhin abgelehnt. BSD-Bibliothekscode liefert noch keine Audio-/WLAN-/USB-Treiber und keine vollstÃƒÂ¤ndige Windows-KompatibilitÃƒÂ¤t.

## Neu in Grid 0.5

- Festes Desktopraster (116Ãƒâ€”100 Pixel): Loslassen wÃƒÂ¤hlt den nÃƒÂ¤chsten freien Platz. Belegte PlÃƒÂ¤tze und die beiden Systemstarter werden berÃƒÂ¼cksichtigt. Vorhandene Positionen werden beim Start auf das Raster ÃƒÂ¼bertragen.
- Auswahlrahmen durch Ziehen auf leerer DesktopflÃƒÂ¤che, Strg+Klick zum Ein-/AusschlieÃƒÅ¸en, Strg+A fÃƒÂ¼r alle Desktopdateien. Markierte Objekte gemeinsam verschieben; AbstÃƒÂ¤nde und Positionen bleiben gespeichert.
- Transparenzkorrekt gefilterte und zwischengespeicherte SVG-Symbole, geglÃƒÂ¤ttete SchaltflÃƒÂ¤chen und Panels, feinere HintergrundverlÃƒÂ¤ufe, grÃƒÂ¶ÃƒÅ¸ere Desktopdateisymbole.
- Startsuche ÃƒÂ¼ber installierte Apps, Dateinamen und Einstellungsbereiche. Ein Klick auf den Profilnamen ÃƒÂ¶ffnet das lokale Konto.
- Uhr und Datum mit Benachrichtigungsfenster: echte Systemmeldungen, Scrollen, Leeren, Ruhemodus und start-/stoppbarer Fokustimer.
- Ein-/Aus-MenÃƒÂ¼ mit Sperren, Neustart und Herunterfahren. Escape und erneuter Klick schlieÃƒÅ¸en die Taskleistenfenster.

Die Auswahlgruppe dient derzeit dem gemeinsamen Verschieben. Dateiaktionen wie LÃƒÂ¶schen und Kopieren arbeiten weiterhin mit der gezielt ausgewÃƒÂ¤hlten Datei. Die beiden Systemstarter bleiben fest. Benachrichtigungen und Fokuszustand gelten fÃƒÂ¼r die laufende Sitzung. WLAN/Bluetooth, Audio, Akku-/Wetterdaten und Microsoft-/Cloud-Konten sind weiterhin nicht implementiert; das Netzwerk ist die emulierte Ethernet-Verbindung.

## Neu in Desktop 0.4

- Eigener Startbildschirm und separater Login ohne Desktop, Dateien oder offene Fenster im Hintergrund.
- 1920Ãƒâ€”1080 als Standard beim ersten Start dieser Version; danach bleibt die gewÃƒÂ¤hlte AuflÃƒÂ¶sung erhalten.
- Desktopdateien und Ordner erstellen, mit der Maus verschieben und Positionen dauerhaft speichern.
- KontextmenÃƒÂ¼s auf Desktop und im Dateimanager: Erstellen, Ãƒâ€“ffnen, Umbenennen, LÃƒÂ¶schen, Kopieren, Ausschneiden, EinfÃƒÂ¼gen und Desktop-VerknÃƒÂ¼pfung.
- Ein Klick markiert; ein zeitlicher Doppelklick oder Enter ÃƒÂ¶ffnet. Verschieben beginnt nach fÃƒÂ¼nf Pixeln Bewegung.
- Der Texteditor unterstÃƒÂ¼tzt Mauspositionierung, Ziehauswahl, Umschalt+Pfeiltasten, Kopieren/Ausschneiden/EinfÃƒÂ¼gen, eine RÃƒÂ¼ckgÃƒÂ¤ngig/Wiederholen-Stufe und Speichern unter.
- Einstellungen mit ÃƒÅ“bersicht und neun Bereichen, darunter Speicherbelegung und Audio-GerÃƒÂ¤testatus.
- Taskleisten-Schnelleinstellungen mit gespeichertem Netzwerkschalter, Einstellungen, Sperren und Desktop anzeigen am rechten Rand.
- Die optimierte Flow-Grafik mit separatem Cursor und zwischengespeicherten Fensterinhalten bleibt erhalten.

Audio hat noch keinen Treiber; deshalb wird kein wirkungsloser LautstÃƒÂ¤rkeregler angeboten. Ordner mit Inhalt kÃƒÂ¶nnen verschoben, aber noch nicht rekursiv kopiert oder gelÃƒÂ¶scht werden. VerknÃƒÂ¼pfungen zeigen auf vorhandene Dateien/Ordner und werden bei LÃƒÂ¶schen des Ziels ungÃƒÂ¼ltig. Die KapazitÃƒÂ¤t bleibt bei 80 EintrÃƒÂ¤gen; Textdateien sind auf 8191 Byte begrenzt.

## Starten

**Pingu OS starten.cmd** doppelklicken. Das System ÃƒÂ¶ffnet sich in einem eigenen QEMU-Fenster mit 128 MiB RAM. Beim ersten Start Benutzername und Passwort (mindestens acht Zeichen) festlegen. Die Daten bleiben im 64-MiB-Image gespeichert. Strg+Alt gibt die Maus frei; Strg+Alt+F schaltet QEMU-Vollbild um. Nur eine VM pro Image starten und vor dem SchlieÃƒÅ¸en Dokumente speichern.

Der Starter versucht `whpx,kernel-irqchip=off` und fÃƒÂ¤llt bei einem Startfehler auf TCG zurÃƒÂ¼ck. FÃƒÂ¼r erzwungenen Softwarebetrieb: `.\start.ps1 -Software`. Es werden keine Windows-Funktionen installiert oder umgeschaltet.

## Enthalten

- Eigener BIOS-Bootloader, Kernel, Interrupts, PS/2-Tastatur und Maus, IDE-Speicher und RTL8139-Netzwerktreiber.
- AuflÃƒÂ¶sungen 1024Ãƒâ€”768, 1280Ãƒâ€”720, 1600Ãƒâ€”900, 1920Ãƒâ€”1080, 2560Ãƒâ€”1440 und 2560Ãƒâ€”1600; tatsÃƒÂ¤chlicher Framebufferwechsel.
- Desktop mit Ordnern, zentrierte Taskleiste, StartmenÃƒÂ¼ mit angehefteten Apps und Suche.
- Bis zu zwÃƒÂ¶lf verschiebbare, vergrÃƒÂ¶ÃƒÅ¸erbare, minimierbare Fenster; seitliches Andocken und ÃƒÅ“bersicht mit echten Vorschauen.
- Dateimanager mit Unterordnern, Anlegen, Umbenennen, LÃƒÂ¶schen und Speichern; RÃƒÂ¼ckfrage bei ungespeicherten Dokumenten.
- Einstellungen fÃƒÂ¼r AuflÃƒÂ¶sung, Darstellung, Akzentfarbe, Desktop-Icons, Uhr, CursorgrÃƒÂ¶ÃƒÅ¸e/-tempo, Profilpasswort und Netzwerkaktivierung.
- App Deploy mit 100 enthaltenen eigenen kleinen Apps. Installation aktiviert die mitgelieferte App; kein Internetdownload. Viele Werkzeuge teilen sich Engines. Siehe [App-Katalog](docs/APP-KATALOG.md).
- Pingu Write fÃƒÂ¼r Text, Pingu Sheets mit ZellbezÃƒÂ¼gen und SUM-Formeln, Pingu Slides fÃƒÂ¼r mehrseitige PrÃƒÂ¤sentationen. Eigene einfache Formate, keine DOCX/XLSX/PPTX-KompatibilitÃƒÂ¤t.
- Fotoanzeige fÃƒÂ¼r BMP mit Drehen und Zoom; Videoplayer fÃƒÂ¼r unkomprimiertes 24-Bit-AVI ohne Audio. Mitgelieferte Bilder und Animation sind eigene SVG-Rasterisierungen.
- Experimenteller HTTP-Textbrowser ÃƒÂ¼ber den eigenen TCP/IP-Stack. Kein HTTPS, JavaScript oder moderner Webbrowser.
- Task-Manager fÃƒÂ¼r App-Fenster und CMD mit Datei-, Rechen- und Systembefehlen.
- PE32-Loader, der die mitgelieferte HelloPingu.exe tatsÃƒÂ¤chlich ausfÃƒÂ¼hrt. Nur wenige Win32-API-Funktionen; ÃƒÂ¼bliche Windows-Programme laufen damit nicht.

## Bedienung

| Aktion | TastenkÃƒÂ¼rzel |
|---|---|
| Rechtsklick auf dem Desktop | KontextmenÃƒÂ¼ / neuer Ordner |
| Fenstertitel doppelklicken | Maximieren / wiederherstellen |
| Fenster an Bildschirmrand ziehen | Links/rechts andocken, oben maximieren |
| Mausrad | Listen scrollen; in Foto zoomen |
| Start und App-Suche | Windows-Taste, Name tippen, Enter |
| FensterÃƒÂ¼bersicht | Win+Tab |
| Links/rechts andocken | Win+Pfeil links/rechts |
| Maximieren/wiederherstellen | Win+Pfeil oben |
| Zwischen Fenstern wechseln | Alt+Tab |
| Fenster schlieÃƒÅ¸en | Alt+F4 |
| Desktop anzeigen | Win+D |
| Sperren | Win+L |
| Dateien / Task-Manager / Einstellungen | F1 / Strg+Umschalt+Esc / F3 |
| Speichern | Strg+S |
| Interne Textzwischenablage | Strg+A/C/X/V |
| Neuer Ordner im Dateimanager | Strg+Umschalt+N |
| Browser-Adresse | Strg+L |

Tastatur: einfaches QWERTZ-ASCII-Layout. Umlaute, Unicode, komplette deutsche Sonderzeichen und Host-Zwischenablage fehlen noch.

## Eigene Dateien austauschen

Zuerst ein Profil erstellen, danach **QEMU vollstÃƒÂ¤ndig schlieÃƒÅ¸en**. Das Offline-Werkzeug kopiert Dateien in das eigene PinguFS. Bilder werden in BMP umgewandelt und auf hÃƒÂ¶chstens 1280Ãƒâ€”720 verkleinert.

```powershell
python scripts/files.py list
python scripts/files.py import "C:/Pfad/Foto.jpg" --folder Bilder
python scripts/files.py import "C:/Pfad/Notiz.txt" --folder Dokumente
python scripts/files.py export Notiz.txt "C:/Pfad/Export.txt"
```

Vor Ãƒâ€žnderungen eine Kopie von `build/pingu-os.img` anlegen. Das Werkzeug ÃƒÂ¼berschreibt keine vorhandenen Dateinamen. AVI muss bereits unkomprimiertes 24-Bit-Video enthalten. Nur vertrauenswÃƒÂ¼rdige Test-EXEs importieren: Apps und EXEs laufen im Kerneladressraum.

## Grenzen

Experimentelle Entwicklerausgabe fÃƒÂ¼r QEMU Standard-VGA/BIOS/IDE/RTL8139, nicht fÃƒÂ¼r produktive Arbeit oder echte Hardware freigegeben. Keine Prozess- oder Speicherisolation, kein vollstÃƒÂ¤ndiger Scheduler, keine Treiber fÃƒÂ¼r USB/NVMe, kein UEFI. Das Profilpasswort wird gesalzen mit PBKDF2-HMAC-SHA256 gespeichert, ist aber lediglich eine lokale Anmeldesperre: keine LaufwerksverschlÃƒÂ¼sselung und keine Sicherheitsgrenze.

PinguFS: 80 EintrÃƒÂ¤ge einschlieÃƒÅ¸lich Ordner, 47 ASCII-Zeichen je Name, 8191 Byte je Textdatei, hÃƒÂ¶chstens 4 MiB je Mediendatei. Zwei wechselnde SpeicherstÃƒÂ¤nde mit PrÃƒÂ¼fsummen; kein Ersatz fÃƒÂ¼r Backups. GelÃƒÂ¶schte MedienblÃƒÂ¶cke werden noch nicht wiederverwendet. Die Fensterprogramme teilen sich den Kerneladressraum und laufen kooperativ.

## Bauen und testen

```powershell
.\setup.ps1
.\build.ps1
python scripts/test_engines.py
python scripts/test_os_v2.py
python scripts/test_flow.py
python scripts/test_apps.py
python scripts/test_recovery.py
python scripts/test_desktop.py
.\start.ps1
```

Windows x64 mit Python, NASM, Zig und QEMU. Setup installiert Werkzeuge lokal. Build erzeugt SVGÃ¢â€ â€™PNGÃ¢â€ â€™ARGB-Assets, Schriftmasken, App-Katalog und Demo-Medien und aktualisiert das Image unter Erhalt der Benutzerdaten. VM vor einem Build schlieÃƒÅ¸en. Kein ISO und keine normale Partitionstabelle.

Echte Emulatoraufnahmen liegen in `screenshots/v2-*.png`. Details und ÃƒÂ¼berprÃƒÂ¼fte Grenzen stehen in [TESTBERICHT.md](TESTBERICHT.md) und [ARCHITEKTUR.md](ARCHITEKTUR.md).


Aktuelle Nachbesserungen: [Full HD und 7-Zip-Test](docs/CLEAN-DISPLAY-UPDATE.md), [Einstellungsnavigation und Suche](docs/NAVIGATION-UPDATE.md).
