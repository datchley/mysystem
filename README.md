mysystem
========

![Screenshot](http://dl.dropboxusercontent.com/s/7xfjn8icglq6ty3/2013-08-28%20at%2010.05%20AM.png?raw=true)

My usual configs, scripts, etc for my Linux/OS X machines I work on. Downloading this
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

iTerm 2 settings in your profile should set the following:

* terminal emulation - xterm-256color
* draw bold text in bright colors - unchecked
* treat ambiguous width chars as double width - unchecked
* set your font to one of the [patched powerline fonts](https://github.com/Lokaltog/powerline-fonts)

![](http://dl.dropboxusercontent.com/s/m8rqula7eahcls1/2013-08-28%20at%2010.03%20AM.png?raw=true)

External Requirements
---------------------

The only thing you'll need outside of this repository is the Ack program, which you
can find at http://beyondgrep.com/

