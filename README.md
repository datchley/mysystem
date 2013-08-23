mysystem
========

My usual configs, scripts, etc for my *nix/OS X machines I work on. Downloading this
directly to your home directory and running the install script will setup the following:

* .vimrc - customized vimrc (commented) to work with Pathogen and plugins included
* .bash_profile - a custom bash profile
* vim plugins - vim plugins and .vim/ directory things
	- Syntastic - syntax highlighting and lint for most languages
	- NerdTree & NerdTree Tabs - for project/navigation within vim
	- Ack - For fast searching of file, buffer and other content (integrated into NerdTree with 'ms' command)
	- CtrlP - Ctrl-P like fuzzy finder popup similar to Sublime's Ctrl-P
	- Vim Airline - a pure vim powerline drop in for an awesome status line in vim
	- Solarized color scheme
	- Fugitive - git integration for vim
* vim color themes folder for syntax highlighting

Installation
------------

To install, run the following:

```
$ git clone https://github.com/datchley/mysystem.git
$ cd mysystem
$ git submodule init
$ git submodule update
$ make install
```

iTerm2 Color Scheme
-------------------

You can install the Solarized color scheme for iTerm2 as follows:

1. In iTerm2, open “iTerm2 > Preferences > Profiles > Colors”, and click “Load Presets…”
2. Select the file "Solarized Dark.itermcolors.xml in the src/ of this repository

External Requirements
---------------------

The only thing you'll need outside of this repository is the Ack program, which you
can find at http://beyondgrep.com/

