# First-time updater install

You only do this once per machine. After this, patching is one double-click.

## Windows

1. Open PowerShell (not Admin).
2. Paste:

   ```powershell
   $repo = 'OWNER/REPO'
   $dest = "$env:USERPROFILE\ZomboidFrozen\update-frozen-zomboid.ps1"
   Invoke-WebRequest "https://raw.githubusercontent.com/$repo/main/scripts/update-frozen-zomboid.ps1" -OutFile $dest -UseBasicParsing
   (Get-Content $dest -Raw) -replace "OWNER/REPO", $repo | Set-Content $dest -Encoding utf8

   $sh = New-Object -ComObject WScript.Shell
   $lnk = $sh.CreateShortcut("$([Environment]::GetFolderPath('Desktop'))\Update Frozen Zomboid.lnk")
   $lnk.TargetPath = 'powershell.exe'
   $lnk.Arguments  = "-NoProfile -ExecutionPolicy Bypass -File `"$dest`""
   $lnk.WorkingDirectory = "$env:USERPROFILE\ZomboidFrozen"
   $lnk.Save()
   ```

3. There is now a "Update Frozen Zomboid" shortcut on your Desktop.
   Double-click it whenever told a patch dropped.

## macOS

1. Open Terminal.
2. Paste:

   ```bash
   REPO='OWNER/REPO'
   DEST="$HOME/ZomboidFrozen/update-frozen-zomboid.sh"
   curl -fsSL "https://raw.githubusercontent.com/$REPO/main/scripts/update-frozen-zomboid.sh" -o "$DEST"
   sed -i '' "s|OWNER/REPO|$REPO|g" "$DEST"
   chmod +x "$DEST"

   DESK="$HOME/Desktop/Update Frozen Zomboid.command"
   cat > "$DESK" <<EOF
   #!/usr/bin/env bash
   exec "$DEST"
   EOF
   chmod +x "$DESK"
   ```

3. There is now a "Update Frozen Zomboid.command" on your Desktop.
   First launch: Gatekeeper will block it — right-click → Open → confirm.
   After that, just double-click.

## Running

- Launch "Update Frozen Zomboid" **before** opening the game.
- It will say either "already up to date" or list the mods it's updating.
- When it finishes, launch Zomboid as usual.
