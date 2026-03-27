#!/bin/bash
set -e

INSTALL_SSH=true

while [[ $# -gt 0 ]]; do
	case $1 in
	--help)
		echo "--ssh_install_ex to exclude ssh setup"
		exit 1
		;;
        --ssh_install_ex)
		INSTALL_SSH=false
		shift
		;;
	*)
		echo "Unknown option: $1"
		exit 1
		;;
	esac
done

read -p "Go (y/n) " -n 1 -r
echo

if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    echo "exit"
    exit 1
fi

BACKUP_DATE=$(date +"%d%m%Y_%H%M%S")
echo ${BACKUP_DATE}

sudo apt update
sudo apt upgrade -y

echo "---------- vim ----------"
if ! command -v vim &> /dev/null; then
	sudo apt install -y vim
fi
vim --version | head -n 1

if ! command -v ctag &> /dev/null; then
	sudo apt install -y universal-ctags
fi
ctags --version

echo "vim installing 🧙"

if [ -f ~/.vimrc ]; then
	mv ~/.vimrc ~/.vimrc.${BACKUP_DATE}.dotfilebak
fi
ln -sf ~/dotfiles/.vimrc ~/.vimrc
echo "vim config 🧙"
echo "----------   ----------"

echo "---------- tmux ----------"
if ! command -v tmux &> /dev/null; then
        sudo apt install -y tmux
fi
echo "tmux installing 🧙"

if [ -f ~/.tmux.conf ]; then
        mv ~/.tmux.conf ~/.tmux.conf.${BACKUP_DATE}.dotfilebak
fi
ln -sf ~/dotfiles/.tmux.conf ~/.tmux.conf
echo "tmux config 🧙"
echo "----------    ----------"

echo "---------- workspace ----------"
if [ -f ~/workspace/workspace_yadro.txt ]; then
	mv ~/workspace/workspace_yadro.txt ~/workspace/workspace_yadro.txt.${BACKUP_DATE}.dotfilebak
else
	mkdir -p ~/workspace
fi

ln -sf ~/dotfiles/workspace_yadro.txt ~/workspace/workspace_yadro.txt
echo "----------           ----------"

if [[ ${INSTALL_SSH} == true ]]; then 
	echo "---------- ssh ----------"
	if ! command -v ssh &> /dev/null; then
		sudo apt install -y openssh-client
	fi
	echo "ssh installing 🧙"

	mkdir -p ~/.ssh
	chmod 700 ~/.ssh

	if [ -f ~/.ssh/id_rsa ]; then
		mv ~/.ssh/id_rsa ~/.ssh/id_rsa.${BACKUP_DATE}.dotfilebak
		mv ~/.ssh/id_rsa.pub ~/.ssh/id_rsa.pub.${BACKUP_DATE}.dotfilebak
	fi

	ssh-keygen -t rsa
	echo "ssh id_rsa 🧙"

	if [ -f ~/.ssh/config ]; then
		mv ~/.ssh/config ~/.ssh/config.${BACKUP_DATE}.dotfilebak
	fi

	ln -sf ~/dotfiles/.ssh/config ~/.ssh/config
	chmod 600 ~/.ssh/config
	echo "ssh config 🧙"
	echo "----------     ----------"
fi

echo "---------- git ----------"
git --version
sudo apt install -y git-email
if [ -f ~/.gitconfig]; then
	mv ~/.gitconfig ~/.gitconfig.${BACKUP_DATE}.dotfilebak
fi

ln -sf ~/dotfiles/.gitconfig ~/.gitconfig

git config --global url."git@github.com:".insteadOf "https://github.com/"

echo "git config 🧙"
echo "----------     ----------"

find ~/ -name "*.dotfilebak*" -type f
echo "Dotefiles installed"

cat ~/.ssh/id_rsa.pub
