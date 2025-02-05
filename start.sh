#!/bin/bash

# run this command before 
#sudo chmod +x start.sh


#Now, when you run the script (./start.sh), it will stop any running Redis container and then start up your docker-compose services.




# Stop any existing Redis container before starting Docker Compose
docker ps -q --filter "ancestor=redis" | xargs -I {} docker stop {}

# Start the Docker Compose services
docker-compose up -d
