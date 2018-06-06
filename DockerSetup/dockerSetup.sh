#!/bin/bash
#@real_slacker007

echo "$(tput setaf 2)[Updating Packages]...$(tput sgr0)";
sudo apt-get update -qq && apt-get upgrade -y -qq;

echo "$(tput setaf 2)[Adding Curl]...$(tput sgr0)";
sudo apt-get install curl -qq;
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -;
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable";

echo "$(tput setaf 2)[Updating Repositories]...$(tput sgr0)";
sudo apt-get update -qq;

echo "$(tput setaf 2)[Installing Docker Engine]$(tput sgr0)";
sudo apt-get install -y docker-ce -qq;

