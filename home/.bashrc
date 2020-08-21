# Don't use Ctrl-S and Ctrl-Q for terminal flow control
stty stop undef
stty start undef

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

## Environment variables
export LANG=en_US.UTF-8
export LC_COLLATE=C
export BLOCKSIZE=K
export EDITOR="emacs -nw"
export PAGER='most -c'
export AWS_REGION=us-west-1
# The next two are for JavaHL
#export LD_LIBRARY_PATH=/usr/lib/jni:/usr/lib/oracle/11.2/client64/lib

export PATH="/usr/local/opt/ruby/bin:${PATH}:${HOME}/bin"

export ORACLE_HOME=/usr/lib/oracle/11.2/client64

export TNS_ADMIN=/usr/lib/oracle/11.2/client64/network/admin

export TZ='America/Los_Angeles'

export ORG_GRADLE_PROJECT_fabricApiKey=8fbf654066ad4360da50ca8b1b143e2253fe13fa
export ORG_GRADLE_PROJECT_fabricApiSecret=10190b80ca75ba039f999a88e3c8029df1220a03488b38f577e6d3a7079bcf83


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
    . /etc/bash_completion
fi

if [[ "$OSTYPE" =~ ^darwin ]]; then
    hash brew 2> /dev/null &&
    if [ -f $(brew --prefix)/etc/bash_completion ]; then
        . $(brew --prefix)/etc/bash_completion
    fi
fi

source "$HOME/.homesick/repos/homeshick/homeshick.sh"
source "$HOME/.homesick/repos/homeshick/completions/homeshick-completion.bash"

# The next line updates PATH for the Google Cloud SDK.

[ -f /usr/local/dev/google-cloud-sdk/path.bash.inc ] && . /usr/local/dev/google-cloud-sdk/path.bash.inc

# The next line enables bash completion for gcloud.
[ -f /usr/local/dev/google-cloud-sdk/completion.bash.inc ] && . /usr/local/dev/google-cloud-sdk/completion.bash.inc


[ -f "${HOME}/.bashrc.d/svn.bashrc" ] && . "${HOME}/.bashrc.d/svn.bashrc"

ANDROID_SDK_TOOLS_DIR=/Users/cgoldman/Library/Android/sdk/tools
if [ -d "${ANDROID_SDK_TOOLS_DIR}" ]; then
    export PATH="${PATH}:${ANDROID_SDK_TOOLS_DIR}"
fi


export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

if type "jenv" &> /dev/null
then
    eval "$(jenv init -)"
fi

# Enable bash completion for git
[ -f /usr/local/etc/bash_completion.d/git-completion.bash ] && . /usr/local/etc/bash_completion.d/git-completion.bash
[ -f /usr/local/etc/bash_completion.d/git-prompt.sh ] && . /usr/local/etc/bash_completion.d/git-prompt.sh

PS1="\u@\h:\w$(__git_ps1)\$ "

[ -f "${HOME}/.bashrc.d/local.bashrc" ] && . "${HOME}/.bashrc.d/local.bashrc"

# AWS environment variables
[ -f "${HOME}/.aws-env" ] && . "${HOME}/.aws-env"


AWS_BIN_DIR=/usr/local/aws/bin
if [ -d "${AWS_BIN_DIR}" ]; then
    export PATH="${PATH}:${AWS_BIN_DIR}"
    complete -C "${AWS_BIN_DIR}/aws_completer" aws
fi

CUDA_BIN_DIR=/usr/local/cuda/bin
if [ -d "${CUDA_BIN_DIR}" ]; then
    export PATH="${PATH}:${CUDA_BIN_DIR}"
fi

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"

# tabtab source for packages
# uninstall by removing these lines
[ -f ~/.config/tabtab/__tabtab.bash ] && . ~/.config/tabtab/__tabtab.bash || true
