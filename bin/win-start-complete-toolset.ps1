$Service = Test-Path $HOME/development_backup
if (-Not $Service) {New-Item -Path "$HOME" -Name "development_backup" -ItemType "directory"}
docker build -t milldr/complete-devops-toolset:latest ./images/complete-devops-toolset
docker run -it --rm `
  -v $HOME/.gitconfig:/home/developer/.gitconfig `
  -v $HOME/.ssh/:/home/developer/.ssh/ `
  -v $HOME/development_backup:/home/developer/shared `
  milldr/complete-devops-toolset zsh
