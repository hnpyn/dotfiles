# zshrc for macos

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$("$HOME/Apps/miniconda3/bin/conda" 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "$HOME/Apps/miniconda3/etc/profile.d/conda.sh" ]; then
        . "$HOME/Apps/miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="$HOME/Apps/miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

# environment variable
export PATH=$HOME/bin:/usr/local/bin:$PATH 

# homebrew
export PATH="/opt/homebrew/bin:$PATH"
export PATH="/opt/homebrew/sbin:$PATH"

# wezterm
export PATH="/Applications/WezTerm.app/Contents/MacOS:$PATH"

# kitty
export PATH="/Applications/kitty.app/Contents/MacOS:$PATH"
