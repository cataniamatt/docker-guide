# Testing Docker and Docker containers
In this project a Docker image will be built and then used to create multiple containers of a simple Flask web app.

## Building a Docker image
This section will cover all the commands and prerequisites required to build a custom Docker image from scratch.
### Prerequisites
* Docker
* Dockerfile
* .dockerignore
* requirements.txt

#### Docker
Docker can be installed on a Linux machine using:
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
This is a text file that contains a list of all packages used by the project. This text file can be created by executing the command 'pip freeze' and saving the standard output in a text file called 'requirements.txt'.
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