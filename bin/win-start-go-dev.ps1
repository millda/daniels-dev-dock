$DIR=$Env:DEV
$Service = Test-Path $DIR/development_backup
if (-Not $Service) {New-Item -Path "$DIR" -Name "development_backup" -ItemType "directory"}
docker build -t milldr/base:latest ./images/base &&
docker build -t milldr/go-developer:latest ./images/go-developer &&
docker run -it --rm `
  -v $DIR/.ssh/:/home/developer/.ssh/ `
  -v $DIR/.aws/:/home/developer/.aws/ `
  -v $DIR/development_backup:/home/developer/shared `
  milldr/go-developer zsh
