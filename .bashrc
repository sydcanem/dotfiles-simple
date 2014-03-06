# Aliases
alias edit-bash-profile="$EDITOR -w ~/.bash_profile && source ~/.bash_profile"
alias cls="clear"
alias npmi="npm install"
alias lime="subl -a"
alias gs="git status"
alias gck="git checkout"
alias gcc="git commit"
alias etodos="sudo subl -a /etc/motd"
alias Emacs="/Applications/Emacs.app/Contents/MacOS/Emacs -nw"

# make directory and cd into that
mkcd() { mkdir -p "$@" && cd "$_"; }
# Include files in bash
include() { [[ -f "$1" ]] && source "$1"; }
