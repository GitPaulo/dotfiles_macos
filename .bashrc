## paulo's .bashrc

# readline
bind 'set keyseq-timeout 20'

# Case-insensitive globbing (used in filename expansion)
shopt -s nocaseglob

# Autocorrect typos in pathnames when using cd
shopt -s cdspell

# Less annoying bell
set bell-style none

# history
export HISTCONTROL=ignoredups:erasedups # no duplicate entries
export HISTSIZE=100000
export HISTFILESIZE=100000
shopt -s histappend

# bash completion (homebrew)
if [[ -s $HOMEBREW_PREFIX/etc/profile.d/bash_completion.sh ]]; then
    . "$HOMEBREW_PREFIX/etc/profile.d/bash_completion.sh"
fi

# fzf setup
if [[ -f ~/.fzf.bash ]]; then
    source ~/.fzf.bash
fi
export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND='fd --type d --hidden --follow --exclude .git'
export FZF_DEFAULT_OPTS='--height 40% --reverse --border --preview "bat --style=numbers --color=always {} || cat {}" --preview-window=right:60%'
export FZF_CTRL_R_OPTS='--height 40% --reverse --border --preview "printf \"%s\n\" {}" --preview-window=down:3:hidden:wrap'

# fix: use fzf's provided history widget for Ctrl-R
bind -x '"\C-r": __fzf_history__'

# git fzf tools
source <(curl -sSL git.io/forgit)

# export defaults
export VISUAL="/usr/local/bin/vim"
export EDITOR="vim"
alias r="ranger"
alias clipboard='pbcopy'

# overwrite with GNU coreutils to PATH
export PATH="/opt/homebrew/opt/coreutils/libexec/gnubin:$PATH"
export PATH="/opt/homebrew/opt/findutils/libexec/gnubin:$PATH"
export PATH="/opt/homebrew/opt/gnu-sed/libexec/gnubin:$PATH"
export PATH="/opt/homebrew/opt/grep/libexec/gnubin:$PATH"
export PATH="/opt/homebrew/opt/gawk/libexec/gnubin:$PATH"

# aliases to make it feel like home
alias ll='ls -lh --color=auto'
alias la='ls -lAh --color=auto'
alias l='ls -CF --color=auto'
alias grep='grep --color=auto'
alias rm='rm -i' # safer deletes
alias cp='cp -i'
alias mv='mv -i'

# vi mode
set -o vi
function set_cursor_shape() {
    case "$1" in
    insert) echo -ne '\e[6 q' ;;  # Beam cursor
    command) echo -ne '\e[2 q' ;; # Block cursor
    esac
}
function update_cursor() {
    if [[ $BASH_COMMAND == *vi-editing-mode* ]]; then
        set_cursor_shape command
    elif [[ $BASH_COMMAND == *vi-insert-mode* ]]; then
        set_cursor_shape insert
    fi
}
PROMPT_COMMAND="update_cursor; $PROMPT_COMMAND"
bind 'set show-mode-in-prompt on'
bind 'set vi-ins-mode-string \1\e[6 q\2'
bind 'set vi-cmd-mode-string \1\e[2 q\2'
set_cursor_shape command

# Homebrew environment
eval "$(/opt/homebrew/bin/brew shellenv)"

# Starship prompt
eval "$(starship init bash)"

# Minimal neofetch at login
if command -v neofetch >/dev/null 2>&1; then
    neofetch
fi

# activate fzf
eval "$(fzf --bash)"

# z for macos
eval "$(zoxide init bash)"

# lastly, always tmux
if command -v tmux &> /dev/null && [ -z "$TMUX" ]; then
  exec tmux
fi

