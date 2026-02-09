echo 'export PATH="$HOME/.local/bin${PATH+:$PATH}"' >> ~/.profile

source ~/.profile

curl -L -o ripgrep.tar.gz --progress-bar https://github.com/BurntSushi/ripgrep/releases/download/15.1.0/ripgrep-15.1.0-x86_64-unknown-linux-musl.tar.gz

tar -xzf ripgrep.tar.gz

rm ripgrep.tar.gz

mv ripgrep-15.1.0-x86_64-unknown-linux-musl/rg .local/bin/
