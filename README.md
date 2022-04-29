# Docker Step-by-Step
This repository outlines how Docker can be used to turn a simple web app into a Docker image. This image can then be used to initialise multiple containers that run the web app.

![Docker logo](https://github.com/cataniamatt/docker-test/blob/main/docker.png)


## Building a Docker image
This section will cover all the commands and prerequisites required to build a custom Docker image from scratch.
### Prerequisites
* Docker
* Dockerfile
* .dockerignore
* requirements.txt

#### Docker
Docker can be installed on a Linux machine by using:
```
sudo apt install docker.io
```
If the machine is based on MacOS or Windows, Docker Desktop should be used. Docker Desktop can be installed from the Docker's official website [here](https://docs.docker.com/desktop/).

#### Dockerfile
```
# syntax=docker/dockerfile:1

FROM python

WORKDIR /var/www/test

COPY requirements.txt requirements.txt

RUN pip install -r requirements.txt

COPY . .

ENTRYPOINT [ "python" ]

CMD ["run.py" ]
```
The Dockerfile contains several commands that dictate how the Docker image should be built. 

The first step to create a custom Docker image is always to declare which Docker image will be used to create the custom image. Different images for various operating system and technologies can be found on Docker Hub. If the image declared does not exist on the local machine, it will be downloaded from Docker Hub. 

In this sample text above, the image will be built using the latest version of Python available on Docker Hub.
```
FROM python
```

Next Docker will change the working directory to the directory in which all of the project files will be copied to and the remaining commands will be executed. If the directory specified does not exist, it will be created. In this case a directory called 'docker-test' will be created in the '/var/www' directory.
```
WORKDIR /var/www/docker-test
```

After the project directory is created, the 'requirements.txt' file will be copied to the working directory and then used to install all of the packages that are listed in it.
```
COPY requirements.txt requirements.txt

RUN pip install -r requirements.txt
```

Once all packages are installed, Docker will copy all of the project files inside the root directory on the machine into the working directory of the image.
```
COPY . .
```

At this stage, the programm can be initialised with the required commands using 'ENTRYPOINT' and 'CMD'. In this case, the project is a Flask web app that starts executing using the command 'python run.py'. This starts Flask on port 5000.
```
ENTRYPOINT [ "python" ]

CMD ["run.py" ]
```

#### .dockerignore
This is a file which outlines which files and/or directory should be ignored when building the image. This is similar to a '.gitignore' file. 
```
# Git / Github
.git
.gitignore
README.md

# Docker
Dockerfile
docker-compose.yml
.docker

# Byte-compiled / optimized / DLL files
__pycache__/
*/__pycache__/
*/*/__pycache__/
*/*/*/__pycache__/
*.py[cod]
*/*.py[cod]
*/*/*.py[cod]
*/*/*/*.py[cod]
```

#### requirements.txt
This is a text file that contains a list of all packages used by the project. This text file can be created by executing the command 'pip freeze' and saving the standard output in a text file called 'requirements.txt'. This command can be used within a virtual environment or on a Linux host where the web app exists.
```
pip freeze > requirements.txt
```

### Building the custom image
After Docker is installed and all of the prerequisite files have been created, the Docker image can be created by using the following command in the root directory of the project:
```
docker build -t docker-test .
```
The '-t' tag is used to create a custom name for the image, in this case the name chosen is docker-test. 

Docker will then proceed to build the image:
```
[+] Building 17.7s (16/16) FINISHED
 => [internal] load build definition from Dockerfile                                                             0.1s
 => => transferring dockerfile: 566B                                                                             0.1s
 => [internal] load .dockerignore                                                                                0.1s
 => => transferring context: 1.15kB                                                                              0.0s
 => resolve image config for docker.io/docker/dockerfile:1                                                       4.1s
 => [auth] docker/dockerfile:pull token for registry-1.docker.io                                                 0.0s
 => docker-image://docker.io/docker/dockerfile:1@sha256:91f386bc3ae6cd5585fbd02f811e295b4a7020c23c7691d686830bf  2.6s
 => => resolve docker.io/docker/dockerfile:1@sha256:91f386bc3ae6cd5585fbd02f811e295b4a7020c23c7691d686830bf6233  0.0s
 => => sha256:91f386bc3ae6cd5585fbd02f811e295b4a7020c23c7691d686830bf6233e91ad 2.00kB / 2.00kB                   0.0s
 => => sha256:7c651b7122e7366e15d4ea5327b27111f6862d9b9896383a4a695d3190f3909d 528B / 528B                       0.0s
 => => sha256:edddd0dce574bd03c542d84013e16caf779de32ce2a1c5b402a0bc7405f85b20 2.37kB / 2.37kB                   0.0s
 => => sha256:0f821387874bc19cdfd45922f5ff075fd256356bf3f2baba7fb109d2b3a64bbd 9.93MB / 9.93MB                   1.9s
 => => extracting sha256:0f821387874bc19cdfd45922f5ff075fd256356bf3f2baba7fb109d2b3a64bbd                        0.3s
 => [internal] load .dockerignore                                                                                0.0s
 => [internal] load build definition from Dockerfile                                                             0.0s
 => [internal] load metadata for docker.io/library/python:latest                                                 2.0s
 => [auth] library/python:pull token for registry-1.docker.io                                                    0.0s
 => CACHED [1/5] FROM docker.io/library/python@sha256:edc8e6a550e4be7c340df18b252364554ea46a5ac14be4dcad711c285  0.0s
 => [internal] load build context                                                                                0.0s
 => => transferring context: 251.22kB                                                                            0.0s
 => [2/5] WORKDIR /var/www/test                                                                                  0.1s
 => [3/5] COPY requirements.txt requirements.txt                                                                 0.0s
 => [4/5] RUN pip install -r requirements.txt                                                                    8.1s
 => [5/5] COPY . .                                                                                               0.0s
 => exporting to image                                                                                           0.3s
 => => exporting layers                                                                                          0.3s
 => => writing image sha256:c88e32ba2b2e724a395accd41ef00e9c8938a74a6728327fb5f91353cccc4263                     0.0s
 => => naming to docker.io/library/docker-test                                                                   0.0s
```
## View all Docker images
To view all Docker images on the machine use the following command:
```
docker images -a
```
This will return a list of all images and the following information about each image:
* Repository and image name
* Version tag
* Image ID
* Creation date
* Size

```
REPOSITORY    TAG       IMAGE ID       CREATED          SIZE
docker-test   latest    c511725df600   28 minutes ago   935MB
```

## Deleting a Docker image
An image can only be deleted if no container is using it, so any container must be stopped and deleted to delete the image. Once this is done, issue the following command to delete the image:
```
docker rmi image_name
```

## Running a container
If the image build is successful and there are no errors within the code, a container can be initialised using it. This can be done by executing the following command:
```
docker run -dp 80:5000 image_name
```
The '-d' tag is used to run the container in the detached mode, meaning in the background. The '-p' tag is used to map a port on the local machine to a port on the container. In this case, port 5000 on the container was mapped to port 80 on the local machine.

## View running containers
To view all containers that are running and also those that have stopped issue:
```
docker ps -a
```
This will return a list of all containers and the following information about each container:
* Container ID
* Container image
* Command used to initialise the app
* Creation date
* Status
* Port mappings
* Container name

```
CONTAINER ID   IMAGE         COMMAND           CREATED          STATUS          PORTS                    NAMES
f3e8bad13d01   docker-test   "python run.py"   19 minutes ago   Up 19 minutes   0.0.0.0:443->5000/tcp    compassionate_driscoll
368204a31392   docker-test   "python run.py"   19 minutes ago   Up 19 minutes   0.0.0.0:80->5000/tcp     busy_saha
1d7c9be226b3   docker-test   "python run.py"   20 minutes ago   Up 20 minutes   0.0.0.0:5000->5000/tcp   blissful_einstein
```

## Stopping a running container
To stop a container from running, the container name is required. Unless a name is defined when initialising the container, Docker assings it a random name. To get the container name, list all the containers using 'docker ps -a'. Then run the following command:
```
docker stop container_name
```

## Deleting a container
A container cannot be deleted if it is running, so it must first be stopped using the 'docker stop' command. After it is stopped, it can be removed by using:
```
docker rm container_name
```