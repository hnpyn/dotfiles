# zshrc for ubuntu

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

# check
export check_CFLAGS="$HOME/Apps/check=0.14.0/lib:$check_CFLAGS"
export check_LIBS="$HOME/Apps/check=0.14.0/lib:$check_LIBS"

# libffi
export LD_PRELOAD=/usr/lib/x86_64-linux-gnu/libffi.so.7

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

