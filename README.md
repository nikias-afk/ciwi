# Current: Ciwi OS

**Win32 Expansion 27:** Larger heaps, VirtualAlloc/VirtualFree, stack reservations of up to 2 MiB, directory/file APIs, and real bitmaps, icons, and ImageLists.

The original 7-Zip executable now gets past ImageList_ReplaceIcon but still stops at InitCommonControlsEx. **7-Zip is not yet runnable.**

[Implemented functionality, tests, and remaining work](docs/WIN32-APIS27.md).

New: **Win32 window foundation** with real PE32 windows, message processing, and a small GDI text-rendering path. `Programme/Win32Window.exe` is an installed test application, not a replacement interface for 7-Zip. The original 7-Zip UI still does not run.

[Scope, evidence, and limitations](docs/WIN32-GUI.md).

Core 25 retains its own kernel, as explicitly requested. New features include **1 GiB of guest RAM**, logical numeric table formulas, and limited, cached cell evaluation. The appearance remains unchanged.

HTTP has been tested against a local server and example.com; HTTPS, Zen, and general Windows compatibility are **not implemented**.

[Core 25: Results, formulas, and missing foundations](docs/CORE25.md).

Ciwi 24 uses the provided 3D Fluency icons, the original bird logo, the supplied background, and exclusively the supplied Segoe UI This font. The login follows the reference design, with a freestanding greeting, circular user picture, and password field with an arrow button instead of a large card.

The existing user profile has been restored to **Light mode at 120% scaling**. The requested large window dimensions have been restored; the existing animations, Windows-style window controls on the right, and dark mode remain available.

Launch: **Start Ciwi OS.cmd**. The previous launcher continues to work. User files and the internal PinguFS format have not been renamed.

[Changes, dimensions, and verification](docs/CIWI24.md).

# Previous Version: Desktop 20

Native font and icon rendering instead of enlarging the entire image. Monitor detection at startup, 120% as the desired default in the existing user profile, and Auto / 100 / 120 / 150% in Settings. On small screens, scaling is limited to 100% to keep windows usable.

New SVG arrows, rounded window controls on the left, a calmer Start menu and toolbars, Explorer history, a cleaner editor, and Task Manager.

Launch: **Start Pingu OS.cmd**. The emulator now uses 160 MiB of RAM.

[Implementation, measurements, and limitations](docs/DESKTOP20.md).

The following sections describe earlier development versions.

# Previous Version: Motion 19

Laptop profile: 2560 × 1600 with 150% UI scaling. Brief opening animation in the Windows style, a funnel animation toward the taskbar when minimizing and closing, and the reverse funnel when restoring.

[Details and limitations](docs/MOTION19.md).

The original 7-Zip GUI, Zen, and Steam remain unable to run in the custom kernel. The following sections also describe earlier development versions.

# Pingu OS 0.9 PEX

A bootable experiment featuring its own 32-bit x86 kernel written in C and assembly. The interface is inspired by a simple Windows desktop. Pingu is not yet a replacement for Windows.

## Display 15

1920 × 1080 resolution matched to the current monitor, larger text, and icon reduction using area averaging. The original 7-Zip GUI still does not run.

[Rendering issues and actual screenshots](docs/DISPLAY15.md).

## Runtime 14

Native Win32 file operations in the custom kernel, corrected desktop metadata, consistent geometry for Settings cards, and improved text contrast.

The original 7-Zip files are installed, but its Windows interface, Steam, Zen, DirectX/Vulkan, and native Wi-Fi drivers are still not runnable or implemented.

[Implementation, tests, and required foundations](docs/RUNTIME14.md).

## Desktop 13

Native 2560 × 1600 display on this laptop, file/folder drag and drop, selection menus, and an improved terminal.

[Changes, tests, and remaining limitations](docs/DESKTOP13.md).

## Native 7-Zip File Installation

The original installer can now natively install its 106 files into `Programme/7-Zip`. The Windows applications themselves are still not runnable.

[Usage, limitations, and tests](docs/INSTALLER12.md).

## New in PEX 0.9

