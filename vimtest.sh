#!/bin/bash
# This is a simple script to copy over my vim settings

#!/bin/bash
# Robert Freiberger
# 10/24/2016
# This is a script to help setup remote hosts for minimal vim use
# To run this on a remote host, use the following command
# $ curl -s https://raw.githubusercontent.com/rfreiberger/Vim-Setup/master/vimsetup.sh | sh


function check_vim_dirs {
  if [ -d "$1" ]
  then
    echo "Found the $1 directory"
  else
    echo "You are missing the $1 directory"
    echo  -e "\033[33;5mCreating the $1 directory\033[0m"
    create_vim_dirs $1

  fi
}

function create_vim_dirs {
  mkdir $1
  if [ -d "$1" ]
  then
    echo "Directory $1 created!"
  else
    echo "Failed to create $1 directory, exiting"
    exit 1
  fi
}

function check_vim_version {
  VIM_VER=`vim --version 2&1>/dev/null`
  if [ $? -eq 0 ]
  then
    echo "Vim is installed"
  else
    echo "Vim is not installed"
  fi
}

check_vim_version

function copy_vim_files {
  echo "Copying over the vimrc file"
  wget -P $HOME https://raw.githubusercontent.com/rfreiberger/Vim-Setup/master/.vimrc
  echo "Done copying over vimrc"
  echo "Copying over the plugin files"
  wget -P $HOME/.vim/colors/molokai https://raw.githubusercontent.com/rfreiberger/Vim-Setup/master/.vim/colors/molokai.vim
  echo "Done copying over colors"
  wget -P $HOME/.vim/autoload/plug.vim https://raw.githubusercontent.com/rfreiberger/Vim-Setup/master/.vim/autoload/plug.vim
  echo "Done copying over the plug file"
  echo "Please run the following to install the plugin's"
  echo "In vim 'PluginInstall'"
}

check_vim_version

check_vim_dirs $HOME/.vim
check_vim_dirs $HOME/.vim/autoload
check_vim_dirs $HOME/.vim/backup
check_vim_dirs $HOME/.vim/bundle
check_vim_dirs $HOME/.vim/colors
check_vim_dirs $HOME/.vim/plugged
check_vim_dirs $HOME/.vim/swap
check_vim_dirs $HOME/.vim/undo

copy_vim_files
