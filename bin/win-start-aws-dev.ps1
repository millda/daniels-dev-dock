$DIR=$Env:DEV
$Service = Test-Path $DIR/development_backup
if (-Not $Service) {New-Item -Path "$DIR" -Name "development_backup" -ItemType "directory"}
docker pull milldr/base:latest 
docker build -t milldr/aws-developer:latest ./images/aws-developer &&
docker run -it --rm `
  -v $DIR/.ssh/:/home/developer/.ssh/ `
  -v $DIR/.aws/:/home/developer/.aws/ `
  -v $DIR/development_backup:/home/developer/shared `
  milldr/aws-developer zsh