* `.pex` packages containing unmodified PE32 files. Launch them directly from a file or Start search, or create them using `pack File.exe` in Pingu CMD. The source file remains unchanged, and existing packages are never overwritten.
* Pingu Win Runtime 0.1: native synchronous MessageBoxA dialog, small process heap (GetProcessHeap/HeapAlloc/HeapFree), error codes, and correct entry-point return value. Demo available under `Programme/HelloWindows.pex`.
* New right-hand taskbar area with separate network, audio, battery, and clock indicators. Monochrome SVG icons appear white on dark backgrounds and black on light backgrounds. Increased spacing and a shared Quick Settings panel.
* Network status displays Ethernet/RTL8139. Wi-Fi, audio, and battery telemetry are not simulated; missing support is explicitly indicated.

Details, package format, and deliberately limited API coverage: [PEX-FORMAT](docs/PEX-FORMAT.md).

This is not a Wine port and does not provide general Windows compatibility.

## New in Visual 0.8

* Context-sensitive cursors from the supplied cursor folder: arrow, text, hand, move, four-direction resize, pen, crosshair, and animated busy cursor. Native alpha channels and hotspots are preserved. Three pointer sizes are available.
* Resize windows along all four edges and corners. The cursor can now reach every screen edge.
* Taskbar with antialiased surfaces, active-app indicator, network/audio icons, and window previews on hover. The icons open the existing Quick Settings panel; they do not add hardware drivers.
* Settings with dedicated SVG navigation, an overview of cards, clearer headings, and cursor previews. Six new original SVG icons.
* Smooth fades when switching Settings pages and advancing through photos, in addition to existing window and menu animations.
* Images and video are scaled using pixel-centered bilinear interpolation, with correct rotation and clipping to the visible area. AVI frame chunks that are too short are rejected.
* Antialiased window corners are recalculated against the current background while dragging. Compressed icon data is decoded losslessly and continues to be cached separately for each size.

Supported media remain 24-bit BMP and uncompressed RGB AVI, with a maximum of 4 MiB per loaded media file and no audio. JPEG, PNG as a user file, MP4, and modern video codecs are not yet implemented. PNG/SVG interface graphics are converted into kernel assets during the build.

## New in Motion 0.7

* 26 matching PNG icons from the user-provided desktop folder: apps, files, folders, sidebar, search, account, context menus, power, storage, and notifications. Mappings and originals: `assets/user-icons`.
* Smoothly deforming animation toward the corresponding taskbar icon when minimizing, with the reverse animation when restoring. Closing pulls the window inward while also fading it out.
* Short zoom/fade transitions when opening, maximizing, and snapping windows. The Start menu, power menu, context menus, Quick Settings, notifications, dialogs, and window overview also receive transitions.
* Animations run within the normal event loop; new clicks and keystrokes can interrupt them. Locking immediately stops the animation. After each transition, the actual interface is redrawn natively.
* Settings → Appearance → Animations: Smooth / Reduced. The selection is saved in the user image. Default durations: 180 ms for panels/opening, 240 ms for closing, and 320 ms for minimizing/restoring.

These animations are custom software effects inspired by the desired style, not macOS code. The actual frame rate depends on the QEMU accelerator and host. Intermediate frames for large windows are calculated from an image capped at 1280 × 720. The finished desktop remains native at 1920 × 1080 or the selected resolution.

Since version 0.8, pointers come from the supplied cursor folder. The Pingu mascot and terminal remain custom graphics.

## New in Aurora 0.6

* Native 1920 × 1080 resolution starting from the graphical boot screen. Existing profiles are upgraded to Full HD once; subsequent intentional resolution changes are preserved.
* New light/dark Aurora background with continuous lighting gradients, redesigned folder/document/settings icons, and SVG rasterization with 3× supersampling.
* OpenBSD string functions integrated into the custom kernel. Origins, modifications, and complete licenses: [BSD Components](docs/BSD-KOMPONENTEN.md).
* File manager: full folder path and sorting control for original order, name A–Z, name Z–A, and size. Folders appear first when sorting is enabled.
* Copy entire directory trees, including subfolders and internal links. Preflight checks for available entries, rejection of duplicate names and destinations inside the source folder, and publication as a single filesystem transaction.

