source .helpers.sh

# Install required binaries available in apt
sudo apt install i3 polybar feh brightnessctl picom kitty neovim maim rofi ffmpeg

if ! i3lock --version 2>&1 | grep --quiet Raymond; then
  # Install packages required to build i3lock-color
  sudo apt install autoconf gcc make pkg-config libpam0g-dev libcairo2-dev libfontconfig1-dev libxcb-composite0-dev libev-dev libx11-xcb-dev libxcb-xkb-dev libxcb-xinerama0-dev libxcb-randr0-dev libxcb-image0-dev libxcb-util0-dev libxcb-xrm-dev libxkbcommon-dev libxkbcommon-x11-dev libjpeg-dev

  # Build & install i3lock-color
  TMPDIR=$(mktemp --dry-run)
  git clone https://github.com/Raymo111/i3lock-color.git "${TMPDIR}"
  cd "${TMPDIR}"
  ./install-i3lock-color.sh
  cd -
  rm -rf "${TMPDIR}"
fi

if ! command -v hellwal; then
  TMPDIR=$(mktemp --dry-run)
  git clone https://github.com/danihek/hellwal "${TMPDIR}"
  cd "${TMPDIR}"
  make && sudo mv ${TMPDIR}/hellwal /usr/local/bin/hellwal
  cd -
  rm -rf "${TMPDIR}"
fi

# Install required fonts
mkdir -p ~/.local/share/fonts/user-configured/
NERD_FONT_DL="https://github.com/ryanoasis/nerd-fonts/releases/download/v3.1.1/NerdFontsSymbolsOnly.zip"
NOTO_EMOJI_DL="https://github.com/googlefonts/noto-emoji/releases/downloads/v2.042/v2.042.zip"

install_font_if_not_available "Symbols Nerd Font Mono" "${NERD_FONT_DL}" "${reinstall_dependencies}" 
install_font_if_not_available "Noto Emoji" "${NOTO_EMOJI_DL}" "${reinstall_dependencies}"

if ! command -v rofi-wifi-menu; then
  TMPDIR=$(mktemp --dry-run)
  git clone https://github.com/ericmurphyxyz/rofi-wifi-menu.git "${TMPDIR}"
  sudo mv "${TMPDIR}"/rofi-wifi-menu.sh /usr/local/bin/rofi-wifi-menu
  rm -rf "${TMPDIR}"
fi


SOURCE_STRING="source ~/code/dot-files/.bashrc"
if grep -q "${SOURCE_STRING}" ~/.bashrc; then
  echo "~/.bashrc already configured"
else 
  echo "${SOURCE_STRING}" >> ~/.bashrc
fi

echo "Copying config files to correct location"
set -o xtrace
mkdir -p ~/.config/i3 ~/.config/i3lock-color ~/.config/picom ~/.config/polybar ~/.config/hellwal ~/.config/rofi
cp -r .config/hellwal/* ~/.config/hellwal
cp -r .config/i3/* ~/.config/i3
cp -r .config/i3lock-color/* ~/.config/i3lock-color
cp -r .config/picom/* ~/.config/picom
cp -r .config/polybar/* ~/.config/polybar
set +o xtrace
