#!/bin/bash
set -e

read -p "Go (y/n) " -n 1 -r
echo

if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    echo "exit"
    exit 1
fi

sudo apt update

echo "---------- git ----------"
git --version
sudo apt install -y git-email
if [ -f ~/.gitconfig]; then
	mv ~/.gitconfig ~/.gitconfig.dotfilebak
fi

ln -sf ~/dotfiles/.gitconfig ~/.gitconfig
echo "git config 🧙"
echo "----------     ----------"

echo "---------- vim ----------"
if ! command -v vim &> /dev/null; then
	sudo apt install -y vim
fi
vim --version | head -n 1
echo "vim installing 🧙"

if [ ! -f ~/.vimrc ]; then
	mv ~/.vimrc ~/.vimrc.dotfilebak
fi
ln -sf ~/dotfiles/.vimrc ~/.vimrc
echo "vim config 🧙"
echo "----------   ----------"

echo "---------- tmux ----------"
if ! command -v tmux &> /dev/null; then
        sudo apt install -y tmux
fi
echo "tmux installing 🧙"

if [ ! -f ~/.tmux.conf ]; then
        mv ~/.tmux.conf ~/.tmux.conf.dotfilebak
fi
ln -sf ~/dotfiles/.tmux.conf ~/.tmux.conf
echo "tmux config 🧙"
echo "----------    ----------"

echo "---------- workspace ----------"
if [ -f ~/workspace/workspace_yadro.txt ]; then
	mv ~/workspace/workspace_yadro.txt ~/workspace/workspace_yadro.txt.dotfilebak
else
	mkdir -p ~/workspace
fi

ln -sf ~/dotfiles/workspace_yadro.txt ~/workspace/workspace_yadro.txt
echo "----------           ----------"

echo "---------- ssh ----------"
if ! command -v ssh &> /dev/null; then
        sudo apt install -y openssh-client
fi
echo "ssh installing 🧙"

mkdir -p ~/.ssh
chmod 700 ~/.ssh

if [ -f ~/.ssh/id_rsa ]; then
        mv ~/.ssh/id_rsa ~/.ssh/id_rsa.dotfilebak
        mv ~/.ssh/id_rsa.pub ~/.ssh/id_rsa.pub.dotfilebak
        ssh-keygen -t rsa
fi

echo " id_rsa.pub for GitHub/GitLab/??"
echo "VVvvvvVV"
cat ~/.ssh/id_rsa.pub
echo "^^^^^^^^"
echo "ssh id_rsa 🧙"

if [ -f ~/.ssh/config]; then
        mv ~/.ssh/config ~/.ssh/config.dotfilebak
fi

ln -sf ~/dotfiles/.ssh/config ~/.ssh/config
chmod 600 ~/.ssh/config
echo "ssh config 🧙"
echo "----------     ----------


find ~ -name "*.dotfilebak*" -type f 
echo "Dotefiles installed"