Sorting applies separately to each open file window. The filesystem remains limited to 80 entries. Deleting non-empty folders is still rejected. BSD library code does not provide audio/Wi-Fi/USB drivers or full Windows compatibility.

## New in Grid 0.5

* Fixed desktop grid (116 × 100 pixels): releasing an item selects the next available position. Occupied positions and the two system launchers are taken into account. Existing positions are mapped to the grid at startup.
* Drag to create a selection rectangle on empty desktop space, Ctrl+click to include/exclude items, and Ctrl+A to select all desktop files. Move selected objects together; spacing and positions remain saved.
* Transparently filtered and cached SVG icons, antialiased buttons and panels, smoother background gradients, and larger desktop file icons.
* Start search across installed apps, filenames, and Settings sections. Clicking the profile name opens the local account.
* Clock and date with a notification panel: real system notifications, scrolling, clearing, Do Not Disturb mode, and a start/stop focus timer.
* Power menu with Lock, Restart, and Shut Down. Escape and clicking again close taskbar panels.

The selection group currently supports moving items together. File operations such as Delete and Copy still work with the individually selected file. The two system launchers remain fixed. Notifications and focus state apply only to the current session.

Wi-Fi/Bluetooth, audio, battery/weather data, and Microsoft/cloud accounts are still not implemented; networking uses the emulated Ethernet connection.

## New in Desktop 0.4

* Dedicated startup screen and separate login screen, without the desktop, files, or open windows visible in the background.
* 1920 × 1080 as the default resolution on the first start of this version; the selected resolution is preserved afterward.
* Create desktop files and folders, move them with the mouse, and save their positions persistently.
* Context menus on the desktop and in the file manager: Create, Open, Rename, Delete, Copy, Cut, Paste, and Create Desktop Shortcut.
* A single click selects an item; a timed double-click or Enter opens it. Moving starts after five pixels of movement.
* The text editor supports mouse positioning, drag selection, Shift+arrow keys, Copy/Cut/Paste, one level of undo/redo, and Save As.
* Settings with an overview and nine sections, including storage usage and audio device status.
* Taskbar Quick Settings with a saved network toggle, Settings, Lock, and Show Desktop on the right.
* The optimized Flow graphics engine with a separate cursor and cached window contents is retained.

Audio has no driver yet, so no nonfunctional volume control is offered. Folders containing items can be moved but cannot yet be copied or deleted recursively. Shortcuts point to existing files/folders and become invalid if their targets are deleted. Capacity remains limited to 80 entries; text files are limited to 8191 bytes.

## Getting Started

Double-click **Start Pingu OS.cmd**. The system opens in its own QEMU window with 128 MiB of RAM. On first startup, create a username and password (at least eight characters). Data remains stored in the 64 MiB image.

Press Ctrl+Alt to release the mouse; Ctrl+Alt+F toggles QEMU full-screen mode. Start the software-rendering mode explicitly with `.\start.ps1 -Software`.

The launcher attempts `whpx,kernel-irqchip=off` and falls back to TCG if startup fails. No Windows features are installed or switched on or off.

## Included Features

