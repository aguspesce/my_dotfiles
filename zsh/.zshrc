# =================
# zsh configuration
# =================

# Use powerline
USE_POWERLINE="true"
# Source manjaro-zsh-configuration
if [[ -e /usr/share/zsh/manjaro-zsh-config ]]; then
  source /usr/share/zsh/manjaro-zsh-config
fi
# Use manjaro zsh prompt
if [[ -e /usr/share/zsh/manjaro-zsh-prompt ]]; then
  source /usr/share/zsh/manjaro-zsh-prompt
fi


# --------------
# Load functions
# --------------
if [[ -r ~/.zsh/functions.zsh ]]; then
    source ~/.zsh/functions.zsh
fi


# -------
# Aliases
# -------
alias cp="cp -i"
alias mv="mv -i"
alias ls="ls --group-directories-first --color=auto"
alias ll="ls -lh --group-directories-first --color=auto"
alias la="ls -lah --group-directories-first --color=auto"
alias grep='grep --colour=auto'
alias du="du -h -d 0"

alias monitor-mic='pactl load-module module-loopback latency_msec=1'
alias monitor-stop='pactl unload-module module-loopback'

# Mamba aliases
alias ca='mamba activate'

# Jupyter aliases
alias jn="jupyter-notebook"
alias jl="jupyter-lab"

# Git aliases
alias gti="git"
alias gi="git"
alias gts="git status"

# ssh aliases
alias idecom="ssh agustina@pesce.unsj.edu.ar"  # ssh to IDECOM
alias remotelab="ssh -N -L localhost:9999:localhost:8888 agustina@pesce.unsj.edu.ar"  # Create an SSH "local port forward" to IDECOM

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'


# -----------------------
# Add directories to PATH
# -----------------------
export PATH="$PATH:$(ruby -e 'print Gem.user_dir' 2> /dev/null)/bin"

#
# ------------
# Set up mamba
# ------------
if [[ -d $HOME/.mambaforge ]]; then
    export MAMBA_PATH=$HOME/.mambaforge
fi

# Setup and activate the conda and mamaba package managerers
if [ -f $MAMBA_PATH/etc/profile.d/conda.sh ]; then
    source "$MAMBA_PATH/etc/profile.d/conda.sh"
    conda activate
fi
if [ -f "$MAMBA_PATH/etc/profile.d/mamba.sh" ]; then
    . "$MAMBA_PATH/etc/profile.d/mamba.sh"
fi

# Activate the conda default environment
if command -v conda &> /dev/null; then
  if [ -f $HOME/environment.yml ]; then
      cenv $HOME/environment.yml
  fi
fi
