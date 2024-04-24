#!/usr/bin/env zsh

set -euxo pipefail

echo "installing build-essentials..."
xcode-select --install

echo "installing homebrew..."
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

echo "configuring shell profile" 
touch .zshrc
echo 'source ~/.profile' >> .zshrc
touch .profile
echo 'export PATH="/opt/homebrew/bin:$PATH"' >> .profile
source .zshrc

echo "installing packages"
brew install --cask iterm2 google-chrome visual-studio-code bitwarden slack maccy
brew install volta lazygit git-delta difftastic bat eza fzf jq ripgrep zoxide gnu-sed gnu-tar docker docker-compose lazydocker neovim

echo "download node"
echo 'export VOLTA_FEATURE_PNPM=1' >> .profile
source .zshrc
volta install node
volta install pnpm
volta setup
source .zshrc

echo "configure packages"
brew tap homebrew/services
echo 'eval "$(fzf --zsh)"' >> .profile
echo 'eval "$(zoxide init zsh)"' >> .profile
source .zshrc

echo "install zsh prompt"
brew tap homebrew/cask-fonts
brew install --cask font-meslo-lg-nerd-font
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
gsed -i 's/ZSH_THEME=".*"/ZSH_THEME="powerlevel10k\/powerlevel10k"/g' ~/.zshrc
exec zsh
p10k configure
echo 'source ~/.profile' >> .zshrc
