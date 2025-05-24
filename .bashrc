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

# set grep color
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
PROMPT_COMMAND='echo -ne "\033]0;$([[ -z ${CONDA_DEFAULT_ENV} ]] && echo "" || echo "${CONDA_DEFAULT_ENV} |") $(basename "${PWD}"): ${USER}@${HOSTNAME}\007"'
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
## Note that for pls nerd fonts to work, you need to install one:
# https://gist.github.com/matthewjberger/7dd7e079f282f8138a9dc3b045ebefa0
alias ols='/bin/ls'
alias ls='pls'
alias ll='pls -d std'
alias la='ls -A'
alias l='pls'

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
if [ -f ~/.git-completion.bash ]; then
  . ~/.git-completion.bash
fi

# User commands
alias openhere="xdg-open ."
alias j="just"
alias gw="./gradlew"
alias oh="xdg-open ."
alias ohe="xdg-open . && exit"
alias :q="exit"
alias ipconfig="ip addr show | egrep '[0-9]{1,4}\.[0-9]{1,4}\.[0-9]{1,4}\.[0-9]{1,4}'"
alias le="conda info --envs"
alias transpile="/home/aether/programs/latex-notes-transpiler-master/transpile.sh"
alias screenoff="xset dpms force off"
alias matrix="cmatrix -C cyan -u 7"
alias cdl=cdl_function
alias ebrc='vim +129 ~/.bashrc && source ~/.bashrc'
alias evrc='vim +109 ~/.vimrc'
alias jnb='jupyter notebook'
alias cat='bat'
alias b='cd ..'
alias ro='vim -M '
alias hack='cat /dev/urandom | hexdump -C | grep "[[:alpha:]]\{2\}"' 
alias fif=findin_function
alias raif=replaceall_function
alias deac="conda deactivate"
alias swamp="ssh aether@dataswamp.info"
alias wikissh='ssh 161.35.110.116'
alias deac="conda deactivate"
alias pip="python3 -m pip"
alias dc-old="/usr/bin/dc"
alias dc="docker-compose"
alias yeet="rm -rf"
alias inenv="set | grep -i"
alias inpip="pip list | grep -i"
alias mkdirc=mkdirc_function
alias sudovim="sudoedit"
alias ec2ssh=connect_ec2_func
alias ec2ssh-jumpbox=connect_ec2_func_jumpbox
alias ec2ssh-airflow=connect_ec2_func_airflow
alias woman="/usr/bin/man"
alias man="cheat"
alias dpi="sudo dpkg -i"
alias vh="conda activate $(basename \"$(pwd)\")"
alias .j='just --justfile ~/.justfile --working-directory .'
alias sizes="du -hs * | sort -hr"
alias git_noup='git fetch -p && git branch -r | awk '"'"'{print $1}'"'"' | egrep -v -f /dev/fd/0 <(git branch -vv | grep origin) | awk '"'"'{print $1}'"'"''
alias prune-em-all="git_noup | xargs git branch -D"
alias ghpc="gh pr checkout"

# Binds
bind "set completion-ignore-case on"
bind "TAB: menu-complete"
bind '"\e[Z": complete'

export FZF_DEFAULT_COMMAND='ag --hidden --ignore "node_modules/" --ignore "anaconda.*/" -g ""'
export FZF_CTRL_T_COMMAND='ag --ignore "node_modules/" --ignore "anaconda.*/" --ignore "~/programs/anaconda3" -g ""'
export FZF_ALT_C_COMMAND="command find -L . -mindepth 1 \( -path '*/\.*' -o -fstype 'sysfs' -o -fstype 'devfs' -o -fstype 'devtmpfs' -o -fstype 'proc' -o -path '*/node_modules*' -o -path '*/Games*' -o -path '*/anaconda*' \) -prune -o -type d -print 2> /dev/null | cut -b3-"
set -o vi

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

mkdirc_function () {
    mkdir -p $1 && cd $1
}

cdl_function () {
    cd $1 && ls -lah
}

findin_function () {
    grep -rn '.' -ie "$@"
}

replaceall_function () {
    find . -type f -exec sed -i $1 {} \;
}

