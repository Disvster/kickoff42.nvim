#!/bin/sh

set -e

echo "kickoff42.nvim installer for 42School and similar environments"
echo "This script will install Neovim, ripgrep, and fd-find locally in ~/.local"
echo "No sudo or package manager required."
echo

# Check for required tools
for cmd in curl tar; do
  if ! command -v $cmd >/dev/null 2>&1; then
    echo "Error: $cmd is required but not installed. Aborting."
    exit 1
  fi
done

mkdir -p "$HOME/.local/bin" "$HOME/.local/share" "$HOME/.local/lib"

# Function to prompt user to install packages
confirm_install() {
  while true; do
    printf "Install %s? [y/N]: " "$1"
    read ans
    case "$ans" in
      [Yy]*) return 0 ;;
      [Nn]*|"") return 1 ;;
      *) echo "Please answer y or n." ;;
    esac
  done
}

# Function to prompt user to add ~/.local/bin to $PATH
confirm_export() {
  while true; do
    printf "%s? [y/N]: " "$1"
    read ans
    case "$ans" in
      [Yy]*"") return 0 ;;
      [Nn]*) return 1 ;;
      *) echo "Please answer y or n." ;;
    esac
  done
}

# Add ~/.local/bin to PATH if not already present
shellrc="$HOME/.$(basename $SHELL)rc"
# for shellrc in "$HOME/.bashrc" "$HOME/.zshrc"; do
if ! grep -q 'export PATH="\$HOME/.local/bin:\$PATH"' "$shellrc" 2>/dev/null; then
  if confirm_export "Export $HOME/.local/bin to PATH in $(basename $shellrc)"; then
    echo 'export PATH="$HOME/.local/bin:$PATH"' >> "$shellrc"
    echo "Added PATH update to $(basename $shellrc)"
  else
    echo "Skipped PATH update for $(basename $shellrc)"
  fi
fi

if [ $shellrc = "$HOME/.zshrc" ]; then
	shellrc="$HOME/.bashrc"
elif [ $shellrc == "$HOME/.bashrc" ]; then
	shellrc="$HOME/.zshrc"
fi

if ! grep -q 'export PATH="\$HOME/.local/bin:\$PATH"' "$shellrc" 2>/dev/null; then
  if confirm_export "Export $HOME/.local/bin to PATH in $(basename $shellrc)"; then
    echo 'export PATH="$HOME/.local/bin:$PATH"' >> "$shellrc"
    echo "Added PATH update to $(basename $shellrc)"
  else
    echo "Skipped PATH update for $(basename $shellrc)"
  fi
fi


# Install ripgrep
if confirm_install "ripgrep"; then
  echo "Installing ripgrep..."
  RG_LATEST=$(curl -s https://api.github.com/repos/BurntSushi/ripgrep/releases/latest | grep tag_name | cut -d '"' -f 4)
  RG_VERSION=$(echo "$RG_LATEST" | sed 's/^v//')
  RG_URL="https://github.com/BurntSushi/ripgrep/releases/download/${RG_LATEST}/ripgrep-${RG_VERSION}-x86_64-unknown-linux-musl.tar.gz"
  curl -L -o ripgrep.tar.gz --progress-bar "$RG_URL"
  tar -xzvf ripgrep.tar.gz
  echo
  mv ripgrep-*/rg "$HOME/.local/bin/"
  rm -rf ripgrep.tar.gz ripgrep-*
else
  echo "Skipping ripgrep installation."
fi

# Install fd-find
if confirm_install "fd-find"; then
  echo "Installing fd-find..."
  FD_LATEST=$(curl -s https://api.github.com/repos/sharkdp/fd/releases/latest | grep tag_name | cut -d '"' -f 4)
  # FD_VERSION="$FD_LATEST"
  FD_URL="https://github.com/sharkdp/fd/releases/download/${FD_LATEST}/fd-${FD_LATEST}-x86_64-unknown-linux-gnu.tar.gz"
  curl -L -o fd-find.tar.gz --progress-bar "$FD_URL"
  tar -xzvf fd-find.tar.gz
  echo 
  mv fd-*/fd "$HOME/.local/bin/"
  rm -rf fd-find.tar.gz fd-*
else
  echo "Skipping fd-find installation."
fi

# Install Neovim
if confirm_install "Neovim"; then
  echo "Installing Neovim..."
  NVIM_LATEST=$(curl -s https://api.github.com/repos/neovim/neovim/releases/latest | grep tag_name | cut -d '"' -f 4)
  NVIM_VERSION=$(echo "$NVIM_LATEST" | sed 's/^v//')
  NVIM_URL="https://github.com/neovim/neovim/releases/download/${NVIM_LATEST}/nvim-linux-x86_64.tar.gz"
  curl -L -o neovim.tar.gz "$NVIM_URL"
  tar -xzvf neovim.tar.gz
  echo
  cp nvim-linux-x86_64/bin/nvim "$HOME/.local/bin/"
  cp -r nvim-linux-x86_64/share/nvim "$HOME/.local/share/"
  cp -r nvim-linux-x86_64/lib/nvim "$HOME/.local/lib/"
  rm -rf neovim.tar.gz nvim-linux-x86_64
else
  echo "Skipping Neovim installation."
fi

echo
echo "Installation complete!"
echo "Please restart your terminal or source your shell profile to update PATH."
echo "Run 'nvim' to start Neovim."
