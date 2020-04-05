#!/bin/bash

rm -f ./.bashrc && cp ~/.bashrc ./.bashrc
rm -f ./.vimrc && cp ~/.vimrc ./.vimrc
rm -f ./.zshrc && cp ~/.zshrc ./.zshrc
rm -f ./.fzf.zsh && cp ~/.fzf.zsh ./.fzf.zsh
rm -rf ./.oh-my-zsh && cp -r ~/.oh-my-zsh ./.oh-my-zsh
rm -rf ./.z && cp -r ~/.z ./.z
rm -rf ./.vim && cp -r ~/.vim ./.vim
