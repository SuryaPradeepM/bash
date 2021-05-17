# Aliases

alias ls='ls -F'
alias ll='ls -lh'
alias la='ls -arlt'

alias lt='ls --human-readable --size -1 -S --classify'

alias mnt="mount | awk -F' ' '{ printf \"%s\t%s\n\",\$1,\$3; }' | column -t | egrep ^/dev/ | sort"
alias gh='history|grep'
alias ana='anaconda-navigator'

alias left='ls -t -1'

alias count='find . -type f | wc -l'

alias ve='python3 -m venv ./venv'
alias va='source ./venv/bin/activate'

alias cpv='rsync -ah --info=progress2'
alias throw='mv --force -t ~/.local/share/Trash'

#alias whou='who | cut -d' ' -f1 | sort | uniq'
alias c='clear'
alias e='exit'
alias u='users'
alias ipy='ipython'
alias py='python'
alias py3='python3'
# Git
alias g='git'
alias gclone='git clone'
alias gst='git status'
alias dst='dvc status'
alias gd='git diff'
alias gdc='git diff --cached'
alias gl='git pull'
alias dl='dvc pull'
alias gup='git pull --rebase'
alias gp='git push'
alias dp='dvc push'
alias gd='git diff'
alias gc='git commit -v'
alias gc!='git commit -v --amend'
alias gca='git commit -v -a'
alias gca!='git commit -v -a --amend'
alias gcmsg='git commit -m'
alias gco='git checkout'
alias gcm='git checkout master'
alias gr='git remote'
alias grv='git remote -v'
alias grmv='git remote rename'
alias grrm='git remote remove'
alias grset='git remote set-url'
alias grup='git remote update'
alias grbi='git rebase -i'
alias grbc='git rebase --continue'
alias grba='git rebase --abort'
alias gb='git branch'
alias gba='git branch -a'
alias gcount='git shortlog -sn'
alias gcl='git config --list'
alias gcp='git cherry-pick'
alias glg='git log --stat --max-count=10'
alias glgg='git log --graph --max-count=10'
alias glgga='git log --graph --decorate --all'
alias glo='git log --oneline --decorate --color'
alias glog='git log --oneline --decorate --color --graph'
alias gss='git status -s'
alias ga='git add'
alias da='dvc add'
alias gm='git merge'
alias grh='git reset HEAD'
alias grhh='git reset HEAD --hard'
alias gclean='git reset --hard && git clean -dfx'
alias gwc='git whatchanged -p --abbrev-commit --pretty=medium'
alias gcom='git log --format=%B -n 1 $(git log -1 --pretty=format:"%h") | cat -'

# submodule
alias gsub='git rev-parse HEAD; gcom; git submodule foreach  --recursive "git rev-parse --short HEAD; git rev-parse HEAD;"'

# remove the gf alias
#alias gf='git ls-files | grep'

alias gpoat='git push origin --all && git push origin --tags'
alias gmt='git mergetool --no-prompt'

alias gg='git gui citool'
alias gga='git gui citool --amend'
alias gk='gitk --all --branches'

alias gsts='git stash show --text'
alias gsta='git stash'
alias gstp='git stash pop'
alias gstd='git stash drop'

# Will cd into the top of the current repository
# or submodule.
alias grt='cd $(git rev-parse --show-toplevel || echo ".")'

# Git and svn mix
alias git-svn-dcommit-push='git svn dcommit && git push github master:svntrunk'

alias gsr='git svn rebase'
alias gsd='git svn dcommit'

# these alias commit and uncomit wip branches
alias gwip='git add -A; git ls-files --deleted -z | xargs -r0 git rm; git commit -m "--wip--"'
alias gunwip='git log -n 1 | grep -q -c "\-\-wip\-\-" && git reset HEAD~1'

# these alias ignore changes to file
alias gignore='git update-index --assume-unchanged'
alias gunignore='git update-index --no-assume-unchanged'
# list temporarily ignored files
alias gignored='git ls-files -v | grep "^[[:lower:]]"'


# functions
# Will return the current branch name
# Usage example: git pull origin $(current_branch)
#
function current_branch() {
  ref=$(git symbolic-ref HEAD 2> /dev/null) || \
  ref=$(git rev-parse --short HEAD 2> /dev/null) || return
  echo ${ref#refs/heads/}
}

function current_repository() {
  ref=$(git symbolic-ref HEAD 2> /dev/null) || \
  ref=$(git rev-parse --short HEAD 2> /dev/null) || return
  echo $(git remote -v | cut -d':' -f 2)
}

# these aliases take advantage of the previous function
alias ggpull='git pull origin $(current_branch)'
alias ggpur='git pull --rebase origin $(current_branch)'
alias ggpush='git push origin $(current_branch)'
alias ggpnp='git pull origin $(current_branch) && git push origin $(current_branch)'

# Pretty log messages
function _git_log_prettily(){
  if ! [ -z $1 ]; then
    git log --pretty=$1
  fi
}
alias glp="_git_log_prettily"

# Work In Progress (wip)
# These features allow to pause a branch development and switch to another one (wip)
# When you want to go back to work, just unwip it
#
# This function return a warning if the current branch is a wip
function work_in_progress() {
  if $(git log -n 1 2>/dev/null | grep -q -c "\-\-wip\-\-"); then
    echo "WIP!!"
  fi
}


function open_jupyter_chromium() {
  jupyter notebook list | grep http://localhost:8888/?token=[a-z0-9]* > serv.txt
  chromium $(<serv.txt)
  rm serv.txt
}
alias jup='open_jupyter_chromium'
alias jlist='jupyter notebook list'
alias conup='conda activate temp;conda update --all;conda clean --all;'
alias jupa='conda activate temp;cd ~/ana;jupyter notebook;'
alias jupcolab="jupyter notebook --NotebookApp.allow_origin='https://colab.research.google.com'  --port=8877  --NotebookApp.port_retries=0"
alias jlab='conda activate temp;jupyter lab'

# sara
alias m='make set_path; source ~/.bashrc; conda activate back'
alias ms='m; python sara.py'
alias s='conda activate back;c;python sara.py'
alias prof='m; c; kernprof -lv sara.py'
alias pyins='m; c; python -m pyinstrument --timeline sara.py'


# permissions
alias chdrwx='find . -type d -exec chmod a+rwx {} \;'
# Make folders traversable and read/write
alias chfrw='find . -type f -exec chmod a+rw {} \;'
# Make files read/write


# Pytest
alias testmod='python -m pytest -vxs -nauto'

# ssh
alias iron='ssh ironman'
alias beast='ssh 172.16.0.7'

# redis
alias redis='cd ~;rm dump.rdb; redis-server'

# tox
alias stress='c; for i in {1..14}; do tox; done;'

# gunicorn 
alias guni='gunicorn app:app -c gunicorn.config.py'

# kill process with port
alias kill5k='fuser -k 5000/tcp'

# find duplicate files
alias findups='find . ! -empty -type f -exec md5sum {} + | sort | uniq -w32 -dD'