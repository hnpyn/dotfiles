export RUNEWIDTH_EASTASIAN=0
export FZF_DEFAULT_OPTS="--preview 'bash ~/.zsh/fzf/file_preview.sh {}' --layout=reverse --height=48 --color=16"
export FZF_DEFAULT_COMMAND="fd --type f --exclude .git --exclude .idea --exclude .vscode --exclude .sass-cache --exclude node_modules --exclude build --exclude dist --exclude vendor"

typeset -a _fzf_tab_base_flags=(--layout=reverse --height=24 --color=16)

# Disable native zsh completion menu so fzf-tab can capture unambiguous prefixes
zstyle ':completion:*' menu no
zstyle ':completion:*:git-checkout:*' sort false
zstyle ':completion:complete:*:options' sort false
zstyle ':completion:*:descriptions' format "[%d]"
zstyle ':completion:*:*:*:*:processes' command "ps -u $USER -o pid,user,comm -w -w"

zstyle ':fzf-tab:*' fzf-flags "${_fzf_tab_base_flags[@]}"
zstyle ':fzf-tab:*' group-colors $'\033[36m' $'\033[32m' $'\033[33m' $'\033[35m' $'\033[34m' $'\033[31m'
zstyle ':fzf-tab:*' prefix ''
zstyle ':fzf-tab:*' switch-group '<' '>'
zstyle ':fzf-tab:complete:cd:*' query-string input

# Previews
zstyle ':fzf-tab:complete:(__zoxide_z|cd):*' fzf-preview 'ls -A $realpath'
zstyle ':fzf-tab:complete:(kill|ps):argument-rest' fzf-preview '[ "$group" = "process ID" ] && ps -p $word -o args='
zstyle ':fzf-tab:complete:(kill|ps):argument-rest' fzf-flags "${_fzf_tab_base_flags[@]}" --preview-window=down:3:wrap
zstyle ':fzf-tab:complete:*:options' fzf-flags "${_fzf_tab_base_flags[@]}" --preview-window=down:0:wrap
zstyle ':fzf-tab:complete:systemctl-*:*' fzf-preview 'SYSTEMD_COLORS=1 systemctl status $word'
zstyle ':fzf-tab:complete:(\\|)run-help:*' fzf-preview 'run-help $word'
zstyle ':fzf-tab:complete:(\\|*/|)man:*' fzf-preview 'man $word'
zstyle ':fzf-tab:complete:git-(add|diff|restore):*' fzf-preview 'git diff --color=always $word'
zstyle ':fzf-tab:complete:git-log:*' fzf-preview 'git log --color=always $word'
zstyle ':fzf-tab:complete:git-show:*' fzf-preview 'git show --color=always $word'
zstyle ':fzf-tab:complete:git-checkout:*' fzf-preview '[ -f "$realpath" ] && git diff --color=always $word || git log --color=always $word'
zstyle ':fzf-tab:complete:brew-(install|uninstall|search|info):*-argument-rest' fzf-preview 'brew info $word'
zstyle ':fzf-tab:complete:*:*' fzf-preview 'bash ~/.zsh/fzf/file_preview.sh ${(Q)realpath}'
