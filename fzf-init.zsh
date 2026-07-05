# fzf initialization for macOS and Linux
# This file should be sourced from .zshrc

# Check if fzf is installed
if ! command -v fzf &> /dev/null; then
    return
fi

# Determine fzf installation directory
FZF_BASE=""

# Try different possible locations
if [[ -n "${HOMEBREW_PREFIX}" ]]; then
    # If brew is available, use it
    FZF_BASE="${HOMEBREW_PREFIX}/opt/fzf"
elif command -v brew &> /dev/null; then
    # Try to get brew prefix
    FZF_BASE="$(brew --prefix)/opt/fzf"
elif [[ -d "/opt/homebrew/opt/fzf" ]]; then
    # macOS Apple Silicon
    FZF_BASE="/opt/homebrew/opt/fzf"
elif [[ -d "/usr/local/opt/fzf" ]]; then
    # macOS Intel
    FZF_BASE="/usr/local/opt/fzf"
elif [[ -d "/home/linuxbrew/.linuxbrew/opt/fzf" ]]; then
    # Linux Homebrew
    FZF_BASE="/home/linuxbrew/.linuxbrew/opt/fzf"
elif [[ -d "/usr/share/doc/fzf" ]]; then
    # Ubuntu/Debian apt installation
    FZF_BASE="/usr/share/doc/fzf"
elif [[ -d "$HOME/.fzf" ]]; then
    # Git installation
    FZF_BASE="$HOME/.fzf"
fi

# Source fzf files if found
if [[ -n "$FZF_BASE" ]]; then
    # Key bindings (Ctrl+R, Ctrl+T, Alt+C)
    if [[ -f "$FZF_BASE/shell/key-bindings.zsh" ]]; then
        source "$FZF_BASE/shell/key-bindings.zsh"
    elif [[ -f "$FZF_BASE/examples/key-bindings.zsh" ]]; then
        # Ubuntu/Debian path
        source "$FZF_BASE/examples/key-bindings.zsh"
    fi

    # Completion
    if [[ -f "$FZF_BASE/shell/completion.zsh" ]]; then
        source "$FZF_BASE/shell/completion.zsh"
    elif [[ -f "$FZF_BASE/examples/completion.zsh" ]]; then
        # Ubuntu/Debian path
        source "$FZF_BASE/examples/completion.zsh"
    fi
fi

# fzf default options
export FZF_DEFAULT_OPTS="
--height 40%
--layout=reverse
--border
--preview-window=right:60%
"

# Use fd instead of find if available (faster and respects .gitignore)
if command -v fd &> /dev/null; then
    export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'
    export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
    export FZF_ALT_C_COMMAND='fd --type d --hidden --follow --exclude .git'
fi

# Better preview commands
export FZF_CTRL_T_OPTS="--preview 'bat --color=always --line-range=:500 {} 2> /dev/null || cat {} 2> /dev/null || tree -C {} 2> /dev/null'"
export FZF_ALT_C_OPTS="--preview 'tree -C {} | head -100'"

unset FZF_BASE
