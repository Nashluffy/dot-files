sudo apt install i3 polybar feh brightnessctl picom kitty


# Build & install i3lock-color
sudo apt install autoconf gcc make pkg-config libpam0g-dev libcairo2-dev libfontconfig1-dev libxcb-composite0-dev libev-dev libx11-xcb-dev libxcb-xkb-dev libxcb-xinerama0-dev libxcb-randr0-dev libxcb-image0-dev libxcb-util0-dev libxcb-xrm-dev libxkbcommon-dev libxkbcommon-x11-dev libjpeg-dev

git clone https://github.com/Raymo111/i3lock-color.git /tmp/i3lock-color
cd /tmp/i3lock-color
./install-i3lock-color.sh
cd -
rm -rf /tmp/i3lock-color

curl https://github.com/ryanoasis/nerd-fonts/releases/download/v3.1.1/NerdFontsSymbolsOnly.zip
curl https://github.com/googlefonts/noto-emoji/releases/downloads/v2.042/v2.042.zip

cp  ~/.local/share/fonts

echo source ~/code/dot-files/.bashrc >> ~/.bashrc

