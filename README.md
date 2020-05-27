# Personalized Developer Environment

A consistent developer environment with all my preferred tools and configurations to simplify working between many computers.


## Basic Use

1. Clone this repo: `git clone https://github.com/milldr/daniels-dev-dock.git`
2. Run whatever shell script in `./bin/`
3. Code away :nerd_face:

The start script will create a shared directory under `~/development_backup` and save all work there (unix). For windows I'm saving to my F drive because my home directory is full, which is set by an env var $DEV. Change it to whatever you want in script

## Windows Note

Development and using Vim is really frustrating in Windows. With these images, you can just install Docker and ConEmu and then run everything in a container. Make sure you disable keybindings in ConEmu. Also I recommend using GVim outside of the container

## References

Credit to my brother for the idea: https://github.com/sjmiller609/devops_environment
