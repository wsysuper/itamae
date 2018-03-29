# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

if [ $(id -u) -eq 0 ]; then
  PS1="\u@\h:\w # "
else
  PS1='\[\033[0;34m\]\u\[\033[0;33m\]@\[\033[0;32m\]\h\[\033[00m\]:\[\033[0;36m\]\w\[\033[00m\] \$ '
fi

# User specific aliases and functions
if [ -f ~/.bash_aliases ]; then
	. ~/.bash_aliases
fi
