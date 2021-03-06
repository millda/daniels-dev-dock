$DIR=$Env:DEV
$Service = Test-Path $DIR/development_backup
if (-Not $Service) {New-Item -Path "$DIR" -Name "development_backup" -ItemType "directory"}
docker pull milldr/aws-developer:latest
docker build -t milldr/web-developer:latest ./images/web-developer &&
docker run -it --rm `
  -v $DIR/.ssh/:/home/developer/.ssh/ `
  -v $DIR/.aws/:/home/developer/.aws/ `
  -v $DIR/development_backup:/home/developer/shared `
  -p 1313:1313 `
  milldr/web-developer zsh
