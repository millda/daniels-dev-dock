#!/usr/bin/env python3

import os
from jinja2 import Template

SKIPPED_IMAGES = ["complete-devops-toolset", "web-developer"]


def listdir_nohidden(path):
    for f in os.listdir(path):
        if not f.startswith("."):
            subdir = os.path.join(path, f)
            if f != "base":
                yield f


def main():
    """ There isnt an easy way to build images ontop of each other. 
        Instead we'll just copy the contents from each of the other images
    """
    docker_image_directory = os.path.abspath(
        os.path.join(os.path.dirname(__file__), "..", "images")
    )
    dockerfile_path = os.path.join(
        docker_image_directory, "complete-devops-toolset/Dockerfile"
    )

    images = list(listdir_nohidden(docker_image_directory))

    header = (
        "# Warning: automatically generated file\n"
        + "# Please edit script generate/make_complete_toolset.py\n"
        + "\n\nFROM milldr/base:latest"
    )

    with open(dockerfile_path, "w") as dockerfile:
        dockerfile.write(header)
        for image in images:
            if image not in SKIPPED_IMAGES:
                image_dockerfile_path = os.path.join(
                    docker_image_directory, image, "Dockerfile"
                )
                with open(image_dockerfile_path, "r") as image_dockerfile:
                    dockerfile.writelines(image_dockerfile.read().splitlines(True)[1:])


if __name__ == "__main__":
    main()
