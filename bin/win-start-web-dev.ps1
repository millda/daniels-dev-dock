# In windows just pull the latest from docker

$Service = Test-Path $HOME/development_backup
if (-Not $Service) {New-Item -Path "$HOME" -Name "development_backup" -ItemType "directory"}
docker build -t milldr/web-developer:latest ./images/web-developer
docker run -it --rm `
  -v $HOME/.gitconfig:/home/developer/.gitconfig `
  -v $HOME/.ssh/:/home/developer/.ssh/ `
  -v $HOME/development_backup:/home/developer/shared `
  -p 1313:1313 `
  milldr/web-developer zsh
