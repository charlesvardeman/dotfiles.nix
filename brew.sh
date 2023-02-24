#!/usr/bin/env bash

# Rosetta needed by quarto
sudo softwareupdate --install-rosetta

# Stuff not available in nix
brew install jena
brew install docker

# Casks
brew install --cask --appdir="/Applications"  google-chrome
brew install --cask --appdir="/Applications"  visual-studio-code
brew install --cask --appdir="/Applications"  iterm2
brew install --cask --appdir="/Applications"  slack
brew install --cask --appdir="/Applications"  zoom
brew install --cask --appdir="/Applications"  quarto
brew install --cask --appdir="/Applications"  remarkable
brew install --cask --appdir="/Applications"  todoist
brew install --cask --appdir="/Applications"  evernote
brew install --cask --appdir="/Applications"  latexit
brew install --cask --appdir="/Applications"  google-drive
brew install --cask --appdir="/Applications"  protege
brew install --cask --appdir="/Applications"  bibdesk

# Fonts
brew tap homebrew/cask-fonts
brew install --cask font-fira-code
brew install --cask font-cascadia-code
brew install --cask font-iosevka-nerd-font

# Install my casks
brew tap charlesvardeman/homebrew-taps
brew install widoco
