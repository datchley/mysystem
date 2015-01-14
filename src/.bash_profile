# Grab the .kshrc if available
if [ -f ~/.bashrc ]; then
	. ~/.bashrc
fi

# Git completion setup
# if [ -f ~/git-completion.bash ]; then
# 	. ~/git-completion.bash
# fi

# Source in Answers.com specific profile settings
# if [ -f ~/answers.bash ]; then
#	. ~/answers.bash
# fi

export GIT=git@vcs0stl0.lan.announcemedia.com
export TERM=xterm-256color

# Path prefers homebrew installs over local 
export PATH=/usr/local/bin:/usr/local/sbin:$PATH:/Users/david.atchley/bin
# MacPorts/Fink
# export PATH=$PATH:/opt/local/bin:/opt/local/sbin
export NODE_PATH='/usr/local/lib/jsctags:${NODE_PATH}'

# Homebrew path changes to allow gnu utils over local
PATH="/usr/local/opt/coreutils/libexec/gnubin:/usr/local/opt/gnu-sed/libexec/gnubin:$PATH"
MANPATH="/usr/local/opt/coreutils/libexec/gnuman:/usr/local/opt/gnu-sed/libexec/gnuman:$MANPATH"

export PATH=$PATH:/opt/amp/bin:/opt/amp/mysql/bin:/opt/amp/sbin:/opt/amp/etc/init.d

export LC_ALL=en_US.UTF-8  
export LANG=en_US.UTF-8


##########
# PROMPT #
##########

# this is interminably slow on large repos, especially on a shared volume/disk
function parse_git_dirty {
	[[ $(git status 2> /dev/null | tail -n1) != "nothing to commit (working directory clean)" ]] && echo "*"
}

function parse_git_branch {
	# git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e "s/* \(.*\)/[\1$(parse_git_dirty)]/"
	git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e "s/* \(.*\)/[\1]/"
}

export PS1='\u@\h \[\033[1;33m\]\w\[\033[0m\]$(parse_git_branch)$ '


# OS X gnu utils color output
export CLICOLOR=1
export LS_OPTIONS="--color=auto"
export GREP_OPTIONS="--color=auto"
eval `dircolors ~/.dircolors-solarized`
# export LSCOLORS=GxFxCxDxBxegedabagaced
export LESS=-R

# Command line editing mode
set -o vi
export EDITOR=vi
export VISUAL=$EDITOR
export FCEDIT=$EDITOR

###########
# ALIASES #
###########
alias cdev='cd /var/www/html/announcemedia'

# list stuff all pretty like
alias ls='ls $LS_OPTIONS -hF'
alias ll='ls $LS_OPTIONS -lhF'
alias lt='ls $LS_OPTIONS -lhFtr'
alias la='ls $LS_OPTIONS -lha'

# highlight matches and allow egrep functionality
alias grep='grep $GREP_OPTIONS -E'

# Pretty-print of some PATH variables:
alias path='echo -e ${PATH//:/\\n} | uniq | cat -n'
alias manpath='echo -e ${MANPATH//:/\\n} | uniq | cat -n'
alias libpath='echo -e ${LD_LIBRARY_PATH//:/\\n} | uniq | cat -n'
alias gitdiffbranch='git diff HEAD...master'

# quick 'cd' to development root 
alias ans='cd /var/www/html/announcemedia/answers.com/rubix.answers.com'

# find 10 largest files in a directory
alias ducks='du -cks * | sort -nr | head -n 10'

#
# Custom functions
#

# Combine 'cd' and 'ls'
function cl(){ cd "$@" && la; }

# {{{
# Node Completion - Auto-generated, do not touch.
shopt -s progcomp
for f in $(command ls ~/.node-completion); do
  f="$HOME/.node-completion/$f"
  test -f "$f" && . "$f"
done
# }}}


# export PATH=/opt/amp/bin:/opt/amp/mysql/bin:/opt/amp/sbin:/opt/amp/etc/init.d:$PATH

# export PATH=/opt/amp/bin:/opt/amp/mysql/bin:/opt/amp/sbin:/opt/amp/etc/init.d:$PATH

# export PATH=/opt/amp/bin:/opt/amp/mysql/bin:/opt/amp/sbin:/opt/amp/etc/init.d:$PATH

# export PATH=/opt/amp/bin:/opt/amp/mysql/bin:/opt/amp/sbin:/opt/amp/etc/init.d:$PATH

# export PATH=/opt/amp/bin:/opt/amp/mysql/bin:/opt/amp/sbin:/opt/amp/etc/init.d:$PATH

# export PATH=/opt/amp/bin:/opt/amp/mysql/bin:/opt/amp/sbin:/opt/amp/etc/init.d:$PATH
