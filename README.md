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
 3. Run the below command to run the container. By default container runs as root user. To run it as non-root user (more secure), add --u#### parameter and set #### to user id.
 ```
 docker run -d -p 7777:7777 coinflip
 ```
 4.a To access the service from the host machine, open the below URL on a web browser on the host machine.
 ```
 http://localhost:7777/
 ```
 4.b To access the service from any other machine on the network, open the below URL. Please update x.x.x.x to the IP address of the host machine.
 ```
 http://x.x.x.x:7777/
 ```
 5. Refresh the web page to flip the coin.