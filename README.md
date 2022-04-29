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
