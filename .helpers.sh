install_font_if_not_available(){
  FONT_NAME="${1}"
  FONT_DOWNLOAD="${2}"
  if ! fc-list | grep -q "${FONT_NAME}"; then 
    download_and_install_font "${FONT_DOWNLOAD}"
  else 
    echo "${FONT_NAME}" already available
  fi
}

download_and_install_font() {
  FONT_DOWNLOAD="${1}"
  curl -LJ -o tmp-font.zip "${FONT_DOWNLOAD}"
  mkdir tmp-font
  unzip -d tmp-font tmp-font.zip
  cp -r tmp-font/* ~/.local/share/fonts/user-configured/
}

