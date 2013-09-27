

# Make some possibly destructive commands more interactive in production
if [ "$RUNTIME_ENV" = 'PRODUCTION' ]; then
  alias rm='rm -i'
  alias mv='mv -i'
  alias cp='cp -i'
fi

 
# Add some easy shortcuts for formatted directory listings and add a touch of color.
alias ll='ls -lF --color=auto'
alias la='ls -alF --color=auto'
alias ls='ls -F'
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

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Make grep more user friendly by highlighting matches
# and exclude grepping through .svn folders.
alias grep='grep --color=auto --exclude-dir=\.svn'
 
# Shortcut for using the Kdiff3 tool for svn diffs.
alias svnkdiff3='svn diff --diff-cmd kdiff3'
