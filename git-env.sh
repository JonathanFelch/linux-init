#
# aliases
#
alias pserv='python -m SimpleHTTPServer $*'
alias wget='wget --trust-server-names --no-check-certificate'
alias ls='LC_COLLATE=C ls -lFha --group-directories-first --color '
alias grep='grep --color=always'
alias less='less -R'
 
#st should be a function to pass args
st(){ sublime-text-2 $*
}
 
 
# Xephyr
alias xephyrstart='Xephyr -ac -screen 1280x1024 -br -reset -terminate 2> /dev/null :1 &'

# git commamands simplified
alias gst='git status'
alias gco='git checkout'
alias gci='git commit -v'
alias gd='git diff --color'
alias gcob='git checkout -b'
alias grb='git rebase'
alias gbr='git branch'
alias gpl='git pull'
alias gpu='git push'
alias gad='git add -A'
alias gmt='git mergetool'
alias bdf='git diff'
alias glg='git log --date-order --all --graph --format="%C(green)%h%Creset %C(yellow)%an%Creset %C(blue bold)%ar%Creset %C(red bold)%d%Creset%s"'
alias glg2='git log --date-order --all --graph --name-status --format="%C(green)%H%Creset %C(yellow)%an%Creset %C(blue bold)%ar%Creset %C(red bold)%d%Creset%s"'
 
# git functions: aliases cannot have args
# alias gbd='git config branch.$0.description'
gbd(){ git config branch.$*.description
}
 
#
# git whizzardry - http://www.opinionatedprogrammer.com/2011/01/colorful-bash-prompt-reflecting-git-status/
#
function _git_prompt() {
local git_status="`git status -unormal 2>&1`"
if ! [[ "$git_status" =~ Not\ a\ git\ repo ]]; then
if [[ "$git_status" =~ nothing\ to\ commit ]]; then
local ansi=42
elif [[ "$git_status" =~ nothing\ added\ to\ commit\ but\ untracked\ files\ present ]]; then
local ansi=43
else
local ansi=45
fi
if [[ "$git_status" =~ On\ branch\ ([^[:space:]]+) ]]; then
branch=${BASH_REMATCH[1]}
test "$branch" != master || branch=' '
else
# Detached HEAD. (branch=HEAD is a faster alternative.)
branch="(`git describe --all --contains --abbrev=4 HEAD 2> /dev/null ||
echo HEAD`)"
fi
echo -n '\[\e[0;37;'"$ansi"';1m\]'"$branch"'\[\e[0m\] '
fi
}
function _prompt_command() {
PS1="`_git_prompt`"'\[\e[1;34m\]\w \$\[\e[0m\] '
}
PROMPT_COMMAND=_prompt_command
PROMPT_COMMAND="history -a; history -c; history -r; $PROMPT_COMMAND"
