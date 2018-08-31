# Adam Love's Dotfiles

>> NOTE: Switch to vim plug, neovim & doplete --> https://medium.com/@alexlafroscia/writing-js-in-vim-4c971a95fd49

iTerm2 with Zsh
![terminalScreenshot](https://user-images.githubusercontent.com/1585331/37510023-d9b0ccb6-294d-11e8-9e37-b8d589b5c824.gif)

Vim
![vimScreenshot](https://user-images.githubusercontent.com/1585331/37510300-bea947da-294e-11e8-94c1-7221075849ca.gif)

Tmux
![tmuxScreenshot](https://user-images.githubusercontent.com/1585331/37510689-1c471574-2950-11e8-96a1-54f3e4e67999.gif)

Todo:
- [x] Init repo for dotfiles
- [x] Commit dotfiles to github
- [x] Write Readme
- [ ] Separate vim snippets and keep them in repo
- [ ] Write Install Script to do everything automatically with brew cask

## Contents
  - [Config Overview](#config-overview)
    - [Zsh](#zsh-features)
    - [Vim](#vim-features)
    - [Tmux](#Tmux-features)
- [Installation Instructions](#installation-instructions)
  - [Install XCode Command Line Tools](#1-install-xcode-command-line-tools-macos)
  - [Install Homebrew](#2-install-homebrew-macos)
  - [Install iTerm2](#3-install-iterm2-macos)
    - [Launching iTerm2 with Command-Enter](#launching-new-iterm2-window-with-command-enter)
  - [Install Zsh & Oh My Zsh](#4-install-zsh-and-oh-my-zsh)
  - [Install FZF](#5-install-fzf)
  - [Install YouCompleteMe](#6-install-youcompleteme)
  - [Run setup.sh](#7-run-setupsh)
  - [Install Dev Tools](#8-install-dev-tools)
- [Other Helpful Tools for MacOS](#other-helpful-tools-for-macos)
  - [Alfred](#alfred)
  - [Better Touch Tool](#better-touch-tool)
  - [Karabiner Elements](#karabiner-elements)
  - [Focus](#focus)


## Config Overview

### Zsh Features
- Cute Aliases
- Command highlighting
- AutoCompletion

### Vim Features
- `<Space>` is the leader
- Awesome split settings
  - `vv` opens a vertical split
  - `ss` opens a horizontal one
  - `W` close a split
  - `<C-h>` move to left split
  - `<C-j>` move to split below
  - `<C-k>` move to split above
  - `<C-l>` move to right split
- Use Buffers instead of tabs
  - `<leader>l` moves to the next buffer
  - `<leader>h` moves to the next buffer
  - `<leader>t` open an empty buffer
  - `<leader>w` closes the current buffer but keeps the split open
  - `<leader>q` close all buffers
  - `<leader><leader>` switch between the last two files
- Awesome FZF Config
  - `<C-b>` Display open buffers
  - `<C-p>` Search files
  - `<C-g>g` Fuzzy find any text
  - `<C-g>c` Display commands
  - `<C-g>c` Search Lines in the buffer
  - `<leader>g` search for the word under the cursor
- Great auto complete & snippets
- Markdown Rendering
- Many, many more features...

### Tmux Features
- Seemless navigation between vim splits and tmux panes using Vim keybindings
- System Clipboard integration

## Installation Instructions

The following guide is intended to mac it as quick and painless as possible to set up a new computer. This guide is tailored towards macOS, but most sections will work fine with linux.

- STEP 1: DEFINE ALL THE THINGS AND PUT ON GITHUB
- STEP 2: CREATE SCRIPT TO DO ALL THE THINGS AUTOMATICALLY USING BREW CASK

### 1. Install Xcode Command Line Tools (macOS)
MacOS will alert you to install the command line tools when you attempt to run a command that requires them.
Let's be prepared and install them up before we get stuck without them.
```bash
$ xcode-select --install
```
Verify successful installation with:
```bash
$ xcode-select -p
/Applications/Xcode.app/Contents/Developer
```
Verify gcc is installed:
```bash
$ gcc --version
Configured with: --prefix=/Applications/Xcode.app/Contents/Developer/usr --with-gxx-include-dir=/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.13.sdk/usr/include/c++/4.2.1
Apple LLVM version 9.0.0 (clang-900.0.39.2)
Target: x86_64-apple-darwin17.4.0
Thread model: posix
InstalledDir: /Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin
```


### 2. Install Homebrew (macOS)
[Homebrew](https://brew.sh) is a package manager for macOS.
``` bash
$ /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
```
**OPTIONAL**: Install brew cask and install everything else through there without needing GUI

### 3. Install iTerm2 (macOS)
iTerm2 is a terminal replacement for macOS. It's got some great [features](https://www.iterm2.com/features.html) and is super customisable.

Download it [here](https://www.iterm2.com/downloads.html) - it's up to you if you use the stable release or nightly builds.

My entire iTerm2 preferences are exported into the `iTerm2` folder.
However, should you wish to customise the settings, my default profile is a nameless profile with a custom color palette built for the gruvbox theme. It's also available in the `iTerm2` folder.
I run the dark theme with a left tab bar location and don't use tabs - tmux ftw! I hide scrollbars and menu bars.


#### Launching new iTerm2 window with Command-Enter
One of my most loved features from my i3 days was being able to launch a new terminal window from anywhere. I have since struggled to replicate that functionality on macOS, however have now settled for a third party solution.

**[Spark](https://www.shadowlab.org/softwares/spark.php)** is a tool that allows easy creation of hot keys for anything in your mac.
You can create custom apple scripts and then assign them to keyboard shortcuts. For example I could assign Command-Enter to the following for my iTerm2 needs:

``` applescript
tell application "iTerm"
  create window with default profile
end tell
```

### 4. Install Zsh and Oh My Zsh
Yes, you can use bash, you can use [fish](https://fishshell.com), you can use whatever you like. I've used Zsh for as long as I can remember, it works for me.

**Install Zsh**

Most versions of macOS ship with zsh by default, but it may be an older version (or you might not have it at all)
```
brew install zsh zsh-completions
```
See [here](https://github.com/robbyrussell/oh-my-zsh/wiki/Installing-ZSH) to see installation instructions for other operating systems.

**Set Zsh as the default shell**

The comman to change the shell at start up is `chsh - <path_to_shell>`. It's important to note that in macOS, default shells are installed in the `bin` directory, hence to change your shell to the default `zsh` shell, use
```bash
chsh -s /bin/zsh
```
However, if you're using a different version of `zsh` (like the one from homebrew) then youll want to use something like:
```
sudo sh -c "echo '/usr/local/bin/zsh' >> /etc/shells" && chsh -s /usr/local/bin/zsh
```

**Install Oh My Zsh**

[Oh My Zsh](https://github.com/robbyrussell/oh-my-zsh) is a framework for managing your zsh config.

Install via:
```bash
sh -c "$(wget https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"
```

Plugins and settings are located in `.zshrc`

### 5. Install FZF

[FZF](https://github.com/junegunn/fzf) is a command line fuzzy finder - and it's amazing! Used initially as a vim plugin, I quickly fell in love and use it everywhere. It can be used with any lists: files, processes, history, commits, hostnames, colors, bookmarks etc.
It's blazingly fast and the Vim plugin has to be one of my favourites. See configuration options on the official [repo](https://github.com/junegunn/fzf#key-bindings-for-command-line)

Install via:
```bash
brew install fzf

# To install useful key bindings and fuzzy completion:
$(brew --prefix)/opt/fzf/install
```

### 6. Install YouCompleteMe
If you don't use vim, you can ignore this step. If you're a hardcore vim user like me and you want an awesome code completion engine, then you'll want to checkout [youCompleteMe](https://github.com/Valloric/YouCompleteMe).

Make sure you read the [install instructions](https://github.com/Valloric/YouCompleteMe#mac-os-x) for your operating system before you begin. YCM is a plugin with a compiled component, so it's not a good solution for remote work, but for local work, I love it. Also, be sure to check out the language support options and install what is best for you.
```bash
cd ~/.vim/bundle/YouCompleteMe
./install.py --clang-completer --js-completer --java-completer
```

### 7. Run setup.sh
Clone this repository to your home directory, and run `setup.sh`.
The `setup.sh` script will save your current dotfiles to `~/dotfiles_old`. It will then simlink your dotfiles to the ones in this repo.
In order to use the vimrc you'll have to install [Vundle](https://github.com/VundleVim/Vundle.vim) and run `PluginInstall`

### 8. Install Dev tools
The final step is to install all your other dev tools that you need. I'll get around to making a nice solution for this soon.
- [ ] Chruby
- [ ] Ruby Install
- [ ] Postgres
- [ ] Redis
- [ ] Node
- [ ] Yarn

## Other helpful tools for macOS
As a small bonus I've included a view other applications that I use on a daily basis in macOS. They're awesome!

### Alfred
[Alfred](https://www.alfredapp.com/) is like spotlight for your mac but on steriods. It enables you to launch applications, find files, run conversions, search the web, calculate, control system commands, control your music and much, much more. You can even build your own scripts known as *workflows* or [download pre-built workflows](https://www.alfredapp.com/workflows/). I've become that depenedent on Alfred that I can't use a Mac without it.

### Better Touch Tool
[Better Touch Tool]() is a utility for macOS that allows customisation of inputs. Basically this allows for the creation of custom keyboard shortcuts and trackpad gestures.
I use Better Touch Tool to enable window snapping on macOS. Comming from i3 which was a tiling window manager, I struggled with macOS's default window manager settings. It's still not as good as i3, but it makes macOS much more usable. Being a vim user, these are the keyboard shortcuts that I enabled for window snapping.

![betterSnapToolScreenshot1](https://user-images.githubusercontent.com/1585331/37509299-e2637190-294a-11e8-9f41-5439d3c404c1.png)

As well as using it for window snapping, I also love the hidden feature that enables custom trackpad control of window resizing and window moving. I simply hold `option` and move my trackpad to move a window.

![betterSnapToolScreenshot2](https://user-images.githubusercontent.com/1585331/37509304-e6dd75f4-294a-11e8-919e-6e08934300eb.png)

### Karabiner Elements
Another great tool for macOS is [Karabiner Elements](), which is a powerful utility that allows a user to customise the keyboard in macOS to make custom keyboard shortcuts. I only use it for a single task, to remap caps lock. **Caps lock is the single most useless key on any keyboard.** Being a vim user, I **need** my escape key, hence I remap `caps lock > escape`. You will not believe how much more comfortable this made coding sessions in vim.

![karabinerElementsScreenShot](https://user-images.githubusercontent.com/1585331/37509310-eaf88688-294a-11e8-846c-d2c41f2cb5eb.png)

### Focus
To be honest, [Focus](https://heyfocus.com/) shouldn't be necessary if you have decent self control. However, I've met numerous people that don't realise how much time they waste each day instinctively checking Facebook or watching cat videos on youTube. Focus simply blocks these distractions for a time period and replaces them with a motivational quote. Sure, it won't stop you browsing your newsfeed if you really want to, however it will force you to realise how many times you instinctly hit up that url in your browser.
