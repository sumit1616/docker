# Decision 1: Used Alpine as base image. 
# Advantages: 1) Minimal size, 2) More secure and 3) Fast processing.
# Drawbacks: 1) Smaller community support and 2) All dependencies have to be explicitly included

# Decision 2: Used explicit Alpine version instead of latest tag. 
# Advantages: 1) Safer as the baseline won't change without knowledge, 2) Docker will re-use the base image saving build time and space.
# Drawbacks: 1) Docker files will have to be manually maintained to use the latest compatible version.

FROM alpine:3.7

# Update and install dependencies. Dependencies could also be maintained in requiremente.txt and referenced for installation.
# Decision 3: Combined several RUN commands into one, used no-cache and --virtual options. [This is for part2]
# Advantages: 1) Reduce image size. Individual RUN commands create separate layers, 2) --no-cache option does not cache the index locally, removes (/var/cache/apk/*) post installation.
# Drawbacks: 1) In case we add a new library, we will have to rebuild the entire image.

RUN apk add --update --no-cache python3 py3-pip \
	&& pip3 install --upgrade --no-cache-dir pip \
	&& pip3 install --no-cache-dir flask

# --virtual option is used to mark some packages as virtual which can later be deleted as one group. Otherwise use apk del.

RUN apk add --no-cache --virtual .build-deps python3-dev \
	&& apk del .build-deps
	
COPY app/coin_flip.py /app/coin_flip.py

WORKDIR /app

# Set Environment Variable for flask.
ENV FLASK_APP=coin_flip.py

# Decision 4: Exposed application's port as 7777 instead of default flask port 5000.
# Advantages: 1) No interference in case there's another flask application running on the same host at the default port 5000.

EXPOSE 7777

# Run the application
# Decision 5: Used 0.0.0.0 as host instead of default localhost.
# Advantages: 1) To make the flask application accessible from outside the host machine.

CMD ["flask", "run", "--host=0.0.0.0", "--port=7777"]