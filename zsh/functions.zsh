# functions

# local mixed-port proxy (clash / mihomo). override with PROXY_HOST / PROXY_PORT
# e.g. PROXY_PORT=1080 proxyon
proxyon() {
  local host="${PROXY_HOST:-127.0.0.1}"
  local port="${PROXY_PORT:-7897}"
  export all_proxy="socks5://${host}:${port}"
  export http_proxy="http://${host}:${port}"
  export https_proxy="$http_proxy"
  export ALL_PROXY="$all_proxy"
  export HTTP_PROXY="$http_proxy"
  export HTTPS_PROXY="$https_proxy"
  export no_proxy='localhost,127.0.0.1,::1,.local'
  export NO_PROXY="$no_proxy"
}

proxyoff() {
  unset all_proxy http_proxy https_proxy ALL_PROXY HTTP_PROXY HTTPS_PROXY no_proxy NO_PROXY
}

# image picker; clear kitty/sixel layer on exit.
# usage: fzf-img [dir ...]
fzf-img() {
  fd --type f -e png -e jpg -e jpeg -e webp -e gif . "${@:-.}" \
    | command fzf --preview 'sh ~/.zsh/fzf/img_preview.sh {}'
  local ret=$?
  printf '\033_Ga=d,d=a\033\\' > /dev/tty 2>/dev/null
  return $ret
}

ssh_debug() {
  command ssh "$@"
  local ret=$?
  if [ $ret -eq 0 ]; then
    echo "[SSH EXIT NORMAL] $(date '+%F %T')"
  else
    echo "[SSH EXIT ABNORMAL] $(date '+%F %T') code=$ret"
  fi
  return $ret
}
