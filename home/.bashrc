# file permissions: rwxrwxr-x
umask	0002

# Uncomment next line to enable the builtin emacs(1) command line editor
# in sh(1), e.g. C-a -> beginning-of-line.
set -o emacs

# Report when backgrounded jobs are done.
set notify

## Bash history settings
# Don't record consecutive duplicates
export HISTCONTROL=ignoredups
# Save 2000 commands (both live and in the history file)
export HISTSIZE=2000
export HISTFILESIZE=2000
# Append history to the on-disk store (rather than overwrite)
shopt -s histappend
# Append the new history lines before displaying each prompt
export PROMPT_COMMAND='history -a'

## Correct minor spelling errors in directory paths (with the "cd" command)
shopt -s cdspell


# set prompt: ``username@hostname$ '' 
PS1="`whoami`@`hostname | sed 's/\..*//'`:\w\$ "

## Environment variables
export CVS_RSH=ssh
export CVSROOT_DHAP=:ext:cgoldman@cvs.dev.sf.dhapdigital.com:/u01/cvsroot
export CVSROOT_TMS_DEV=:pserver:goldmanc@pswebp41.toyota:/cvsroot
export CVSROOT=$CVSROOT_DHAP
export LANG=en_US.UTF-8
export LC_COLLATE=C
export BLOCKSIZE=K
export EDITOR="emacs -nw"
export PAGER='most -c'
# The next two are for JavaHL
#export LD_LIBRARY_PATH=/usr/lib/jni:/usr/lib/oracle/11.2/client64/lib

export PATH=${PATH}:${HOME}/bin

export ORACLE_HOME=/usr/lib/oracle/11.2/client64

export TNS_ADMIN=/usr/lib/oracle/11.2/client64/network/admin

export TZ='America/Los_Angeles'



if [ -f ~/.config/ls/LS_COLORS ]; then
    eval $(dircolors -b ~/.config/ls/LS_COLORS)
fi

if [ -f ~/.bash_functions ]; then
    . ~/.bash_functions
fi

if [ -f ~/.alias ]; then
    . ~/.alias
fi

## Enable programmable completion
if [ -f /etc/bash_completion ]; then
    source /etc/bash_completion
fi


source "$HOME/.homesick/repos/homeshick/homeshick.sh"

