# =============================================================
# Lightweight Native Zsh Vi Mode
# =============================================================
# Must be sourced BEFORE `starship init zsh` so starship wraps
# `zle-keymap-select` cleanly (cursor shape + prompt symbol).

# =========================== Config ==========================
export KEYTIMEOUT=1                     # 10ms Esc timeout (default 400ms)

typeset -g _VI_VISUAL_STYLE='bg=8,fg=15'
typeset -g _VI_YANK_STYLE='fg=0,bg=214' # Warm amber yellow (256-color)
typeset -g _VI_YANK_DURATION=0.15       # Seconds to flash on yank

typeset -g _VI_CURSOR_BLOCK='\e[2 q'
typeset -g _VI_CURSOR_UNDERLINE='\e[4 q'
typeset -g _VI_CURSOR_BEAM='\e[6 q'

# =========================== Keymaps =========================
bindkey -v

# Allow Backspace and Ctrl-W to delete past the insert entry point
bindkey -M viins '^?' backward-delete-char
bindkey -M viins '^H' backward-delete-char
bindkey -M viins '^W' backward-kill-word

# Keep Ctrl-R as redo in normal mode (insert mode uses fzf-history-widget)
bindkey -M vicmd '^R' redo

# Built-in text objects: ci" / di( / ca{ / yi' ...
autoload -Uz select-bracketed select-quoted
zle -N select-quoted
zle -N select-bracketed
for _vi_km in viopp visual; do
  bindkey -M "$_vi_km" -- '-' vi-up-line-or-history
  for _vi_c in {a,i}${(s..)^:-\'\"\`\|,./:;=+@}; do
    bindkey -M "$_vi_km" "$_vi_c" select-quoted
  done
  for _vi_c in {a,i}${(s..)^:-'()[]{}<>bB'}; do
    bindkey -M "$_vi_km" "$_vi_c" select-bracketed
  done
done
unset _vi_km _vi_c

# Edit current command line in $EDITOR (preserves `v` for visual-mode)
autoload -Uz edit-command-line
zle -N edit-command-line
bindkey -M viins '^X^E' edit-command-line
bindkey -M vicmd '^X^E' edit-command-line

# ======================= Cursor & Visual =====================
_vi_cursor_shape() {
  if [[ $KEYMAP == vicmd ]]; then
    builtin printf "$_VI_CURSOR_BLOCK"
  elif [[ $ZLE_STATE == *overwrite* ]]; then
    builtin printf "$_VI_CURSOR_UNDERLINE"
  else
    builtin printf "$_VI_CURSOR_BEAM"
  fi
}

_vi_line_init() {
  builtin printf "$_VI_CURSOR_BEAM"
}

_vi_preexec() {
  _vi_yank_hl_cancel
  builtin printf "$_VI_CURSOR_BLOCK"
}

zle -N zle-keymap-select _vi_cursor_shape
zle -N zle-line-init _vi_line_init

autoload -Uz add-zsh-hook
add-zsh-hook preexec _vi_preexec

# Visual selection highlight (deduplicated for safe reloads)
typeset -aU zle_highlight
zle_highlight+=("region:${_VI_VISUAL_STYLE}")

# ========================== Clipboard ========================
_vi_copy_to_clipboard() {
  emulate -L zsh
  setopt nomonitor nonotify
  local text=$1
  [[ -n $text ]] || return 0

  # Local session: prefer native clipboard tools (async, silent)
  if [[ -z $SSH_CONNECTION && -z $SSH_TTY ]]; then
    if (( $+commands[pbcopy] )); then
      ( print -rn -- "$text" | pbcopy ) >/dev/null 2>&1 &!
      return 0
    elif [[ -n $WAYLAND_DISPLAY ]] && (( $+commands[wl-copy] )); then
      ( print -rn -- "$text" | wl-copy ) >/dev/null 2>&1 &!
      return 0
    elif [[ -n $DISPLAY ]]; then
      if (( $+commands[xclip] )); then
        ( print -rn -- "$text" | xclip -selection clipboard ) >/dev/null 2>&1 &!
        return 0
      elif (( $+commands[xsel] )); then
        ( print -rn -- "$text" | xsel -ib ) >/dev/null 2>&1 &!
        return 0
      fi
    fi
  fi

  # Remote / headless fallback: OSC 52
  if (( $+commands[base64] )) && [[ -w /dev/tty ]]; then
    local b64
    b64=$(print -rn -- "$text" | base64 | tr -d '\r\n')
    builtin printf '\e]52;c;%s\a' "$b64" > /dev/tty
  fi
}

# ======================= Yank Highlight ======================
typeset -g _vi_yank_hl_fd=""

_vi_yank_hl_cancel() {
  [[ -n $_vi_yank_hl_fd ]] || return 0
  zle -F "$_vi_yank_hl_fd" 2>/dev/null
  exec {_vi_yank_hl_fd}<&- 2>/dev/null
  _vi_yank_hl_fd=""
}

_vi_yank_hl_clear() {
  region_highlight=(${region_highlight:#*memo=vi-yank})
  zle -R
}
zle -N _vi_yank_hl_clear

_vi_yank_hl_timeout() {
  _vi_yank_hl_cancel
  zle && zle _vi_yank_hl_clear
}

_vi_yank() {
  local had_region=$REGION_ACTIVE m=$MARK c=$CURSOR s e
  zle ".$WIDGET" "$@"
  _vi_copy_to_clipboard "$CUTBUFFER"

  if [[ $WIDGET == vi-yank && $had_region == 1 ]]; then
    (( s = m < c ? m : c, e = (m < c ? c : m) + 1 ))
  elif [[ $WIDGET == vi-yank && $had_region == 2 ]]; then
    local lo=$(( m < c ? m : c )) hi=$(( m < c ? c : m ))
    s=$(( lo - ${#${${BUFFER[1,$lo]}##*$'\n'}} ))
    e=$(( hi + ${#${${BUFFER[$((hi+1)),-1]}%%$'\n'*}} ))
  elif [[ $WIDGET == vi-yank-eol ]]; then
    s=$CURSOR
    e=$(( CURSOR + ${#${${BUFFER[$((CURSOR+1)),-1]}%%$'\n'*}} ))
  elif [[ $WIDGET == vi-yank && -n $CUTBUFFER && ${BUFFER:$CURSOR:${#CUTBUFFER}} == "$CUTBUFFER" ]]; then
    s=$CURSOR; e=$(( CURSOR + ${#CUTBUFFER} ))
  else
    s=$(( CURSOR - ${#${${BUFFER[1,$CURSOR]}##*$'\n'}} ))
    e=$(( CURSOR + ${#${${BUFFER[$((CURSOR+1)),-1]}%%$'\n'*}} ))
  fi

  (( e > s )) || return 0
  _vi_yank_hl_cancel
  region_highlight=(${region_highlight:#*memo=vi-yank} "$s $e ${_VI_YANK_STYLE} memo=vi-yank")
  zle -R
  exec {_vi_yank_hl_fd}< <(sleep "$_VI_YANK_DURATION"; print x)
  zle -F "$_vi_yank_hl_fd" _vi_yank_hl_timeout
}

# Register on first precmd so yank widgets sit outside fast-syntax-highlighting
_vi_register_yank() {
  local w
  for w in vi-yank vi-yank-whole-line vi-yank-eol; do zle -N "$w" _vi_yank; done
  add-zsh-hook -d precmd _vi_register_yank
}
add-zsh-hook precmd _vi_register_yank
