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
GREP_COLORS="mt=01;34:ms=01;34:mc=01;31"
#TERM=xterm-256color
TERM=xterm

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
# alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

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

# added by Anaconda2 4.3.0 installer
#export PATH="/opt/gradle/gradle-4.0.1/bin:/home/mattb/programs/anaconda2/bin:$PATH"

# User commands
alias openhere="xdg-open ."
alias gw="./gradlew"
alias oh="xdg-open ."
alias ohe="xdg-open . && exit"
alias qmaster="ssh -Xt mattb@qmaster bash -i"
alias devssh="ssh -Xt mattb@dev-aics-mbp-002 bash -i"
alias hpc="ssh -Xt mattb@hpc-login bash -i"
alias slurm="ssh -Xt mattb@slurm-master bash -i"
alias :q="exit"
alias act="source activate"
alias deact="source deactivate"
alias ipconfig="ip addr show | egrep '[0-9]{1,4}\.[0-9]{1,4}\.[0-9]{1,4}\.[0-9]{1,4}'"
alias le="conda info --envs"
alias cellswiper="ssh matt@138.68.15.82"
alias dev1ssh="ssh dev-aics-mbp-001"
alias mountold="sshfs dev-aics-mbp-001:/home/mattb/ misc/oldmount/"
export ANT_HOME=/home/mattb/tools/ant
export PATH=$ANT_HOME/bin:$PATH
export NODE_HOME=/home/mattb/tools/node
export PATH=$NODE_HOME/bin:$PATH
export SCALA_HOME=/home/mattb/tools/scala
export PATH=$SCALA_HOME/bin:$PATH
export SBT_HOME=/home/mattb/tools/sbt
export PATH=$SBT_HOME/bin:$PATH
export JAVA_HOME=/usr/lib/jvm/jdk1.8.0_151/
export LABKEY_DEV_HOME=/home/mattb/tools/labkey
export MODULES_DIR=/tmp/lk/custom_modules
export MODULE_DIR=/tmp/lk/custom_modules
alias transpile="/home/mattb/programs/latex-notes-transpiler-master/transpile.sh"
alias screenoff="xset dpms force off"
alias airflowssh="ssh aicsops@airflow"
alias aftmp="ssh prd-aics-dcv-013"
alias gimmeperms="ssh prd-aics-dcv-013"
alias matrix="cmatrix -C cyan -u 7"
alias cdl=cdl_function
alias mkdirc=mkdirc_function
alias b='cd ..'
alias ro='vim -M '
alias ebrc='vim +129 ~/.bashrc && source ~/.bashrc'
alias evrc='vim +109 ~/.vimrc'
alias hack='cat /dev/urandom | hexdump -C | grep "[[:alpha:]]\{2\}"' 
alias jnb='jupyter notebook'
alias fif=findin_function
alias raif=replaceall_function
alias gotodags="cd /allen/aics/apps/prod/airflow/dags"
alias gotowellscore="cd /allen/aics/microscopy/CellSwiper/update-training"
alias chere=". activate $(basename $(pwd))"
alias amh="source activate $(basename $(pwd))"
alias ipylabkey="vact labkey && ipython -i /home/mattb/programs/labkey_load.py"
alias ipylabkeylocal="vact labkey && ipython -i /home/mattb/programs/labkey_load_local.py"
alias startlabkeydammit="vact labkeytools && lk_default"
alias interactiveslurm="ssh -Xt mattb@slurm-master srun -p aics_cpu_general --pty bash"

# Pytest setting
export PYTEST_ADDOPTS="-v"

export FZF_DEFAULT_COMMAND='ag --hidden --ignore "node_modules/" --ignore "anaconda.*/" -g ""'
export FZF_CTRL_T_COMMAND='ag --ignore "node_modules/" --ignore "anaconda.*/" -g ""'
export FZF_ALT_C_COMMAND="command find -L . -mindepth 1 \( -path '*/\.*' -o -fstype 'sysfs' -o -fstype 'devfs' -o -fstype 'devtmpfs' -o -fstype 'proc' -o -path '*/node_modules*' -o -path '*/anaconda*' \) -prune -o -type d -print 2> /dev/null | cut -b3-"
set -o vi


# added by Anaconda3 installer
export PATH="/home/mattb/programs/anaconda3/bin:$PATH"
# Anaconda tab completion
eval "$(register-python-argcomplete conda)"

# add linux utils
#export PATH="$PATH:/home/mattb/tools/linux-utils/bin"

# Tab completed virtual environments
vact () {
    . activate ${1}
}
__vact()
{
    local cur=${COMP_WORDS[COMP_CWORD]}
    IFS=$'\n' tmp=( $(compgen -W "$(ls /home/mattb/programs/anaconda3/envs/ )" -- $cur))
    COMPREPLY=( "${tmp[@]// /\ }" )
}
complete -F __vact vact


workon() {
    cd ~/git/${1} && vact ${1}
}
complete -F __vact workon


cdl_function () {
    cd $1 && ls -lah
}

mkdirc_function () {
    mkdir $1 && cd $1
}

findin_function () {
    rg -ie "$@"
}

replaceall_function () {
    find . -type f -exec sed -i $1 {} \;
}

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
# Add local bin to PATH
export PATH="/home/mattb/.local/bin:$PATH"
if [ -f ~/.local/lib/python3.7/site-packages/powerline/bindings/bash/powerline.sh ]; then
    source ~/.local/lib/python3.7/site-packages/powerline/bindings/bash/powerline.sh
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
# Added by me
export PATH="/home/mattb/programs/bftools:$PATH"
export FONTCONFIG_PATH=/etc/fonts
