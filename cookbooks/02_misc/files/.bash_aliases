# User specific aliases and functions

# system
alias sudo='sudo -E '
alias vi='vim'
alias del='rm -r -f'
alias u='cd ..'
alias l='ls -AlhF'
alias reb='sudo reboot'
alias pp='ss -ltnp'
alias noc="grep -v '^\s*$\|^\s*\#'"

pps() {
    ps -ef | grep -i "$1" | grep -v "grep" | sed G
}

# yum
alias upd='sudo yum update -y'
alias ins='sudo yum install -y'

# history
alias h='history'
alias cx='cat /dev/null > ~/.bash_history && history -c && exit'

# docker
if docker 1>/dev/null 2>/dev/null; then
    alias dps='docker ps -a | sed G'
    alias dim='docker images'
    alias dcc='docker ps -qf status=exited -f status=created | xargs -r docker rm'
    alias dcv='docker volume ls -qf dangling=true | xargs -r docker volume rm'
    alias dci="dim | grep '<none>' | awk '{print \$3}' | xargs -r docker rmi -f"
    alias drm='docker rm -f'
    alias drmi='docker rmi'
    dr() {
        docker run -itd --name $2 $1
    }
    dx() {
        docker exec -it $1 bash
    }
fi
