#!/usr/bin/env zsh

set -euxo pipefail

echo "installing build-essentials..."
xcode-select --install

echo "installing homebrew..."
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

echo "installing rosetta..."
softwareupdate --install-rosetta --agree-to-license

echo "configuring shell profile..." 
touch .zshrc
echo 'source ~/.profile' >> .zshrc
touch .profile
echo 'export PATH="/opt/homebrew/bin:$PATH"' >> .profile
source .zshrc

echo "installing packages..."
# basic developer tools
brew install --cask iterm2 google-chrome visual-studio-code
# work stuff
brew install --cask slack
# quality of life
brew install --cask bitwarden maccy
# git and github
brew install git-lfs lazygit git-delta gh
# containers 
brew install docker docker-compose lazydocker colima
# the best ide
brew install neovim
# misc
brew install caddy
# moderm cli utils
brew install bat eza fzf jq ripgrep zoxide difftastic
# unix alternatives
brew install gnu-sed gnu-tar
# toolchains and languages
brew install deno rust
# browsers
brew install --cask firefox microsoft-edge
# games
brew install --cask steam

echo "configuring git..."
git config --global user.name "aryan02420"
git config --global user.email "aryan02420@gmail.com"
git config --global credential.helper store
git config --global init.defaultbranch main
# configute git-delta
git config --global core.pager=delta
git config --global interactive.difffilter=delta --color-only
git config --global delta.navigate=true
git config --global delta.light=false
git config --global delta.side-by-side=true
git config --global merge.conflictstyle=diff3
git config --global diff.colormoved=default 

echo "installing node..."
echo brew install volta
echo 'export VOLTA_FEATURE_PNPM=1' >> .profile
source .zshrc
volta install node
volta install pnpm
volta install yarn
volta setup
source .zshrc

echo "configuring packages..."
brew tap homebrew/services
echo 'eval "$(fzf --zsh)"' >> .profile
echo 'eval "$(zoxide init zsh)"' >> .profile
source .zshrc

echo "installing zsh prompt theme..."
brew tap homebrew/cask-fonts
brew install --cask font-meslo-lg-nerd-font
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
gsed -i 's/ZSH_THEME=".*"/ZSH_THEME="powerlevel10k\/powerlevel10k"/g' ~/.zshrc
gsed -i 's/plugins=.*/plugins=(git docker docker-compose brew sudo)/g' ~/.zshrc
exec zsh
p10k configure
echo 'source ~/.profile' >> .zshrc

echo "enabling executing apps from unknowns developers..."
sudo spctl --master-disable
