# Minh's Neovim Configuration

This repository contains the configurations for my customized NeoVim experience :D

![Splash Screen Screenshot](./screenshots/splashscreen-windows-terminal.png)

## Why Move Away from COC.nvim?

There's no DAP protocol for COC.nvim, and I really wanted that.
I want to be able to use NeoVim while I'm at university, which includes
being able to debug code while I'm in the editor as well.

## Getting Started

### Required Software

These requirements are pretty similar to the ones listed on [LazyVim.org](https://www.lazyvim.org/):

- Neovim >= 0.9.0
- Git >= 2.19.0
- NodeJS ([npm](https://nodejs.org/en/download))
- [Treesitter C compiler](https://github.com/nvim-treesitter/nvim-treesitter#requirements)
- [ripgrep](https://github.com/BurntSushi/ripgrep)
- The most recent [Nerd Font >= 3.0.0](https://www.nerdfonts.com)
- A supported terminal:
  - [x] wezterm
  - [x] kitty
  - [x] alacritty
  - [ ] iterm2
  - [x] Windows Terminal

Some LSPs, formatters, and other software used in this configuration may not
work on ARM. Mason, for example, might freak out while installing some
packages. In the case that it does, you can always disable the Mason plugins
and install those LSPs and such yourself.

### Backing Up Your Configuration

> Note: 'backing up' in this context just means renaming
> those directories.

Before you go ahead and clone this configuration onto your machine, it's _recommended_
for you to first back up your own NeoVim configuration. Below are a list of directories
to back up:

**Linux**

- `$HOME/.config/nvim/`
- `$HOME/.local/share/nvim`
- `$HOME/.cache/nvim`

**Windows**

- `C:\Users\[your-username]\AppData\Local\nvim`
- `C:\Users\[your-username]\AppData\Local\nvim-data`

For example, you'd run these commands to back up on Linux:

```sh
mv $HOME/.config/nvim $HOME/.config/nvim.bak
mv $HOME/.local/share/nvim $HOME/.local/share/nvim.bak
mv $HOME/.cache/nvim $HOME/.cache/nvim.bak
```

### Cloning the Repository

Cloning the git repository is done with this command:

**Linux**

```sh
git clone https://github.com/samminhch/nvim ~/.config/nvim
```

**Windows**

```sh
git clone https://github.com/samminhch/nvim C:\Users\[your-username]\AppData\Local
```

### What's Next?

Check out the [wiki](https://github.com/samminhch/nvim/wiki)!
It's currently a work-in-progress, but it's planned to have:

- [ ] A list of plugins used + their configurations
- [ ] A list of keybinds
