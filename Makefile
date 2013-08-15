# Makefile

# Where to install files
prefix=$(shell echo $$HOME)

# The package directory
dir=$(shell pwd)

SRC=./src
DOT_FILES=$(SRC)/.bash_profile $(SRC)/.gitconfig $(SRC)/git-completion.bash $(SRC)/.vimrc $(SRC)/.jshintrc
INSTALL_OPTS=-b -B "ORIG"

VIMRC=$(SRC)/.vimrc
VIM_FILES=$(shell find src/.vim -type f | sed -e "s/^src\///g")

GIT=`which git`
ACK=`which ack`

all: 
	@echo "Usage: make [install|install-dotfiles|install-vim]"
	@echo "prefix="$(prefix)
	@echo "dir="$(dir)
	@echo "SRC: "$(SRC)
	@echo "VIMRC: "$(VIMRC)

# checks for dependencies
check:
	## Checking for 'git' availability
	@test "$(GIT)" != "" || (echo "Missing 'git' command. Needed to patch syntastic PHP files. Please install git first"; exit 1 )
	## Checking for ack availability
	@test "$(ACK)" != "" || (echo "Missing 'ack' command. Please install"; exit 2 )

install-vim: 
	## Installing vimrc and vim resources
	install $(INSTALL_OPTS) $(VIMRC) $(prefix)
	for f in $(VIM_FILES) ; do \
		install $(INSTALL_OPTS) $(SRC)/$$f $(prefix)/$$f ; \
	done
	## Patch Syntastic plugin for php
	patch -u $(prefix)/.vim/bundle/syntastic/syntax_checkers/php/php.vim $(SRC)/syntastic-php.patch

install-dotfiles:
	## Installing '.' files in home directory
	install $(INSTALL_OPTS) $(DOT_FILES) $(prefix)

install: check install-vim install-dotfiles
	@echo "=== Complete!"
	@echo "=== ----------------------------------------------------------------------"
	@echo "=== INSTALLATION NOTES:"
	@echo "===  - All original files were backed up with a '.ORIG' extension"
	@echo "===  - You can install the provided Solarized Dark iTerm2 color theme "
	@echo "===    as follows: "
	@echo "==="
	@echo "===    1. In iTerm2, open 'iTerm2 > Preferences > Profiles > Colors', and "
	@echo "===       click 'Load Presets…'"
	@echo "===    2. Select the file 'Solarized Dark.itermcolors.xml' in the src/ of "
	@echo "===       this repository"
	@echo "==="
	@echo "=== ----------------------------------------------------------------------"

