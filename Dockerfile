# syntax=docker/dockerfile:1

# start by pulling the python image
FROM python

# switch working directory
WORKDIR /var/www/test

# copy the requirements file into the image
COPY requirements.txt requirements.txt

# install the dependencies and packages in the requirements file
RUN pip install -r requirements.txt

# copy every content from the local file to the image
COPY . .

# configure the container to run in an executed manner
ENTRYPOINT [ "python" ]

CMD ["run.py" ]
