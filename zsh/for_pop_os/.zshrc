## zsh configuration
# =================

## Prompt: Powerlevel10k
## ---------------------

if [[ ! -e ~/.powerlevel10k/powerlevel9k.zsh-theme ]]; then
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/.powerlevel10k
fi
source ~/.powerlevel10k/powerlevel10k.zsh-theme

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Use powerline
USE_POWERLINE="true"


## Options section
## ---------------
setopt correct            # Auto correct mistakes
setopt extendedglob       # Extended globbing. Allows using regular expressions with *
setopt nocaseglob         # Case insensitive globbing
setopt rcexpandparam      # Array expension with parameters
setopt nocheckjobs        # Don't warn about running processes when exiting
setopt numericglobsort    # Sort filenames numerically when it makes sense
setopt nobeep             # No beep
setopt appendhistory      # Immediately append history instead of overwriting
setopt histignorealldups  # If a new command is a duplicate, remove the older one
setopt autocd             # if only directory path is entered, cd there.
setopt inc_append_history # save commands are added to the history immediately, otherwise only when shell exits.
setopt histignorespace    # Don't save commands that start with space

HISTFILE=~/.zhistory
HISTSIZE=10000
SAVEHIST=10000
WORDCHARS=${WORDCHARS//\/[&.;]} # Don't consider certain characters part of the word


## Auto completion
## ---------------
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' # Case insensitive tab completion
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"   # Colored completion (different colors for dirs/files/etc)
zstyle ':completion:*' rehash true                        # automatically find new executables in path
# Speed up completions
zstyle ':completion:*' accept-exact '*(N)'
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path ~/.zsh/cache


## Keybindings
## -----------
bindkey -e                                         # Use emacs keybindings
bindkey '^[[7~' beginning-of-line                  # Home key
bindkey '^[[H' beginning-of-line                   # Home key
if [[ "${terminfo[khome]}" != "" ]]; then
  bindkey "${terminfo[khome]}" beginning-of-line   # [Home] - Go to beginning of line
fi
bindkey '^[[8~' end-of-line                        # End key
bindkey '^[[F' end-of-line                         # End key
if [[ "${terminfo[kend]}" != "" ]]; then
  bindkey "${terminfo[kend]}" end-of-line          # [End] - Go to end of line
fi
bindkey '^[[2~' overwrite-mode                     # Insert key
bindkey '^[[3~' delete-char                        # Delete key
bindkey '^[[C'  forward-char                       # Right key
bindkey '^[[D'  backward-char                      # Left key
bindkey '^[[5~' history-beginning-search-backward  # Page up key
bindkey '^[[6~' history-beginning-search-forward   # Page down key

# Navigate words with ctrl+arrow keys
bindkey '^[Oc' forward-word                        #
bindkey '^[Od' backward-word                       #
bindkey '^[[1;5D' backward-word                    #
bindkey '^[[1;5C' forward-word                     #
bindkey '^H' backward-kill-word                    # delete previous word with ctrl+backspace
bindkey '^[[Z' undo                                # Shift+tab undo last action


## Load functions
## --------------
if [[ -r ~/.zsh/functions.zsh ]]; then
    source ~/.zsh/functions.zsh
fi


## Aliases
## -------
alias df='f(){if test $# -eq 0;then opts=(-h);else opts=("$@");fi; df "$opts[@]"};f'      # Human-readable sizes
alias free='f(){if test $# -eq 0;then opts=(-m);else opts=("$@");fi; free "$opts[@]"};f'  # Show sizes in MB
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
# Create an SSH "local port forward" to IDECOM
alias remotelab="ssh -N -L localhost:9999:localhost:8888 agustina@pesce.unsj.edu.ar"
# Add an "alert" alias for long running commands.
# Use like so: sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'


## Colors
## ------
# Theming section
autoload -U compinit colors zcalc
compinit -d
colors

# Color man pages
export LESS_TERMCAP_mb=$'\E[01;32m'
export LESS_TERMCAP_md=$'\E[01;32m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_se=$'\E[0m'
export LESS_TERMCAP_so=$'\E[01;47;34m'
export LESS_TERMCAP_ue=$'\E[0m'
export LESS_TERMCAP_us=$'\E[01;36m'
export LESS=-R


## Plugins section
## ---------------
plugins="$HOME/.zsh/plugins/"

# Use syntax highlighting
if [[ -r ${plugins}/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]]; then
    source ${plugins}/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
fi

# Use history substring search
if [[ -r ${plugins}/zsh-history-substring-search/zsh-history-substring-search.zsh ]]; then
    source ${plugins}/zsh-history-substring-search/zsh-history-substring-search.zsh
    # bind UP and DOWN arrow keys to history substring search
    zmodload zsh/terminfo
    bindkey "$terminfo[kcuu1]" history-substring-search-up
    bindkey "$terminfo[kcud1]" history-substring-search-down
    bindkey '^[[A' history-substring-search-up
    bindkey '^[[B' history-substring-search-down
fi

# Autosuggestions
if [[ -r ${plugins}/zsh-autosuggestions/zsh-autosuggestions.zsh ]]; then
    source ${plugins}/zsh-autosuggestions/zsh-autosuggestions.zsh
fi


## Add directories to PATH
## -----------------------
export PATH="$PATH:$(ruby -e 'print Gem.user_dir' 2> /dev/null)/bin"

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME//.bin" ] ; then
    PATH="$HOME/.bin:$PATH"
fi


## Set up mamba
## ------------
if [[ -d $HOME/.mambaforge ]]; then
    export MAMBA_PATH=$HOME/.mambaforge
fi

# Setup and activate the conda and mamba package managers
__conda_setup="$('${MAMBA_PATH}/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "$MAMBA_PATH/etc/profile.d/conda.sh" ]; then
        . "$MAMBA_PATH/etc/profile.d/conda.sh"
    else
        export PATH="$MAMBA_PATH/bin:$PATH"
    fi
fi
unset __conda_setup

if [ -f "$MAMBA_PATH/etc/profile.d/mamba.sh" ]; then
    . "$MAMBA_PATH/etc/profile.d/mamba.sh"
fi

# Activate the conda default environment
if command -v conda &> /dev/null; then
  if [ -f $HOME/environment.yml ]; then
      cenv $HOME/environment.yml
  fi
fi
