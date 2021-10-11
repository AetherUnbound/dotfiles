# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# set grep color
PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME}: ${PWD}\007"'
GREP_COLORS="mt=01;34:ms=01;34:mc=01;31"
TERM=xterm-256color

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
    # We have color support; assume it's compliant with Ecma-48
    # (ISO/IEC-6429). (Lack of such support is extremely rare, and such
    # a case would tend to support setf rather than setaf.)
    color_prompt=yes
    else
    color_prompt=
    fi
fi

# Set the title appropriately
PROMPT_COMMAND='echo -ne "\033]0;$([[ -z ${CONDA_DEFAULT_ENV} ]] && echo "" || echo "${CONDA_DEFAULT_ENV} |") $(basename ${PWD}): ${USER}@${HOSTNAME}\007"'
if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;35m\]\u@\h\[\033[00m\]:\[\033[01;36m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
alias ll='ls -alFh'
alias la='ls -A'
alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi
# eval "$(register-python-argcomplete conda)"

# User commands
alias openhere="xdg-open ."
alias :q="exit"
alias act="source activate"
alias deact="source deactivate"
alias ipconfig="ip addr show | egrep '[0-9]{1,4}\.[0-9]{1,4}\.[0-9]{1,4}\.[0-9]{1,4}'"
alias listenvs="conda info --envs"
export JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64
alias transpile="/home/aether/Programs/latex-notes-transpiler-master/transpile.sh"
alias screenoff="xset dpms force off"
alias matrix="cmatrix -C cyan -u 7"
alias cdl=cdl_function
alias ebrc='vim +94 ~/.bashrc && source ~/.bashrc'
alias evrc='vim ~/.vimrc'
alias jnb='jupyter notebook'
alias b='cd ..'
alias ro='vim -M '
alias fif=findin_function
alias raif=replaceall_function
alias oh='xdg-open .'
alias le='conda info --envs'
alias swamp='ssh dataswamp.info'
alias wikissh='ssh 161.35.110.116'
alias deac="conda deactivate"
alias pip="python -m pip"
alias old-dc="/usr/bin/dc"
alias dc="docker-compose"
alias yeet="rm -rf"
alias mkdirc=mkdirc_function

# Binds
bind "set completion-ignore-case on"
bind "TAB: menu-complete"
bind '"\e[Z": complete'


# Fuzzyfine settings
[ -f ~/.fzf.bash ] && source ~/.fzf.bash
export FZF_DEFAULT_COMMAND='ag --hidden --ignore "node_modules/" --ignore "anaconda.*/" -g ""'
export FZF_CTRL_T_COMMAND='ag --ignore "node_modules/" --ignore "anaconda.*/" -g ""'
export FZF_ALT_C_COMMAND="command find -L . -mindepth 1 \( -path '*/\.*' -o -fstype 'sysfs' -o -fstype 'devfs' -o -fstype 'devtmpfs' -o -fstype 'proc' -o -path '*/node_modules*' -o -path '*/anaconda*' -o -path '*/Library*' \) -prune -o -type d -print 2> /dev/null | cut -b3-"

set -o vi

cdl_function () {
    cd $1 && ls -lah
}

mkdirc_function () {
    mkdir -p $1 && cd $1
}

findin_function () {
    grep -rn '.' -ie $1
}

replaceall_function () {
    find . -type f -exec sed -i $1 {} \;
}

# Tab completed virtual environments
vact () {
    . activate ${1}
}
__vact()
{
    local cur=${COMP_WORDS[COMP_CWORD]}
    IFS=$'\n' tmp=( $(compgen -W "$(ls /home/aether/programs/anaconda3/envs/ )" -- $cur))
    COMPREPLY=( "${tmp[@]// /\ }" )
}
complete -F __vact vact

# Pytest setting
export PYTEST_ADDOPTS="-v"

# Editor options
export EDITOR="vim"

# Eternal bash history.
# ---------------------
# Undocumented feature which sets the size to "unlimited".
# http://stackoverflow.com/questions/9457233/unlimited-bash-history
export HISTFILESIZE=
export HISTSIZE=
export HISTTIMEFORMAT="[%F %T] "
# Change the file location because certain bash sessions truncate .bash_history file upon close.
# http://superuser.com/questions/575479/bash-history-truncated-to-500-lines-on-each-login
export HISTFILE=~/.bash_eternal_history

# Powerline font stuff
export PATH="/home/aether/programs/anaconda3/bin:$PATH"  # commented out by conda initialize
# powerline-daemon -q
POWERLINE_BASH_CONTINUATION=1
POWERLINE_BASH_SELECT=1
if [ -f /home/aether/programs/anaconda3/lib/python3.8/site-packages/powerline/bindings/bash/powerline.sh ]; then
    source /home/aether/programs/anaconda3/lib/python3.8/site-packages/powerline/bindings/bash/powerline.sh
fi

if [ -d ${HOME}/.rbenv ] ; then
    export PATH="$HOME/.rbenv/bin:$PATH"
    eval "$(rbenv init -)"
fi

install_rbenv() {
    if [ ! -d ${HOME}/.rbenv ] ; then
        git clone https://github.com/sstephenson/rbenv.git ${HOME}/.rbenv
    fi
    if [ ! -d ${HOME}/.rbenv/plugins/ruby-build ] ; then
        git clone https://github.com/sstephenson/ruby-build.git ${HOME}/.rbenv/plugins/ruby-build
    fi
}

[ -f ~/.fzf.bash ] && source ~/.fzf.bash

# added by Anaconda3 installer
# export PATH="/home/aether/programs/anaconda3/bin:$PATH"  # commented out by conda initialize
export PATH="/home/aether/.local/bin/:$PATH"

# Rebind inputrc
bind -f ~/.inputrc

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/aether/programs/anaconda3/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/aether/programs/anaconda3/etc/profile.d/conda.sh" ]; then
        . "/home/aether/programs/anaconda3/etc/profile.d/conda.sh"
    else
        export PATH="/home/aether/programs/anaconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

# Ruby version manager
[ -f /etc/profile.d/rvm.sh ] && source /etc/profile.d/rvm.sh
