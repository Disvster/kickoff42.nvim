#!/bin/sh

set -e

# Colors and emojis
GREEN='\033[1;32m'
YELLOW='\033[1;33m'
BLUE='\033[1;34m'
RED='\033[1;31m'
CYAN='\033[1;36m'
RESET='\033[0m'
BOLD='\033[1m'
CHECK="${GREEN}✔${RESET}"
CROSS="${RED}✖${RESET}"
INFO="\n${BOLD}${CYAN}ℹ${RESET}"
WARN="${YELLOW}⚠${RESET}"
STAR="${YELLOW}★${RESET}"

printf "\n"
printf "${BOLD}${BLUE}kickoff42.nvim Installer for 42School and similar environments${RESET}"
printf "${INFO} This script will install ${BOLD}Neovim${RESET}, ${BOLD}ripgrep${RESET}, and ${BOLD}fd-find${RESET} locally in ${BOLD}~/.local${RESET}"
printf "${INFO} No sudo or package manager required."
printf "\n"

# Check for required tools
for cmd in curl tar; do
  if ! command -v $cmd >/dev/null 2>&1; then
    printf "${CROSS} ${RED}Error:${RESET} ${BOLD}$cmd${RESET} is required but not installed. Aborting."
    exit 1
  fi
done

mkdir -p "$HOME/.local/bin" "$HOME/.local/share" "$HOME/.local/lib"

# Function to prompt user to install packages
confirm_install() {
  while true; do
    printf "${BOLD}${YELLOW}Install %s?${RESET} [y/N]: " "$1"
    read ans
    case "$ans" in
      [Yy]*|"") return 0 ;;
      [Nn]*) return 1 ;;
      *) printf "Please answer y or n." ;;
    esac
  done
}

# Function to prompt user to add ~/.local/bin to $PATH
confirm_export() {
  while true; do
    printf "${BOLD}${YELLOW}%s?${RESET} [y/N]: " "$1"
    read ans
    case "$ans" in
      [Yy]*|"") return 0 ;;
      [Nn]*) return 1 ;;
      *) printf "Please answer y or n." ;;
    esac
  done
}

# Add ~/.local/bin to PATH if not already present
shellrc="$HOME/.$(basename $SHELL)rc"
if ! grep -q 'export PATH="\$HOME/.local/bin:\$PATH"' "$shellrc" 2>/dev/null; then
  if confirm_export "Export $HOME/.local/bin to PATH in $(basename $shellrc)"; then
    printf 'export PATH="$HOME/.local/bin:$PATH"' >> "$shellrc"
    printf "${CHECK} Added PATH update to ${BOLD}$(basename $shellrc)${RESET}"
  else
    printf "${WARN} Skipped PATH update for $(basename $shellrc)"
  fi
fi

if [ $shellrc = "$HOME/.zshrc" ]; then
	shellrc="$HOME/.bashrc"
elif [ $shellrc == "$HOME/.bashrc" ]; then
	shellrc="$HOME/.zshrc"
fi

if ! grep -q 'export PATH="\$HOME/.local/bin:\$PATH"' "$shellrc" 2>/dev/null; then
  if confirm_export "Export $HOME/.local/bin to PATH in $(basename $shellrc)"; then
    printf 'export PATH="$HOME/.local/bin:$PATH"' >> "$shellrc"
    printf "${CHECK} Added PATH update to ${BOLD}$(basename $shellrc)${RESET}"
  else
    printf "${WARN} Skipped PATH update for $(basename $shellrc)"
  fi
fi

printf "\n"

# Install ripgrep
if confirm_install "ripgrep"; then
  printf "Installing ripgrep...\n"
  RG_LATEST=$(curl -s https://api.github.com/repos/BurntSushi/ripgrep/releases/latest | grep tag_name | cut -d '"' -f 4)
  RG_VERSION=$(printf "$RG_LATEST" | sed 's/^v//')
  RG_URL="https://github.com/BurntSushi/ripgrep/releases/download/${RG_LATEST}/ripgrep-${RG_VERSION}-x86_64-unknown-linux-musl.tar.gz"
  curl -L -o ripgrep.tar.gz --progress-bar "$RG_URL"
  tar -xzvf ripgrep.tar.gz
  printf "\n"
  mv ripgrep-*/rg "$HOME/.local/bin/"
  rm -rf ripgrep.tar.gz ripgrep-*
  printf "${CHECK} ripgrep installed!"
else
  printf "${WARN} Skipping ripgrep installation."
fi

printf "\n"

# Install fd-find
if confirm_install "fd-find"; then
  printf "Installing fd-find..."
  FD_LATEST=$(curl -s https://api.github.com/repos/sharkdp/fd/releases/latest | grep tag_name | cut -d '"' -f 4)
  FD_URL="https://github.com/sharkdp/fd/releases/download/${FD_LATEST}/fd-${FD_LATEST}-x86_64-unknown-linux-gnu.tar.gz"
  curl -L -o fd-find.tar.gz --progress-bar "$FD_URL"
  tar -xzvf fd-find.tar.gz
  printf "\n"
  mv fd-*/fd "$HOME/.local/bin/"
  rm -rf fd-find.tar.gz fd-*
  printf "${CHECK} fd-find installed!"
else
  printf "${WARN} Skipping fd-find installation."
fi

printf "\n"

# Install Neovim
if confirm_install "Neovim"; then
  printf "Installing Neovim..."
  NVIM_LATEST=$(curl -s https://api.github.com/repos/neovim/neovim/releases/latest | grep tag_name | cut -d '"' -f 4)
  NVIM_VERSION=$(printf "$NVIM_LATEST" | sed 's/^v//')
  NVIM_URL="https://github.com/neovim/neovim/releases/download/${NVIM_LATEST}/nvim-linux-x86_64.tar.gz"
  curl -L -o neovim.tar.gz "$NVIM_URL"
  tar -xzvf neovim.tar.gz
  printf "\n"
  cp nvim-linux-x86_64/bin/nvim "$HOME/.local/bin/"
  cp -r nvim-linux-x86_64/share/nvim "$HOME/.local/share/"
  cp -r nvim-linux-x86_64/lib/nvim "$HOME/.local/lib/"
  rm -rf neovim.tar.gz nvim-linux-x86_64
  printf "${CHECK} Neovim installed!"
else
  printf "${WARN} Skipping Neovim installation."
fi

printf "\n"

# Source the shellrc to update PATH immediately
if [ -f "$HOME/.bashrc" ]; then
  . "$HOME/.bashrc"
elif [ -f "$HOME/.zshrc" ]; then
  . "$HOME/.zshrc"
fi

printf "\n"
printf "${BOLD}${GREEN}Installation complete!${RESET} ${CHECK}"
printf "\n"
printf "${INFO} ${BOLD}First steps:${RESET}\n"
printf "  1. Run ${BOLD}nvim${RESET} to start Neovim.\n"
printf "  2. ${STAR} Press the ${BOLD}\\${RESET} to open the file browser.\n"
printf "  3. ${STAR} Explore the modular plugin structure in the ${BOLD}init.lua${RESET} file.\n"
printf "  4. ${WARN} Update your personal info!\n  - Edit the ${BOLD}user${RESET} and ${BOLD}mail${RESET} fields in the ${BOLD}lua/plugins/42/42-header.lua${RESET} plugin file to your own ${BLUE}42${RESET} username and email!\n"
printf "\n"
printf "${INFO} For more info, check the README or plugin files.\n"
printf "\n"
