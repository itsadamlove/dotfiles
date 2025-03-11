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
cat cursor_extensions.txt | xargs -n 1 cursor --install-extensions
```

4. Symlink Configuration

```
ln -s ~/dotfiles/.vscode/settings.json ~/Library/Application\ Support/Cursor/User/settings.json
```
