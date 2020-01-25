if [ ! -d $HOME/developement_backup ]; then
  mkdir $HOME/development_backup
fi
docker build -t devenv ~/env
docker run -it --rm \
  -v $HOME/.gitconfig:/root/.gitconfig \
  -v /var/run/docker.sock:/var/run/docker.sock \
  -v $HOME/.ssh/:/root/.ssh/ \
  -v $HOME/development_backup:/home/developer/shared \
  devenv zsh
