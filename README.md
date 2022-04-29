# Testing Docker and Docker containers
In this project a Docker image will be built and then used to create multiple containers of a simple Flask web app.

## Building a Docker image
This section will cover all the commands and prerequisites required to build a custom Docker image from scratch.
### Prerequisites
* Docker installed on the local machine
* Dockerfile - Commands how the Docker image will be built.
* .dockerignore - Outlines which files should be ignored when building the image.
* requirements.txt - Lists of all project dependencies.

After Docker is installed and all of the prerequisite files have been created, the Docker image can be created by using the following command in the root directory of the project:
```
docker build -t docker-test .
```
The '-t' tag is used to create a custom name for the image, in this case the name chosen is docker-test.
