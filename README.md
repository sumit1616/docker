# Docker for Coinflip

 This project is to run Coinflip application as a Docker Container and access it from browser.
 
### Prerequisites
  
 Your PC needs to be installed with docker to use this. Please refer [This page](https://docs.docker.com/install/) for installation instructions.
 
## How to run this.

 1. Switch to repo directory.
 2. Run below command to build Docker image.
 ```
 docker build . -t coinflip
 ```
 3. Run below command to run container with built image.
 ```
 docker run -d -p 8888:8888 coinflip
 ```
 4. To access the application, open Chrome/Firefox or any other we browser and hit below URL.
 ```
 http://192.168.56.130:8888/
 ```
 5. Refresh the page as many times as you want to flip the coin. :)