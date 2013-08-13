# Makefile

prefix=`echo $$HOME`
dir=`pwd`

SRC=.$(dir)/src
DOT_FILES=$(SRC)/.bashrc $(SRC)/.gitconfig $(SRC)/git-completion.bash $(SRC)/.vimrc $(SRC)/.jshintrc

VIMRC=$(SRC)/.vimrc
VIM_FILES=$(shell find src/.vim -type f | sed -e "s/^src\///g")

GIT=`which git`
ACK=`which ack`

all: 
	@echo "Usage: make [install|install-dotfiles|install-vim]"

# checks for dependencies
check:
	@test "$(GIT)" != "" || (echo "Missing 'git' command. Needed to patch syntastic PHP files. Please install git first"; exit 1 )
	@test "$(ACK)" != "" || (echo "Missing 'ack' command. Please install"; exit 2 )

install-vim: 
	@echo install -d $(VIMRC) $(prefix)
	@for f in $(VIM_FILES) ; do \
		echo install -d $(SRC)/$$f $(prefix)/$$f ; \
	done
	## Patch Syntastic plugin for php
	@echo "Patching PHP syntastic plugin...."
	@patch -u $(prefix)/.vim/bundle/syntastic/syntax_checkers/php/php.vim $(SRC)/syntastic-php.patch

install-dotfiles:
	@echo install $(DOT_FILES) $(prefix)

install: check install-vim install-dotfiles
	@echo @cp -r $(SRC)/.vim/* $(prefix)/.vim/	
	@echo $(GIT) apply --ignore-space-change --ignore-whitespace $(SRC)/syntastic.patch

