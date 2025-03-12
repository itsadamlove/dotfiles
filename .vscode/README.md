# Sync Cursor / VSCode

1. Locate configuration files `~/Library/Application Support/Cursor/User/`
2. Symlink the config files:

   - `settings.json`
   - `keybindings.json`
   - `snippets.json`

3. Sync extensions:

```
cursor --list-extensions > cursor_extensions.txt
```

To Install:

```
cat cursor_extensions.txt | xargs -n 1 cursor --install-extension
```

4. Symlink Configuration

```
ln -s ~/dotfiles/.vscode/settings.json ~/Library/Application\ Support/Cursor/User/settings.json
ln -s ~/dotfiles/.vscode/keybindings.json ~/Library/Application\ Support/Cursor/User/keybindings.json
ln -s ~/dotfiles/.vscode/snippets.json ~/Library/Application\ Support/Cursor/User/snippets.json
```

4. What if we attempt to sync the extensions.json file from the cursor folder?

```
ln -s ~/dotfiles/.vscode/extensions.json ~/.cursor/extensions/extensions.json
```
