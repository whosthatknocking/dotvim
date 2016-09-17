help:
	@echo '  help         default target'
	@echo '  install      install'
	@echo '  clean        clean up'

install:
	@./install.sh

update:
	git submodule foreach git pull --recurse-submodules origin master
	#
	# Source: https://github.com/tpope/vim-pathogen
	# /usr/bin/wget --quiet --no-check-certificate --output-document=pathogen.vim "https://raw.githubusercontent.com/tpope/vim-pathogen/v2.2/autoload/pathogen.vim"
	# https://github.com/douglascrockford/JSLint
	# wget -O jslint-core.js --no-check-certificate "https://raw.githubusercontent.com/douglascrockford/JSLint/master/jslint.js"

clean:
	-rm -fr ~/.vim ~/.vimrc
