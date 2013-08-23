# Makefile

# Where to install files
# DEBUG: prefix=$(shell echo $$HOME/TMP)
prefix=$(shell echo $$HOME)

# debug mode, for dryrun testing
debug=0

SRC=$(shell pwd)/src
DOT_FILES=$(SRC)/.bash_profile $(SRC)/.gitconfig $(SRC)/.git-completion.bash $(SRC)/.vimrc $(SRC)/.jshintrc
INSTALL_OPTS=
INSTALL_CMD=$(shell which install)

## dummy commands for testing makefile
ifeq ($(debug), 1)
	INSTALL=echo "(debug) install "
	CP=echo "(debug) cp "
	PATCH=echo "(debug) patch "
	MKDIR=echo "(debug) mkdir "
else
	INSTALL=$(INSTALL_CMD) $(INSTALL_OPTS)
	CP=$(shell which cp)
	PATCH=$(shell which patch)
	MKDIR=$(shell which mkdir)
endif

VIMRC=$(SRC)/.vimrc
VIM_FILES=$(shell find src/.vim -type f | sed -e "s/^src\///g")
VIM_DIRS=autoload \
	bundle \
	colors \
	plugin
VIM_PKG_SRC=src/.vim/bundle
VIM_PKGS=NERD_tree-ack.vim \
	ack.vim \
	ctrlp.vim \
	nerdtree \
	php.vim \
	syntastic \
	vim-airline \
	vim-colors-solarized \
	vim-fugitive \
	vim-nerdtree-tabs

GIT=`which git`
ACK=`which ack`

all: 
	@echo "Usage: make [install|install-dotfiles|install-vim]"
	@echo "prefix="$(prefix)
	@echo "SRC: "$(SRC)
	@echo "VIMRC: "$(VIMRC)
	@echo "VIM_PKGS: "$(VIM_PKGS)
	@echo "INSTALL: "$(INSTALL)
	@echo "CP: "$(CP)
	@echo "PATCH: "$(PATCH)

# checks for dependencies
check:
	@echo Checking for 'git' availability
	@test "$(GIT)" != "" || (echo "Missing 'git' command. Needed to patch syntastic PHP files. Please install git first"; exit 1 )
	@echo Checking for 'ack' availability
	@test "$(ACK)" != "" || (echo "Missing 'ack' command. Please install"; exit 2 )

# install .vimrc and .vim/ files and packages
install-vim: 
	@echo "Installing .vimrc (backing up original) ...."
	$(INSTALL) -b $(VIMRC) $(prefix)
	@echo "Installing .vim directory files ...."
	@for d in $(VIM_DIRS) ; do \
		echo "-> "$$d ; \
		! test -d $(prefix)/.vim/$$d && $(MKDIR) -p $(prefix)/.vim/$$d ; \
		$(CP) -rf $(SRC)/.vim/$$d/* $(prefix)/.vim/$$d/ ; \
	done
	@echo "Installing vim packages ...."
	@for f in $(VIM_PKGS) ; do \
		echo "-> "$$f ; \
		if [ -f $(VIM_PKG_SRC)/$$f ]; then \
			$(CP) -f $(VIM_PKG_SRC)/$$f $(prefix)/.vim/bundle/ ; \
		else \
			! test -d $(prefix)/.vim/bundle/$$f && $(MKDIR) -p $(prefix)/.vim/bundle/$$f ; \
			$(CP) -rf $(SRC)/.vim/bundle/$$f/* $(prefix)/.vim/bundle/$$f ; \
		fi \
	done
	@echo "Patching syntastic PHP parser ...."
	$(PATCH) -u $(prefix)/.vim/bundle/syntastic/syntax_checkers/php/php.vim $(SRC)/syntastic-php.patch ; \

# dircolors configuration for terminal output
dircolors:
	@echo "Installing solarized colors for terminal ...."
	$(INSTALL) $(SRC)/.dircolors-solarized $(prefix)

# Make sure to backup original dotfiles
install-dotfiles:
	@echo "Installing '.' files in home directory (backing up originals) ...."
	@@for f in $(DOT_FILES) ; do \
		echo "-> " `basename $$f` ; \
		$(INSTALL) -b $$f $(prefix) ; \
	done

install: check install-vim install-dotfiles
	@echo
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
	@echo "===  - To remove the directory terminal colors, simpley comment out the "
	@echo "===    line in .bash_profile that calls 'eval dircolors .dircolors-solarized' "
	@echo "==="
	@echo "=== ----------------------------------------------------------------------"

