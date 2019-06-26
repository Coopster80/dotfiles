#!/bin/bash

set -o errexit
set -o nounset
set -o pipefail

usage ()
{
	echo -e "Usage: \n"
	echo -e "\tall\t\t - install all except for work"
	echo -e "\tbash\t\t - install bash configs"
	echo -e "\tgit\t\t - install git configs"
	echo -e "\tvim\t\t - install vim configs"
	echo -e "\ttmux\t\t - install tmux configs"
	echo -e "\twork\t\t - install work configs"
	echo -e "\tusage\t\t - print this message\n"
}

all_install ()
{
	bash_install
	git_install
	vim_install
	tmux_install
}

bash_install ()
{
	ln -sf "${HOME}"/dotfiles/bashrc "${HOME}"/.bashrc
	ln -sf "${HOME}"/dotfiles/profile "${HOME}"/.profile
}

git_install ()
{
	ln -sf "${HOME}"/dotfiles/gitconfig "${HOME}"/.gitconfig
}

vim_install ()
{
	ln -sf "${HOME}"/dotfiles/vimrc "${HOME}"/.vimrc
	rm -rf ~/.vim
	curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
	vim -c PlugInstall -c quitall
}

tmux_install ()
{
	ln -sf "${HOME}"/dotfiles/tmux.conf "${HOME}"/.tmux.conf
}

work_install ()
{
	ln -sf "${HOME}"/dotfiles/work-gitconfig "${HOME}"/.work-gitconfig
}

# Print default usage when run without arguments
if [ "$#" -eq 0 ]; then
	usage
	exit 0
fi

# Action parsing
ACTION="$1"
case "${ACTION}" in
	all|bash|git|work|vim|tmux)
		"${ACTION}"_install
		;;
	usage)
		"${ACTION}"
		;;
	*)
		echo -e "Invalid action '""${ACTION}""' specified."
		usage
		exit 1
		;;
esac