#!/bin/bash

# git
ln -sf ~/dotfiles/.gitconfig ~/.gitconfig

# ssh
mkdir ~/.ssh
chmod 700 ~/.ssh
ln -sf ~/dotfiles/.ssh/config ~/.ssh/config
chmod 600 ~/.ssh/config

#workspace
mkdir -P ~/workspace
ln -sf ~/dotfiles/workspace_yadro.txt ~/workspace/workspace_yadro.txt

echo "Dotefiles installed"
