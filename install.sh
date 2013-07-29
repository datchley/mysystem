#!/bin/sh
# install.sh -- quick install script for packages in this repo


if [ "$HOME" == "" ]; then
	HOME=`echo ~`
fi
WORKINGDIR=`pwd`
SRC=$WORKINGDIR"/src"
INSTALLDIR=$HOME

# Check for pre-reqs
GIT=`which git`
if [ "$GIT" == "" ]; then
	/bin/echo "Missing command. 'git' is required but not found"
	exit 1
fi
ACK=`which ack`
if [ "$ACK" == "" ]; then
	/bin/echo "Missing command. 'ack' is required but not found"
	exit 2
fi


function savefile() {
	local file=$1
	if [ -f $file ]; then
		/bin/echo -n "Backing up $file to $file.orig ...... "
		# mv $file $file.orig
		/bin/echo "done"
	fi
}

function installfile() {
	local src=$1
	local target=$2
	savefile "$2/$1"
	/bin/echo -n "Installing $src to $target ...... "
	# cp $src $targetdir/$src
	/bin/echo "done"
}

function escape() {
	/bin/echo $1 | sed 's,/,\/,g'
}

# Setup .vimrc and .bash_profile
# - save original .vimrc and .bash_profile
installfile "$SRC/.bash_profile" "$HOME/.bash_profile"
installfile "$SRC/.gitconfig" "$HOME/.gitconfig"
installfile "$SRC/.vimrc" "$HOME/.vimrc"

# Copy of .vim directory stuff
if [ ! -d $HOME/.vim ]; then
	mkdir $HOME/.vim
	mkdir $HOME/.vim/bundle
	mkdir $HOME/.vim/plugin
	mkdir $HOME/.vim/autoload
	mkdir $HOME/.vim/colors
fi

for file in `find ./src/.vim -type f`; 
do
	installfile $file `/bin/echo $file | sed 's,^.*src,'$(escape $HOME)','`
done

# Apply patch php.vim for Syntastic
cd $HOME/.vim/bundle/syntastic
# $GIT apply --ignore-space-change --ignore-whitespace $SRC/syntastic.patch

# Add NerdTree-ack plugin to NerdTree bundle
cd $WORKINGDIR
# cp $SRC/.vim/bundle/NERD_tree-ack.vim $HOME/.vim/bundle/nerdtree/nerdtree_plugin/

exit 0
