mkdir -p ~/.local/bin ~/.local/share

echo 'export PATH="$HOME/.local/bin:$PATH"' >> ~/.bashrc

echo 'export PATH="$HOME/.local/bin:$PATH"' >> ~/.zshrc

source ~/.profile

curl -L -o ripgrep.tar.gz --progress-bar https://github.com/BurntSushi/ripgrep/releases/download/15.1.0/ripgrep-15.1.0-x86_64-unknown-linux-musl.tar.gz

tar -xzf ripgrep.tar.gz

rm ripgrep.tar.gz

mv ripgrep-15.1.0-x86_64-unknown-linux-musl/rg $HOME/.local/bin/

rm -rf ripgrep-15.1.0-x86_64-unknown-linux-musl

curl -L -o fd-find.tar.gz --progress-bar https://github.com/sharkdp/fd/releases/download/v10.3.0/fd-v10.3.0-x86_64-unknown-linux-gnu.tar.gz

tar -xzf fd-find.tar.gz

rm fd-find.tar.gz

mv fd-v10.3.0-x86_64-unknown-linux-gnu/fd $HOME/.local/bin/

rm -rf fd-v10.3.0-x86_64-unknown-linux-gnu

curl -L -o neovim.tar.gz https://github.com/neovim/neovim/releases/download/v0.11.6/nvim-linux-x86_64.tar.gz

tar -xzvf neovim.tar.gz

rm neovim.tar.gz

cp nvim-linux-x86_64/bin/nvim $HOME/.local/bin/

cp -r nvim-linux-x86_64/share/nvim $HOME/.local/share/

cp -r nvim-linux-x86_64/lib/nvim $HOME/.local/lib/

rm -rf nvim-linux-x86_64.tar.gz

echo "https://github.com/sharkdp/fd/releases/download/v10.3.0/fd-v10.3.0-x86_64-unknown-linux-gnu.tar.gz"
