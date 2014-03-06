Color_Off='\e[0m'      # Text Reset
 
Black='\e[0;30m'       # Black
Red='\e[0;31m'         # Red
Green='\e[0;32m'       # Green
Yellow='\e[0;33m'      # Yellow
Blue='\e[0;34m'        # Blue
Purple='\e[0;35m'      # Purple
Cyan='\e[0;36m'        # Cyan
White='\e[0;37m'       # White
 
BBlack='\e[1;30m'      # Black
BRed='\e[1;31m'        # Red
BGreen='\e[1;32m'      # Green
BYellow='\e[1;33m'     # Yellow
BBlue='\e[1;34m'       # Blue
BPurple='\e[1;35m'     # Purple
BCyan='\e[1;36m'       # Cyan
BWhite='\e[1;37m'      # White
 
export CLICOLOR=1
export LSCOLORS=GxFxCxDxBxegedabagaced

source ~/.git-prompt.sh
source ~/.profile
source ~/.bashrc
 
# command prompt
DIVIDER=""
DATE="\d \@ - "
MACHINEINFO="$White\u@$Green\h"
CWD="\e[0m - $Cyan\w"
PROMPT="$BGreen\n$ \[\e[m"
export PS1="$DIVIDER$MACHINEINFO$CWD\$(__git_ps1)$PROMPT"

export PATH=$PATH

alias remove-dsstore="find . -name '*.DS_Store' -type f -delete"

if [ -f /usr/local/bin/subl ]; then
	EDITOR='/usr/local/bin/subl'
else
	EDITOR=/usr/bin/vi
fi

alias edit=$EDITOR
export EDITOR=$EDITOR


if [ -f ~/.bin/tmuxinator.bash ]; then
	. ~/.bin/tmuxinator.bash
fi

if [ -f ~/.git-completion.bash ]; then
	. ~/.git-completion.bash
fi

export GOPATH=$HOME/go
export PATH=$PATH:$GOPATH/bin
