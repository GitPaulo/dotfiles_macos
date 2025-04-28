# `dotfiles_macos`

I'm forced to use macos at work so here's the dotfiles,

## ✋ Steps before cloning

### 0. Debloat MacOS

Take care with these,

- https://gist.github.com/sarthakpranesh/c4ba43a2f8e75518acedb9480087a3ee
- https://github.com/Wamphyre/macOS_Silverback-Debloater/blob/main/macOS_Silverback-Debloater.sh

### 1. Essential Tools

Install https://brew.sh/ and,

```sh
  brew install coreutils z fzf bat fd pass ranger skhd gnu-sed gawk grep
```

### 2. Terminal

These,

- https://www.nerdfonts.com/font-downloads
- https://alacritty.org/

### 3. Bash as default shell, and improvements

```sh
chsh -s <path_to_new_bash>
```

might have to configure `/etc/shells`

```sh
vim /etc/shells
```

Setup git auto completion through homebrew,

```
brew install bash-completion
```

add it to `.bashrc` (its already there but just explaining)

```sh
# homebrew way of adding bash completion
if [[ -s $HOMEBREW_PREFIX/etc/profile.d/bash_completion.sh ]]; then
  . "$HOMEBREW_PREFIX/etc/profile.d/bash_completion.sh"
fi
```

> remember in macos `/etc/bashrc` is apparently not sourced at all, and `~/.bashrc` is not sourced from `~/.bash_profile` by default. these dotfiles fix that

### 4. Window manager `yabai`

https://github.com/koekeishiya/yabai/wiki and https://www.josean.com/posts/yabai-setup

> remember system protecitons must be disabled for full features

### 5. Sketchy bar

https://felixkratz.github.io/SketchyBar/setup

for icons

```sh
brew install --cask font-sketchybar-app-font
```

### Better system apps

- Better alt + tab: https://alt-tab-macos.netlify.app/
- Better file manager: https://binarynights.com/manual and https://youtu.be/k94qImbFKWE
- Better spotlight: https://www.raycast.com/
- Better menu bar: https://github.com/jordanbaird/Ice
- Menu bar calendar: https://www.mowglii.com/itsycal/
- Menu bar stats: https://github.com/exelban/stats
- Menu bar todo: https://ticktick.com/?language=en_US
