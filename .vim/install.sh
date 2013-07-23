#!/bin/sh
# install.sh -- quick install script for packages in this repo

if [ "$HOME" == "" ]; then
	HOME=`echo ~`
fi
WORKINGDIR=`pwd`

# Check for pre-reqs
GIT=`which git`
if [ "$GIT" == "" ]; then
	echo "Missing command. 'git' is required but not found"
	exit 1
fi
ACK=`which ack`
if [ "$ACK" == "" ]; then
	echo "Missing command. 'ack' is required but not found"
	exit 1
fi

function savefile() {
	local file=$1
	if [ -f $file ]; then
		echo -n "Backing up $file to $file.orig ...... "
		# mv $file $file.orig
		echo "done"
	fi
}

function installfile() {
	local src=$1
	local targetdir=$2
	savefile "$2/$1"
	echo -n "Installing $src to $targetdir ...... "
	# cp $src $targetdir/$src
	echo "done"
}

# Setup .vimrc and .bash_profile
# - save original .vimrc and .bash_profile
installfile ".bash_profile" "$HOME"
installfile ".vimrc" "$HOME"

# Copy of .vim directory stuff
if [ ! -d $HOME/.vim ]; then
	mkdir $HOME/.vim
	mkdir $HOME/.vim/bundle
	mkdir $HOME/.vim/plugin
	mkdir $HOME/.vim/autoload
	mkdir $HOME/.vim/colors
else
	cp -r .vim/bundle/plugin/* $HOME/.vim/bundle/plugin/
	cp -r .vim/bundle/colors/* $HOME/.vim/bundle/colors/
	cp -r .vim/bundle/autoload/* $HOME/.vim/bundle/autoload/
	cp -r .vim/bundle/bundle/* $HOME/.vim/bundle/bundle/
fi

# Patch php.vim for Syntastic
cd $HOME/.vim/bundle/syntastic
$GIT apply --ignore-space-change --ignore-whitespace ../syntastic.patch

# Add NerdTree-ack plugin to NerdTree bundle
cd $WORKINGDIR
cp .vim/bundle/NERD_tree-ack.vim $HOME/.vim/bundle/nerdtree/nerdtree_plugin/

