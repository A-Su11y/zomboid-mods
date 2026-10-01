# First-time updater install

You only do this once per machine. After this, patching is one double-click.

**Prereq**: a frozen Zomboid install already on your machine. Ask barti if
you don't have one yet.

## Windows

Open PowerShell (right-click Start → "Terminal" or "Windows PowerShell")
and paste:

```powershell
irm https://raw.githubusercontent.com/A-Su11y/zomboid-mods/main/scripts/install-updater.ps1 | iex
```

If your frozen install isn't at `%USERPROFILE%\ZomboidFrozen`, point the
installer at it first:

```powershell
$env:FROZEN_ROOT = 'D:\path\to\ZomboidFrozen'
irm https://raw.githubusercontent.com/A-Su11y/zomboid-mods/main/scripts/install-updater.ps1 | iex
```

Creates **Update Frozen Zomboid.lnk** on your Desktop.

## macOS

Open Terminal (⌘ + Space → "Terminal") and paste:

```bash
curl -fsSL https://raw.githubusercontent.com/A-Su11y/zomboid-mods/main/scripts/install-updater.sh | bash
```

If your frozen install isn't at `~/ZomboidFrozen`:

```bash
FROZEN_ROOT=/Volumes/External/ZomboidFrozen \
  curl -fsSL https://raw.githubusercontent.com/A-Su11y/zomboid-mods/main/scripts/install-updater.sh | bash
```

Creates **Update Frozen Zomboid.command** on your Desktop.

First launch: macOS Gatekeeper will block the shortcut — right-click
→ **Open** → confirm **Open** in the dialog. From then on it launches
normally.

## Running the updater

- Launch **Update Frozen Zomboid** on your Desktop **before** opening Zomboid.
- It will say either "already up to date" or list the mods it's updating.
- When it finishes, launch Zomboid as usual.
