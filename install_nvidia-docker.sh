#/bin/bash
# install packages to allow apt to use a repository over HTTPS:
sudo apt-get -y install \
apt-transport-https ca-certificates curl software-properties-common
# add Docker’s official GPG key:
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add - 
# set up the Docker stable repository.
sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"
# update the apt package index:
sudo apt-get -y update
# finally, install docker
sudo apt-get -y install docker-ce

curl -s -L https://nvidia.github.io/nvidia-container-runtime/gpgkey | \
  sudo apt-key add -
curl -s -L https://nvidia.github.io/nvidia-container-runtime/ubuntu16.04/amd64/nvidia-container-runtime.list | \
  sudo tee /etc/apt/sources.list.d/nvidia-container-runtime.list
  
curl -s -L https://nvidia.github.io/nvidia-docker/ubuntu16.04/amd64/nvidia-docker.list \
|   sudo tee /etc/apt/sources.list.d/nvidia-docker.list

sudo apt-get update

sudo apt-get -y install nvidia-container-runtime
sudo apt-get -y install nvidia-docker2
sudo pkill -SIGHUP dockerd
