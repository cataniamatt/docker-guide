# Testing Docker and Docker containers
In this project a Docker image will be built and then used to create multiple containers of a simple Flask web app.

## Building a Docker image
This section will cover all the commands and prerequisites required to build a custom Docker image from scratch.
### Prerequisites
* Docker installed on the local machine
* Dockerfile : A file with commands on how Docker should build the image. 
* .dockerignore : A file which outlines which files should be ignored when building the image.
* requirements.txt : A text file that lists of all project dependencies

```
python3 -m venv venv
```
Once the virtual environment is created, activate it using:
```
source venv/bin/activate
```

## Project dependencies
All the project dependencies can be installed on the host machine or in the virtual environment using:
```
pip install -r requirements.txt
```
