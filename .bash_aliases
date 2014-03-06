
# Make some possibly destructive commands more interactive in production
if [ "$RUNTIME_ENV" = 'PRODUCTION' ]; then
  alias rm='rm -i'
  alias mv='mv -i'
  alias cp='cp -i'
fi

 # enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
  test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"

  alias grep='grep --color=always'
  alias fgrep='fgrep --color=always'
  alias egrep='egrep --color=always'
fi

# Add some easy shortcuts for formatted directory listings and add a touch of color.
alias ll='ls -lF --color=always'
alias la='ls -alF --color=always'
alias ls='ls -lsah --color=always'
alias l='ls -CF'

# up 'n' folders
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'

# intellij
alias idea="idea.sh 1>/dev/null 2>&1 & disown"

