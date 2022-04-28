# ==================
# Bash configuration
# ==================

# -------------
# Load builtins
# -------------
complete -cf sudo
shopt -s expand_aliases
shopt -s histappend  # enable history appending instead of overwriting

# Bash won't get SIGWINCH if another process is in the foreground.
# Enable checkwinsize so that bash will check the terminal size when
# it regains control.  #65623
# http://cnswww.cns.cwru.edu/~chet/bash/FAQ (E11)
shopt -s checkwinsize


# --------------------
# Load bash-completion
# --------------------
if [ -f /usr/share/bash-completion/bash_completion ]; then
    source /usr/share/bash-completion/bash_completion
fi


# -----------------------
# Add directories to PATH
# -----------------------
export PATH=$HOME/bin/:$PATH
export PATH="$PATH:$(ruby -e 'print Gem.user_dir' 2> /dev/null)/bin"
export PATH="/home/agustina/.gem/ruby/3.0.0/bin:$PATH"


# -------
# Aliases
# -------
alias cp="cp -i"
alias ls="ls --group-directories-first --color=auto"
alias ll="ls -lh --group-directories-first --color=auto"
alias la="ls -lah --group-directories-first --color=auto"
alias grep='grep --colour=auto'
alias egrep='egrep --colour=auto'
alias fgrep='fgrep --colour=auto'
alias du="du -h -d 0"
alias open='xdg-open'
alias xc='xclip -selection clipboard' # copy to clipboard using xclip
# Conda aliases
alias ca='conda activate'
# Jupyter aliases
alias jn="jupyter-notebook"
alias jl="jupyter-lab"
# Git aliases
alias gti="git"
alias gi="git"
alias gts="git status"
alias cdtop='cd $(git rev-parse --show-toplevel)' # cd to toplevel of git repo
# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'
# ssh aliases
alias idecom="ssh agustina@pesce.unsj.edu.ar"  # ssh to IDECOM
alias remotelab="ssh -N -L localhost:9999:localhost:8888 agustina@pesce.unsj.edu.ar"  # Create an SSH "local port forward" to IDECOM


# ------
# Colors
# ------
# Load dircolors
if type -P dircolors >/dev/null ; then
    if [[ -f ~/.dir_colors ]] ; then
        eval $(dircolors -b ~/.dir_colors)
    elif [[ -f /etc/DIR_COLORS ]] ; then
        eval $(dircolors -b /etc/DIR_COLORS)
    fi
fi

# Color man pages
export LESS_TERMCAP_mb=$'\E[01;32m'
export LESS_TERMCAP_md=$'\E[01;32m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_se=$'\E[0m'
export LESS_TERMCAP_so=$'\E[01;30;44m'
export LESS_TERMCAP_ue=$'\E[01;0m'
export LESS_TERMCAP_us=$'\E[01;36m'


# ----------------------
# Make the prompt pretty
# ----------------------
if [ -f ~/.bash/prompt.sh ]; then
    source ~/.bash/prompt.sh
fi


# --------------------------
# Load some useful functions
# --------------------------
if [ -f ~/.bash/functions.sh ]; then
    source ~/.bash/functions.sh
fi


# --------------------
# Initialize ssh agent
# --------------------
if [ -f ~/.ssh/agent.env ] ; then
    . ~/.ssh/agent.env > /dev/null
    if ! kill -0 $SSH_AGENT_PID > /dev/null 2>&1; then
        eval `ssh-agent | tee ~/.ssh/agent.env`
    fi
else
    eval `ssh-agent | tee ~/.ssh/agent.env`
fi


# ----------------
# Initialize conda
# ----------------

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/agustina/mambaforge/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/agustina/mambaforge/etc/profile.d/conda.sh" ]; then
        . "/home/agustina/mambaforge/etc/profile.d/conda.sh"
    else
        export PATH="/home/agustina/mambaforge/bin:$PATH"
    fi
fi
unset __conda_setup

if [ -f "/home/agustina/mambaforge/etc/profile.d/mamba.sh" ]; then
    . "/home/agustina/mambaforge/etc/profile.d/mamba.sh"
fi
# <<< conda initialize <<<

# Activate the conda default environment
if [ -f $HOME/environment.yml ]; then
    cenv $HOME/environment.yml
fi