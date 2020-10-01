#
# ~/.bashrc
#

export EDITOR=nvim

export TERMINAL=alacritty

export CVS_RSH=ssh
export CVSROOT=:ext:ist189482@sig:/afs/ist.utl.pt/groups/leic-co/co20/cvs/010

export JAVA_HOME=/usr/lib/jvm/java-11-openjdk

export PATH="$HOME/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/.gem/ruby/2.7.0/bin:$PATH"
export PATH="$JAVA_HOME/bin:$PATH"

if [[ -z $DISPLAY ]] && [[ $(tty) = /dev/tty1 ]]; then
    startx &> /dev/null
    exit
fi

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

HISTFILESIZE=10000
HISTSIZE=10000

source /usr/share/bash-completion/bash_completion

set -o vi

export BASE00=\#00002a #background
export BASE01=\#2e2f30 #lighter background
export BASE02=\#30305a #selection background
export BASE03=\#50507a #comments, invisibles, line highlighting
export BASE04=\#b0b0da #dark foreground
export BASE05=\#d0d0fa #default foreground
export BASE06=\#e0e0ff #light foreground
export BASE07=\#f5f5ff #light background
export BASE08=\#ff4242 #red       variables

export BASE09=\#fc8d28 #orange    integers, booleans, constants
export BASE0A=\#f3e877 #yellow    classes
export BASE0B=\#59f176 #green     strings
export BASE0C=\#0ef0f0 #aqua      support, regular expressions
export BASE0D=\#66b0ff #blue      functions, methods
export BASE0E=\#f10596 #purple    keywords, storage, selector
export BASE0F=\#f003ef #          deprecated, opening/closing embedded language tags

BASE16_SHELL=$HOME/.base16-manager/chriskempson/base16-shell/
[ -n "$PS1" ] && \
    [ -s $BASE16_SHELL/profile_helper.sh ] && \
        eval "$($BASE16_SHELL/profile_helper.sh)"

source $HOME/.colors

alias nv=nvim
alias ':q'=exit
alias 'norandom'='echo 0 | sudo tee /proc/sys/kernel/randomize_va_space'
alias 'vpnup'='nmcli c up tecnico'
alias 'vpndown'='nmcli c down tecnico'
alias 'my_ip'='curl checkip.amazonaws.com'
alias 'sst'='st &> /dev/null &'

export JAVA_HOME=/usr/lib/jvm/java-8-openjdk

shopt -s autocd

function prompt_command {
    RET=$?
    export PS1=$(~/.bash_prompt_command $RET $COLUMNS)
}

PROMPT_DIRTRIM=2
PROMPT_COMMAND=prompt_command

# Android stuff
export USE_CCACHE=1
export CCACHE_COMPRESS=1
export ANDROID_JACK_VM_ARGS='-Dfile.encoding=UTF-8 -XX:+TieredCompilation -Xmx4G'

# CTF stuff
export CTF=$(ls -td1 /home/jp/Documents/STT/*/ | head -1)
alias 'ctf'='cd $CTF'

# TODO stuff
alias 'todo'='TODO.sh'
todo

