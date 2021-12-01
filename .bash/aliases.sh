# Define aliases
alias cp="cp -i"                          # confirm before overwriting something
alias ll="ls -lh"                        # ls in list and human readable
alias du="du -h -d 0"                    # disk usage with human readable and depth 0
alias open='xdg-open'
alias xc='xclip -selection clipboard'    # copy to clipboard using xclip
alias diceware-es='diceware -d " " --no-caps $DICEWARE_ES'
alias jn='jupyter-notebook'
alias ca='conda activate'
alias cdtop='cd $(git rev-parse --show-toplevel)' # cd to toplevel of git repo

# git aliases for misspelling
alias gti="git"
alias gi="git"

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# ssh to IDECOM
alias idecom="ssh agustina@pesce.unsj.edu.ar"

# Create an SSH "local port forward" to IDECOM
alias remotelab="ssh -N -L localhost:9999:localhost:8888 agustina@pesce.unsj.edu.ar"
