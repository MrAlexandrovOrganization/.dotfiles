#!/bin/bash

# Installation script for zoxide - a smarter cd command

echo "Installing zoxide..."

if [[ "$OSTYPE" == "darwin"* ]]; then
    # macOS
    if command -v brew &> /dev/null; then
        echo "Installing via Homebrew..."
        brew install zoxide
    else
        echo "Homebrew not found. Installing via curl..."
        curl -sS https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | bash
    fi
elif [[ "$OSTYPE" == "linux-gnu"* ]] || [[ "$OSTYPE" == "linux"* ]]; then
    # Linux - use universal installer as package managers often don't have zoxide
    echo "Installing via universal installer (curl)..."
    echo "This will install zoxide to ~/.local/bin"
    curl -sS https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | bash
    
    # Ensure ~/.local/bin is in PATH
    if [[ ":$PATH:" != *":$HOME/.local/bin:"* ]]; then
        echo ""
        echo "⚠️  Note: ~/.local/bin is not in your PATH"
        echo "Add this line to your ~/.zshrc if not already present:"
        echo '  export PATH="$HOME/.local/bin:$PATH"'
    fi
fi

echo ""
echo "✅ zoxide installed successfully!"
echo ""
echo "To start using zoxide, reload your shell:"
echo "  source ~/.zshrc"
echo ""
echo "Usage examples:"
echo "  z documents     # Jump to a directory containing 'documents'"
echo "  zi              # Interactive directory selection with fzf"
echo "  z -            # Go to previous directory"
echo "  zoxide query documents  # Query the database"
echo ""