* Custom BIOS bootloader, kernel, interrupts, PS/2 keyboard and mouse, IDE storage, and RTL8139 network driver.
* Resolutions of 1024 × 768, 1280 × 720, 1600 × 900, 1920 × 1080, 2560 × 1440, and 2560 × 1600, with actual framebuffer switching.
* Desktop with folders, centered taskbar, Start menu with pinned apps, and search.
* Up to twelve movable, resizable, minimizable windows; side snapping and an overview with real previews.
* File manager with subfolders, creation, renaming, deletion, and saving; confirmation prompts for unsaved documents.
* Settings for resolution, appearance, accent color, desktop icons, clock, cursor size/speed, profile password, and network activation.
* App Deploy with 100 included custom lightweight apps. Installation activates the bundled app; no internet download is required. Many tools share engines. See the [App Catalog](docs/APP-KATALOG.md).
* Pingu Write for text documents, Pingu Sheets with cell references and SUM formulas, and Pingu Slides for multi-page presentations. Uses custom simple formats without DOCX/XLSX/PPTX compatibility.
* BMP photo viewer with rotation and zoom; video player for uncompressed 24-bit AVI without audio. Included images and animations are generated using custom SVG rasterization.
* Experimental HTTP text browser using the custom TCP/IP stack. No HTTPS, JavaScript, or modern web browser.
* Task Manager for app windows and CMD with file, calculation, and system commands.
* PE32 loader that actually executes the bundled `HelloPingu.exe`. Only a few Win32 API functions are supported; typical Windows applications do not run.

## Controls

| Action                          | Keyboard shortcut                |
| ------------------------------- | -------------------------------- |
| Right-click on desktop          | Context menu / new folder        |
| Double-click window title bar   | Maximize / restore               |
| Drag window to screen edge      | Snap left/right, maximize at top |
| Mouse wheel                     | Scroll lists; zoom photos        |
| Start and app search            | Windows key, type name, Enter    |
| Window overview                 | Win+Tab                          |
| Snap left/right                 | Win+Left/Right Arrow             |
| Maximize/restore                | Win+Up Arrow                     |
| Switch between windows          | Alt+Tab                          |
| Close window                    | Alt+F4                           |
| Show desktop                    | Win+D                            |
| Lock                            | Win+L                            |
| Files / Task Manager / Settings | F1 / Ctrl+Shift+Esc / F3         |
| Save                            | Ctrl+S                           |
| Internal text clipboard         | Ctrl+A/C/X/V                     |
| New folder in file manager      | Ctrl+Shift+N                     |
| Browser address bar             | Ctrl+L                           |

Keyboard: basic QWERTZ ASCII layout. Umlauts, Unicode, full German special characters, and the host clipboard are not yet supported.

## Transferring Your Own Files

First create a profile, then **fully shut down QEMU**. The offline utility copies files into your personal PinguFS filesystem. Images are converted to BMP and reduced to a maximum of 1280 × 720.

```powershell
python scripts/files.py list
python scripts/files.py import "C:/Path/Photo.jpg" --folder Bilder
python scripts/files.py import "C:/Path/Note.txt" --folder Dokumente
python scripts/files.py export Note.txt "C:/Path/Export.txt"
```

Create a copy of `build/pingu-os.img` before making changes. The utility does not overwrite existing filenames. AVI files must already contain uncompressed 24-bit video.

Only import trusted test executables: apps and EXEs run in kernel address space.

## Limitations

Experimental developer build for QEMU Standard VGA/BIOS/IDE/RTL8139. Not approved for production use or real hardware.

There is no process or memory isolation, no full scheduler, no USB/NVMe drivers, and no UEFI support. The profile password is stored using salted PBKDF2-HMAC-SHA256, but it is merely a local login restriction: there is no disk encryption, and it is not a security boundary.

PinguFS: 80 entries including folders, 47 ASCII characters per name, 8191 bytes per text file, and a maximum of 4 MiB per media file. Two alternating storage slots with checksums; not a replacement for backups. Deleted media blocks are not yet reused. Windowed applications share the kernel address space and run cooperatively.

## Building and Testing

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

Windows x64 with Python, NASM, Zig, and QEMU. Setup installs tools locally.

The build generates SVG → PNG → ARGB assets, font masks, the app catalog, and demo media, and updates the image while preserving user data. Shut down the VM before building. No ISO or conventional partition table is provided.

Actual emulator captures are located in `screenshots/v2-*.png`. Details and verified limitations are documented in [TESTBERICHT.md](TESTBERICHT.md) and [ARCHITEKTUR.md](ARCHITEKTUR.md).

Recent improvements: [Full HD and 7-Zip Test](docs/CLEAN-DISPLAY-UPDATE.md), [Settings Navigation and Search](docs/NAVIGATION-UPDATE.md).
