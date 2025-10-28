export RUNEWIDTH_EASTASIAN=0
# export FZF_PREVIEW_COMMAND='bash /home/charles/.zsh/file_preview.sh {}'
# export FZF_DEFAULT_OPTS="--height 12 --layout=reverse --history=/home/charles/.zsh/cache/fzfhistory"
export FZF_DEFAULT_OPTS="--preview 'bash ~/.zsh/fzf/file_preview.sh {}' --layout=reverse --height=48 --color=16" # \
  # --color=fg:#908caa,bg:#191724,hl:#ebbcba \
  # --color=fg+:#e0def4,bg+:#26233a,hl+:#ebbcba \
  # --color=border:#403d52,header:#31748f,gutter:#191724 \
  # --color=spinner:#f6c177,info:#9ccfd8 \
  # --color=pointer:#c4a7e7,marker:#eb6f92,prompt:#908caa"
export FZF_DEFAULT_COMMAND="fd --exclude={.git,.idea,.vscode,.sass-cache,node_modules,build,dist,vendor} --type f"

zstyle ':fzf-tab:*' use-fzf-default-opts yes
zstyle ':completion:complete:*:options' sort false
zstyle ':fzf-tab:complete:cd:*' query-string input
zstyle ':completion:*:descriptions' format "[%d]"
zstyle ':fzf-tab:*' group-colors $'\033[15m' $'\033[14m' $'\033[33m' $'\033[35m' $'\033[15m' $'\033[14m' $'\033[33m' $'\033[35m'
zstyle ':fzf-tab:*' prefix ''
zstyle ':completion:*:*:*:*:processes' command "ps -u $USER -o pid,user,comm -w -w"
zstyle ':fzf-tab:complete:(kill|ps):argument-rest' fzf-preview '[ "$group" = "process ID" ] && ps --pid=$word -o cmd --no-headers -w -w'
zstyle ':fzf-tab:complete:(kill|ps):argument-rest' fzf-flags --preview-window=down:3:wrap
zstyle ':fzf-tab:complete:*:options' fzf-flags --preview-window=down:0:wrap
zstyle ':fzf-tab:complete:systemctl-*:*' fzf-preview 'SYSTEMD_COLORS=1 systemctl status $word'
zstyle ':fzf-tab:complete:(\\|)run-help:*' fzf-preview 'run-help $word'
zstyle ':fzf-tab:complete:(\\|*/|)man:*' fzf-preview 'man $word'
zstyle ':fzf-tab:complete:git-(add|diff|restore):*' fzf-preview 'git diff --color=always $word'
zstyle ':fzf-tab:complete:git-log:*' fzf-preview 'git log --color=always $word'
zstyle ':fzf-tab:complete:git-show:*' fzf-preview 'git show --color=always $word'
zstyle ':fzf-tab:complete:git-checkout:*' fzf-preview '[ -f "$realpath" ] && git diff --color=always $word || git log --color=always $word'
zstyle ':fzf-tab:complete:*:*' fzf-preview 'bash ~/.zsh/fzf/file_preview.sh ${(Q)realpath}'
zstyle ':fzf-tab:complete:*:*' fzf-flags --height=24
zstyle ':fzf-tab:complete:brew-(install|uninstall|search|info):*-argument-rest' fzf-preview 'brew info $word'
