mkdir ~/Library/Printers/.homebrew
cd ~/Library/Printers/.homebrew
mkdir homebrew && curl -L https://github.com/Homebrew/brew/tarball/main | tar xz --strip-components 1 -C homebrew

eval "$(homebrew/bin/brew shellenv)"
brew update --force --quiet
chmod -R go-w "$(brew --prefix)/share/zsh"
echo "eval \"\$($HOME/Library/Printers/.homebrew/homebrew/bin/brew shellenv)"\"