#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'

export http_proxy=http://127.0.0.1:7897
export https_proxy=http://127.0.0.1:7897
export all_proxy=socks5://127.0.0.1:7897

alias l="ls"
alias ll="ls -l"
alias la="ls -a"
alias lla="ls -la"
alias cls="clear"
alias zed='zeditor'
alias parui="paru -S"
alias parur="paru -Rns"
alias parus="paru -Ss"
alias login="uv run --project /home/v1hz/autoWifi /home/v1hz/autoWifi/login.py"

dbox() {
    distrobox "$@"
}

sc() {
    systemctl "$@"
}
ssc() {
    sudo systemctl "$@"
}

pod() {
    podman "$@"
}
podc() {
    podman-compose "$@"
}

eval "$(starship init bash)"

if [ -z "$CONTAINER_ID" ]; then
    echo "[DISTROBOX LOG] 使用宿主机配置中"
    alias vim='zeditor'
    alias vi='zeditor'
    alias nano='zeditor'
    eval "$(direnv hook bash)"
else
    echo "[DISTROBOX LOG] 使用虚拟机配置中"
    source ~/dev_ws/install/local_setup.sh
    source /opt/ros/jazzy/setup.bash
fi
