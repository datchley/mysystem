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
* vim color themes folder for syntax highlighting

Installation
------------

To install, run the following:

```
$ git clone https://github.com/datchley/mysystem.git
$ cd mysystem
$ git submodule init
$ git submodule update
```

