# exporto variable para el ssh-add
# Fuente: https://wiki.archlinux.org/title/SSH_keys#Start_ssh-agent_with_systemd_user
export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/ssh-agent.socket"

# Add ~/bin to PATH
if [[ -d $HOME/bin ]]; then
    export PATH=$HOME/.bin/:$PATH;
fi
