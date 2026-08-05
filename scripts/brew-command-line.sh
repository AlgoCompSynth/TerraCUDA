#! /usr/bin/env -S bash -l

set -eu

echo "..Installing brew packages"
brew install --yes --quiet \
  cmake \
  fennel \
  lua \
  luajit \
  make \
  neovim \
  starship \
  tree \
  tmux

echo "..Setting configuration files"
mkdir --parents $HOME/.config
cp -rp starship.toml nvim tmux $HOME/.config

if [[ "$(grep starship $HOME/.bashrc | wc -l)" == 0 ]]
then
  echo "..Appending starship init to $HOME/.bashrc"
  cat aliases.sh >> $HOME/.bashrc
  echo 'eval "$(starship init bash)"' >> $HOME/.bashrc

fi

if [[ -f $HOME/.zshrc && "$(grep starship $HOME/.zshrc | wc -l)" == 0 ]]
then
  echo "..Appending starship init to $HOME/.zshrc"
  cat aliases.sh >> $HOME/.zshrc
  echo 'eval "$(starship init zsh)"' >> $HOME/.zshrc

fi

echo "..Installing many nerd fonts!"
brew install --yes --quiet \
  font-0xproto-nerd-font \
  font-3270-nerd-font \
  font-adwaita-mono-nerd-font \
  font-agave-nerd-font \
  font-annotationmono-nerd-font \
  font-anonymice-nerd-font \
  font-arimo-nerd-font \
  font-atkynson-mono-nerd-font \
  font-aurulent-sans-mono-nerd-font \
  font-bigblue-terminal-nerd-font \
  font-bitstream-vera-sans-mono-nerd-font \
  font-blex-mono-nerd-font \
  font-caskaydia-cove-nerd-font \
  font-caskaydia-mono-nerd-font \
  font-code-new-roman-nerd-font \
  font-comic-shanns-mono-nerd-font \
  font-commit-mono-nerd-font \
  font-cousine-nerd-font \
  font-d2coding-nerd-font \
  font-daddy-time-mono-nerd-font \
  font-dejavu-sans-mono-nerd-font \
  font-departure-mono-nerd-font \
  font-droid-sans-mono-nerd-font \
  font-envy-code-r-nerd-font \
  font-fantasque-sans-mono-nerd-font \
  font-fira-code-nerd-font \
  font-fira-mono-nerd-font \
  font-firgenerd \
  font-geist-mono-nerd-font \
  font-go-mono-nerd-font \
  font-gohufont-nerd-font \
  font-googlesanscode-nerd-font \
  font-hack-nerd-font \
  font-hackgen-nerd \
  font-hasklug-nerd-font \
  font-heavy-data-nerd-font \
  font-hurmit-nerd-font \
  font-im-writing-nerd-font \
  font-inconsolata-go-nerd-font \
  font-inconsolata-lgc-nerd-font \
  font-inconsolata-nerd-font \
  font-intone-mono-nerd-font \
  font-iosevka-nerd-font \
  font-iosevka-term-nerd-font \
  font-iosevka-term-slab-nerd-font \
  font-jetbrains-mono-nerd-font \
  font-lekton-nerd-font \
  font-liberation-nerd-font \
  font-lilex-nerd-font \
  font-m+-nerd-font \
  font-martian-mono-nerd-font \
  font-meslo-lg-nerd-font \
  font-monaspice-nerd-font \
  font-monocraft-nerd-font \
  font-monofur-nerd-font \
  font-monoid-nerd-font \
  font-mononoki-nerd-font \
  font-noto-nerd-font \
  font-opendyslexic-nerd-font \
  font-overpass-nerd-font \
  font-profont-nerd-font \
  font-proggy-clean-tt-nerd-font \
  font-recursive-mono-nerd-font \
  font-roboto-mono-nerd-font \
  font-sauce-code-pro-nerd-font \
  font-sf-mono-nerd-font-ligaturized \
  font-shure-tech-mono-nerd-font \
  font-space-mono-nerd-font \
  font-symbols-only-nerd-font \
  font-terminess-ttf-nerd-font \
  font-tinos-nerd-font \
  font-ubuntu-mono-nerd-font \
  font-ubuntu-nerd-font \
  font-ubuntu-sans-nerd-font \
  font-victor-mono-nerd-font \
  font-zed-mono-nerd-font \
  || true

echo "..Cleaning up"
brew cleanup --prune all --scrub --verbose
