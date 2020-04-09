if [ ! -d $HOME/development_backup ]; then
  mkdir $HOME/development_backup
fi
docker build -t milldr/base:latest ./images/base  &&
docker build -t milldr/gcp-developer:latest ./images/gcp-developer &&
docker run -it --rm \
  -v $HOME/.gitconfig:/root/.gitconfig \
  -v /var/run/docker.sock:/var/run/docker.sock \
  -v $HOME/.ssh/:/root/.ssh/ \
  -v $HOME/development_backup:/home/developer/shared \
  milldr/gcp-developer zsh
