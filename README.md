## Building from Source

If you prefer to compile the `.exe` yourself instead of running the pre-built binary:

### Prerequisites
- Install **[AutoHotkey](https://www.autohotkey.com/)** (includes the `Ahk2Exe` compiler).

### Compilation Steps

1. Open the Start menu, search for **"Convert .ahk to .exe"** (or run `Ahk2Exe.exe` located in `C:\Program Files\AutoHotkey\Compiler\`).
2. Set the build parameters:
   - **Source (`.ahk` file):** Select `WitcherWalkToggle.ahk`.
   - **Destination (`.exe` file):** Choose your output path (e.g. `WitcherWalkToggle.exe`).
   - **Base File (`.bin / .exe`):** Select your installed AutoHotkey interpreter to a version of that is at least 2.0.
   - *(Optional)* **Custom Icon (`.ico`):** Select an icon file if you want a custom launcher/tray appearance.
3. Click **Convert**.

The compiled standalone executable will be generated in seconds and can run on any Windows PC without requiring AutoHotkey to be installed.
