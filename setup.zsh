#!/usr/bin/env zsh

set -euxo pipefail

echo "configuring shell profile..." 
touch .zshrc
echo 'source ~/.profile' >> .zshrc
touch .profile

echo "installing build-essentials..."
xcode-select --install

echo "installing homebrew..."
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> .profile
source .zshrc

echo "installing rosetta..."
softwareupdate --install-rosetta --agree-to-license

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
brew install caddy gum
# moderm cli utils
brew install bat eza fzf jq ripgrep zoxide difftastic fd
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
# git config --global user.signingkey "..."
git config --global credential.helper store
git config --global init.defaultbranch main
# git config --global commit.gpgsign true
git config --global core.autocrlf true
git config --global core.pager delta
git config --global pull.ff true
git config --global push.autoSetupRemote true
git config --global help.autocorrect prompt
git config --global log.date iso
# configure git
git lfs install
git config --global merge.conflictstyle zdiff3
git config --global diff.algorithm histogram
git config --global diff.colormoved default
git config --global interactive.difffilter "delta --color-only"
git config --global delta.navigate true
git config --global delta.light false
git config --global delta.side-by-side true
# configure gh cli
gh config set editor nvim

echo "installing node..."
brew install volta
echo 'export VOLTA_FEATURE_PNPM=1' >> .profile
source .zshrc
volta setup
source .zshrc
volta install node
volta install pnpm
volta install yarn

echo "configuring packages..."
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

# https://macos-defaults.com/
echo "changing macos defaults..."
# declutter dock, move it to the left with smaller icons.
defaults write com.apple.dock "persistent-apps" -array
defaults write com.apple.dock "orientation" -string "left"
defaults write com.apple.dock "tilesize" -int "32"
defaults write com.apple.dock "autohide" -bool "false"
defaults write com.apple.dock "show-recents" -bool "false"
defaults write com.apple.dock "mineffect" -string "scale"
# trackpad
defaults write com.apple.AppleMultitouchTrackpad "FirstClickThreshold" -int "0"
# mission control
defaults write com.apple.dock "mru-spaces" -bool "false"
defaults write com.apple.dock "expose-group-apps" -bool "true"
defaults write NSGlobalDomain "AppleSpacesSwitchOnActivate" -bool "true"
# finder
defaults write com.apple.finder "ShowPathbar" -bool "true"
# keyboard
# # disable input method for character accents
defaults write NSGlobalDomain "ApplePressAndHoldEnabled" -bool "false"
# no ds store on network and external drives
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true
defaults write com.apple.desktopservices DSDontWriteRemovableMedia -bool true
defaults write com.apple.desktopservices DSDontWriteExternalStores -bool true
# restart processes
killall Dock Finder
echo "Please restart you machine :("





