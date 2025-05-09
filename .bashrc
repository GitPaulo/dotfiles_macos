# $ .bashrc (GitPaulo@Github)

# readline
bind 'set keyseq-timeout 20'

# Case-insensitive globbing (used in filename expansion)
shopt -s nocaseglob

# Case-insensitive tab completion
bind 'set completion-ignore-case on'

# Autocorrect typos in pathnames when using cd
shopt -s cdspell

# Auto-cd: just type a dirname to cd into it
shopt -s autocd

# Less annoying bell
set bell-style none

# Better pager & less flags
export PAGER=less
export LESS='-RFX' # -R raw control chars, -F quit if 1 screen, -X no init

# reload helper
alias reload='source ~/.bashrc && echo ".bashrc reloaded"'

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
export VISUAL="/opt/homebrew/bin/nvim"
export EDITOR="/opt/homebrew/bin/nvim"
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

# macos mv is annoying
# Override mv to support case-only renames on macOS (case-insensitive FS)
function mv() {
  # Only intercept simple 2-argument calls, not flags or lots of files
  if [[ $# -eq 2 && ! "$1" == -* && ! "$2" == -* ]]; then
    src="$1"; dst="$2"
    # Lowercase both paths (works in bash3 on macOS)
    lc_src=$(printf "%s" "$src" | tr '[:upper:]' '[:lower:]')
    lc_dst=$(printf "%s" "$dst" | tr '[:upper:]' '[:lower:]')
    if [[ "$lc_src" == "$lc_dst" ]]; then
      # Case-only rename: use a temporary name
      tmp="${src}.$$.casefix"
      command mv -v "$src" "$tmp" && command mv -v "$tmp" "$dst"
      return $?
    fi
  fi
  # Otherwise, just do the normal mv
  command mv "$@"
}

# Force GNU utils
export PATH="/usr/local/opt/coreutils/libexec/gnubin:$PATH"

# mv change
unalias mv 2>/dev/null
mv() {
  if [[ $# -eq 2 && ! "$1" == -* && ! "$2" == -* ]]; then
    local src="$1" dst="$2" lc_src lc_dst tmp
    lc_src=$(printf '%s' "$src" | tr '[:upper:]' '[:lower:]')
    lc_dst=$(printf '%s' "$dst" | tr '[:upper:]' '[:lower:]')
    if [[ "$lc_src" == "$lc_dst" ]]; then
      tmp="${src}.$$.casefix"
      command mv -vi "$src" "$tmp" && command mv -vi "$tmp" "$dst"
      return $?
    fi
  fi
  command mv -i "$@"
}

# Homebrew environment
eval "$(/opt/homebrew/bin/brew shellenv)"

# Starship prompt
if command -v starship >/dev/null 2>&1; then
  eval "$(starship init bash)"
fi

# Zoxide:
if command -v zoxide >/dev/null 2>&1; then
  eval "$(zoxide init bash)"
fi

# Minimal neofetch at login
if command -v neofetch >/dev/null 2>&1; then
    neofetch
fi

# activate fzf
eval "$(fzf --bash)"

# activate z (zoxide)
eval "$(zoxide init bash)"

# lastly, always tmux
if command -v tmux &> /dev/null && [ -z "$TMUX" ]; then
  exec tmux
fi

### Other

# Docker & kubectl bash completion
if command -v docker &>/dev/null; then
  source <(docker completion bash)
fi
if command -v kubectl &>/dev/null; then
  source <(kubectl completion bash)
fi

### MANAGED AREA

# NVM
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

### MANAGED BY RANCHER DESKTOP START (DO NOT EDIT)
export PATH="/Users/gitpaulo/.rd/bin:$PATH"
### MANAGED BY RANCHER DESKTOP END (DO NOT EDIT)


