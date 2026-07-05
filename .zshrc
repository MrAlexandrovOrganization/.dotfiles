# Detect OS
if [[ "$OSTYPE" == "darwin"* ]]; then
    export IS_MACOS=true
elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
    export IS_LINUX=true
fi

# Brew completion (macOS and Linux)
if command -v brew &> /dev/null; then
    if [ -f $(brew --prefix)/etc/zsh_completion ]; then
        . $(brew --prefix)/etc/zsh_completion
    fi
fi

# The next line updates PATH for CLI.
if [ -f "$HOME/yandex-cloud/path.bash.inc" ]; then source "$HOME/yandex-cloud/path.bash.inc"; fi

# The next line enables shell command completion for yc.
if [ -f "$HOME/yandex-cloud/completion.zsh.inc" ]; then source "$HOME/yandex-cloud/completion.zsh.inc"; fi



# Poetry
export PATH="$HOME/.local/bin:$PATH"

export NODE_EXTRA_CA_CERTS=/etc/ssl/certs/YandexInternalCA.pem

# ---

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share/zinit/zinit.git}"

if [ ! -d "$ZINIT_HOME" ]; then
    mkdir -p "$(dirname $ZINIT_HOME)"
    git clone git@github.com:zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

source "${ZINIT_HOME}/zinit.zsh"

zinit ice depth=1; zinit light romkatv/powerlevel10k
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light Aloxaf/fzf-tab

# zoxide - smarter cd command
if command -v zoxide &> /dev/null; then
    eval "$(zoxide init zsh)"
fi

# fzf - fuzzy finder
if [ -f "$HOME/.dotfiles/fzf-init.zsh" ]; then
    source "$HOME/.dotfiles/fzf-init.zsh"
fi

# Lines configured by zsh-newuser-install
# Create symlink to .dotfiles/.histfile
if [[ ! -L "$HOME/.histfile" ]] || [[ "$(readlink "$HOME/.histfile")" != "$HOME/.dotfiles/.histfile" ]]; then
    rm -f "$HOME/.histfile"
    ln -sf "$HOME/.dotfiles/.histfile" "$HOME/.histfile"
fi

HISTFILE=~/.histfile
HISTSIZE=10000
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

# Completion styling
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}" # Add color for ls
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath' # Window on the right side

bindkey -e
# Перемещение по словам через Ctrl+стрелки
bindkey "^[[1;5D" backward-word    # Ctrl+Left
bindkey "^[[1;5C" forward-word     # Ctrl+Right

# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename "$HOME/.zshrc"

# Aliases
alias ls='ls --color'
alias ll='ls -lah'
alias la='ls -A'
alias l='ls -CF'

# Directory navigation aliases
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'

# zoxide aliases (if installed)
if command -v zoxide &> /dev/null; then
    alias cd='z'  # Replace cd with zoxide
    alias cdi='zi'  # Interactive directory selection
fi

# Skip insecure directories check for compinit
autoload -Uz compinit
compinit -u
# End of lines added by compinstall

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

export PATH=$PATH:/usr/local/go/bin
export GOPATH=$HOME/go
export PATH=$PATH:$GOPATH/bin

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
