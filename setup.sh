source .helpers.sh

# Install required binaries available in apt
sudo apt install i3 polybar feh brightnessctl picom kitty neovim


if man i3lock | grep -q i3lock-color; then
  echo "i3lock-color already installed"
else
  # Install packages required to build i3lock-color
  sudo apt install autoconf gcc make pkg-config libpam0g-dev libcairo2-dev libfontconfig1-dev libxcb-composite0-dev libev-dev libx11-xcb-dev libxcb-xkb-dev libxcb-xinerama0-dev libxcb-randr0-dev libxcb-image0-dev libxcb-util0-dev libxcb-xrm-dev libxkbcommon-dev libxkbcommon-x11-dev libjpeg-dev

  # Build & install i3lock-color
  git clone https://github.com/Raymo111/i3lock-color.git /tmp/i3lock-color
  cd /tmp/i3lock-color
  ./install-i3lock-color.sh
  cd -
  rm -rf /tmp/i3lock-color
fi

# Install required fonts
mkdir -p ~/.local/share/fonts/user-configured/
NERD_FONT_DL="https://github.com/ryanoasis/nerd-fonts/releases/download/v3.1.1/NerdFontsSymbolsOnly.zip"
NOTO_EMOJI_DL="https://github.com/googlefonts/noto-emoji/releases/downloads/v2.042/v2.042.zip"

install_font_if_not_available "Symbols Nerd Font Mono" "${NERD_FONT_DL}" 
install_font_if_not_available "Noto Emoji" "${NOTO_EMOJI_DL}" 

SOURCE_STRING="source ~/code/dot-files/.bashrc"
if grep -q "${SOURCE_STRING}" ~/.bashrc; then
  echo "~/.bashrc already configured"
else 
  echo "${SOURCE_STRING}" >> ~/.bashrc
fi

echo "Copying config files to correct location"
set -o xtrace
mkdir -p ~/.config/i3 ~/.config/i3lock-color ~/.config/picom ~/.config/polybar 
cp .config/i3/config ~/.config/i3/config
cp .config/i3lock-color/lock.sh ~/.config/i3lock-color/lock.sh
cp .config/picom/picom.conf ~/.config/picom/picom.conf
cp .config/polybar/config.ini ~/.config/polybar/config.ini
cp .config/polybar/launch.sh ~/.config/polybar/launch.sh
set +o xtrace
