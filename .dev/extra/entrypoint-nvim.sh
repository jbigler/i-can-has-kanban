#!/bin/zsh
set -xeuo pipefail

mkdir -p ~/.config
mkdir -p ~/.local

# if [[ ! -f ~/.config/nvim/init.lua ]]; then
# 	git clone --depth 1 https://github.com/AstroNvim/AstroNvim ~/.config/nvim
# 	git clone https://github.com/jbigler/AstroNvim-user.git ~/.config/nvim/lua/user
# else
# 	git -C ~/.config/nvim/lua/user pull
# fi

# Then exec the container's main process (what's set as CMD in the Dockerfile).
exec "$@"
