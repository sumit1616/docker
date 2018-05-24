# Docker container for Coinflip application by Random Receptacle inc.

 This project is to run the Coinflip application as a Docker Container and access it from the host machine web browser.
 
## Prerequisites:
  
 Docker should be installed on the host machine(s). Please refer [Install docker](https://docs.docker.com/install/) for installation instructions.
 
## How to run the project:

 1. Switch to repo directory.
 2. Run the below command to build the Docker image.
 ```
 docker build -t coinflip .
 ```
 3. If you prefer to run the container as a non-root user then go to Step 4.a else go to step 4.b.
 Please note that it's more secure to run containers as a non-root user. If the container is compromised, a root user can do more damage to the underlying host as they share the same kernel. Default non-root user could also be specified in the dockerfile.
 
 4.a Run the below command to run a container using a non-root user. Replace #### with the non-root user id. Skip step 4.b.
 ```
 docker run -d --restart=always --u#### -p 7777:7777 coinflip
 ```
 4.b Run the below command to run a container using the root user.
 ```
 docker run -d --restart=always -p 7777:7777 coinflip
 ```
 5.a To access the service from the host machine, open the below URL on a web browser on the host machine.
 ```
 http://localhost:7777/
 ```
 5.b To access the service from any other machine on the network, open the below URL. Please update x.x.x.x to the IP address of the host machine.
 ```
 http://x.x.x.x:7777/
 ```
 6. Refresh the web page to flip the coin.