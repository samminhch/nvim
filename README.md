# Minh's Neovim Configuration

This repository contains the configurations for my customized NeoVim experience :D

![Splash Screen Screenshot](./screenshots/splashscreen-windows-terminal.png)

## Why the Move to Lazy.nvim?

There's a couple of reasons why I wanted to move from Packer.nvim to lazy.nvim

- I got curious :)
  - After seeing [LazyVim's configuration](https://www.lazyvim.org/),
    I wanted to try out the plugin system as well.

- The current configuration I had with `Packer.nvim` was really slow.
  - Pretty sure it was my own fault for just copy-pasting a lot of the
    configurations without understanding them lol.
  - `lazy.nvim`'s lazy loading feature was pretty neat, and I'm pretty
    sure that improved the performance of my NeoVim by a lot!

- It's easier for me to maintain
  - I liked `lazy.nvim`'s way of just letting me add plugins in the
    `lua/samminhch/plugins` directory. It's just very seamless, and intuitive to
    find the configurations for just a specific plugin

### For Those Using my Packer.nvim Config

There's not really much that you're missing out on, you don't have
update to this version of my NeoVim config if you don't want to.
I'll make a git tag so that it'll be easy for you to find that version
of my NeoVim configuration. However! From now on I'll probably stick
to `lazy.nvim` for adding and maintaining plugins.

## Getting Started

### Required Software

You'll need `nodejs` in order to use the features that [coc.nvim](https://github.com/neoclide/coc.nvim) delivers.
You'll also need `git` to clone this repository.

### Backing Up Your Configuration

> Note: 'backing up' in this context just means renaming
> those directories.

Before you go ahead and clone this configuration onto your machine, it's *recommended*
for you to first backup your own NeoVim configuration. Below are a list of directories
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

```powershell
git clone https://github.com/samminhch/nvim C:\Users\[your-username]\AppData\Local
```

### What's Next?

Check out the [wiki](https://github.com/samminhch/nvim/wiki)!
It's currently a work-in-progress, but it's planned to have:

- [ ] A list of plugins used + their configurations
- [ ] A list of keybinds
