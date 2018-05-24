# Decision 1: Used Alpine as base image. 
# Advantages: 1) Minimal size, 2) More secure and 3) Fast processing.
# Drawbacks: 1) Smaller community support and 2) All dependencies have to be explicitly included

# Decision 2: Used explicit Alpine version instead of latest tag. 
# Advantages: 1) Safer as the baseline won't change without knowledge. Latest releases might have breaking changes for the application. Though this will be covered in testing but still high risk.
# 2) Docker will re-use the base image saving build time and space. With latest, the image will change with every release.
# Drawbacks: 1) Docker files will have to be periodically updated to use the latest available compatible version.

FROM alpine:3.7

# Update and install dependencies. We could also maintain all dependencies in requiremente.txt and reference that to install all dependencies.
# --no-cache option allows to not cache the index locally, reducing container size. It removes cache (/var/cache/apk/*) post installation.
# --virtual option is used to mark some packages as virtual which will be deleted later as one group. These packages are usually required for build but not for execution.
# Reduced image size by reducing the number of layers by combining several RUN commands into one.

RUN apk update apk add --no-cache python3 py3-pip \
	&& apk add --no-cache --virtual python3-dev \ 
		&& pip3 install --upgrade pip \
			&& pip3 install flask

			# pip3 install uwsgi

			# Create /app directory and copy script
			# RUN mkdir /app
			COPY app/coin_flip.py /app/coin_flip.py

			# Set the working directory
			WORKDIR /app

			# Set Environment Variable for flask.
			ENV FLASK_APP=coin_flip.py

			# Expose the application's port
			# Decision 3: Used port 7777 instead of default flask port 5000.
			# Advantages: 1) There won't be any issue in case there's another flask application running on the same host at the default port 5000. 

			EXPOSE 7777

			# Run the application
			# Decision 4: Used 0.0.0.0 as host instead of default localhost. Using localhost(127.0.0.1), application will be accessible only from the host machine whereas using 0.0.0.0 means it will be accessible from other machines on the local network.
			# Advantages: 1) To make the flask application accessible from outside the docker container.


			# Delete the build dependencies to reduce the image size
			CMD ["flask", "run", "--host=0.0.0.0", "--port=7777"]

