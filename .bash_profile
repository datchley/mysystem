# Grab the .kshrc if available
if [ -f ~/.bashrc ]; then
	. ~/.bashrc
fi

# Git completion setup
if [ -f ~/git-completion.bash ]; then
	. ~/git-completion.bash
fi

# Source in Answers.com specific profile settings
if [ -f ~/answers.bash ]; then
	. ~/answers.bash
fi

export GIT=git@vcs0stl0.lan.announcemedia.com
export TERM=xterm-color
export PATH=/usr/local/bin:$PATH:/Users/david.atchley/bin
# export LC_CTYPE=en_US.utf-8
# export LC_ALL=en_US.utf-8
# export LANG="$LC_ALL"


##########
# PROMPT #
##########
# parse_git_branch() {
#  git symbolic-ref HEAD 2> /dev/null | cut -d/ -f3- | sed -e 's/\(.*\)/ (\1)/'
# }
# PS1="[\t] \w \[\]\$(parse_git_branch)\[\]$ "

# function parse_git_dirty {
# 	[[ $(git status 2> /dev/null | tail -n1) != "nothing to commit (working directory clean)" ]] && echo "*"
# }

# function parse_git_branch {
# 	git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e "s/* \(.*\)/[\1$(parse_git_dirty)]/"
# }
function parse_git_branch() {
    in_wd="$(git rev-parse --is-inside-work-tree 2>/dev/null)" || return
    test "$in_wd" = true || return
    state=''
    git update-index --refresh -q >/dev/null # avoid false positives with diff-index
    if git rev-parse --verify HEAD >/dev/null 2>&1; then
        git diff-index HEAD --quiet 2>/dev/null || state='*'
    else
        state='#'
    fi
    (
        d="$(git rev-parse --show-cdup)" &&
        cd "$d" &&
        test -z "$(git ls-files --others --exclude-standard .)"
    ) >/dev/null 2>&1 || state="${state}+"
    branch="$(git symbolic-ref HEAD 2>/dev/null)"
    test -z "$branch" && branch='<detached-HEAD>'
    echo " ("${branch#refs/heads/}")["${state}"]"
}
export PS1='\u@\h \[\033[1;33m\]\w\[\033[0m\]$(parse_git_branch)$ '

set -o vi

###########
# ALIASES #
###########
alias cdev='cd /var/www/html/announcemedia'
alias ll='ls -l'

# highlight matches and allow egrep functionality
alias grep='grep --color=always -E'

# Pretty-print of some PATH variables:
# alias path="echo $PATH | tr ':' '\n' | uniq | cat -n"
alias path='echo -e ${PATH//:/\\n} | uniq | cat -n'
alias libpath='echo -e ${LD_LIBRARY_PATH//:/\\n} | uniq | cat -n'


# OS X ls color output
export CLICOLOR=1
export LSCOLORS=GxFxCxDxBxegedabagaced

##
# Your previous /Users/david.atchley/.bash_profile file was backed up as /Users/david.atchley/.bash_profile.macports-saved_2013-07-19_at_10:31:28
##

# MacPorts Installer addition on 2013-07-19_at_10:31:28: adding an appropriate PATH variable for use with MacPorts.
export PATH=/opt/local/bin:/opt/local/sbin:$PATH
# Finished adapting your PATH environment variable for use with MacPorts.