connect_ec2_func() {
    ssh -i ~/.ssh/a8c_servers_id_rsa -o StrictHostKeyChecking=no "${@:2}" ec2-user@$1
}

connect_ec2_func_jumpbox() {
    connect_ec2_func "jumphost.openverse.engineering" "-N" "-L" "5432:$1-openverse-db.$OPENVERSE_VPC_ENDPOINT:5432"
}

connect_ec2_func_airflow() {
    local pub_dns=$(aws ec2 describe-instances --filters '[{"Name": "tag:Name", "Values": ["catalog-airflow-prod"]}]' | jq -r .Reservations[0].Instances[0].PublicDnsName)
    connect_ec2_func $pub_dns
}

# Source secrets
[ -f ~/.bash_secrets ] && source ~/.bash_secrets

# Enable docker buildkit
export DOCKER_BUILDKIT=1

# Improved paging options for less
export LESS="-XFR"

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

# Fuzzyfind settings
[ -f ~/.fzf.bash ] && source ~/.fzf.bash
# Added by me
export FONTCONFIG_PATH=/etc/fonts

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"

# Brew setup
eval "$(/home/aether/.linuxbrew/bin/brew shellenv)"
# individual completions
libraries=("gh" "postgresql" "crontab" "heroku")
for library in "${libraries[@]}"; do
    fileloc="$(brew --prefix)/etc/bash_completion.d/gh"
    if [ -f "$fileloc" ]; then
        . $fileloc
    fi
done

# Rebind inputrc
bind -f ~/.inputrc

# Ruby version manager
[ -f /etc/profile.d/rvm.sh ] && source /etc/profile.d/rvm.sh

# Starship stuff
eval "$(starship init bash)"

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

# Just auto completion
_just() {
    local i cur prev opts cmds
    COMPREPLY=()
    cur="${COMP_WORDS[COMP_CWORD]}"
    prev="${COMP_WORDS[COMP_CWORD-1]}"
    cmd=""
    opts=""

    for i in ${COMP_WORDS[@]}
    do
        case "${i}" in
            "$1")
                cmd="just"
                ;;
            
            *)
                ;;
        esac
    done

    case "${cmd}" in
        just)
            opts=" -q -u -v -e -l -h -V -f -d -c -s  --check --dry-run --highlight --no-dotenv --no-highlight --quiet --shell-command --clear-shell-args --unsorted --unstable --verbose --changelog --choose --dump --edit --evaluate --fmt --init --list --summary --variables --help --version --chooser --color --dump-format --list-heading --list-prefix --justfile --set --shell --shell-arg --working-directory --command --completions --show --dotenv-filename --dotenv-path  <ARGUMENTS>... "
                if [[ ${cur} == -* ]] ; then
                    COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
                    return 0
                elif [[ ${COMP_CWORD} -eq 1 ]]; then
                    local recipes=$(just --summary --color never 2> /dev/null)
                    if [[ $? -eq 0 ]]; then
                        COMPREPLY=( $(compgen -W "${recipes}" -- "${cur}") )
                        return 0
                    fi
                fi
            case "${prev}" in
                
                --chooser)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --color)
                    COMPREPLY=($(compgen -W "auto always never" -- "${cur}"))
                    return 0
                    ;;
                --dump-format)
                    COMPREPLY=($(compgen -W "just json" -- "${cur}"))
                    return 0
                    ;;
                --list-heading)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --list-prefix)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --justfile)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                    -f)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --set)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --shell)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --shell-arg)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --working-directory)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                    -d)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --command)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                    -c)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --completions)
                    COMPREPLY=($(compgen -W "zsh bash fish powershell elvish" -- "${cur}"))
                    return 0
                    ;;
                --show)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                    -s)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --dotenv-filename)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --dotenv-path)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                *)
                    COMPREPLY=()
                    ;;
            esac
            COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
            return 0
            ;;
        
    esac
}

complete -F _just -o bashdefault -o default just j .j

# QMK setup
# https://docs.qmk.fm/cli
export QMK_HOME="$HOME/.qmk_firmware"
