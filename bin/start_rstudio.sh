#!/bin/bash

# change port to avoid conflict with other running projects
PORT=8789

# spin up the container
docker run -d -p $PORT:8787 -v $(pwd):/home/rstudio -e DISABLE_AUTH=true local/rstudio

echo "RStudio running on localhost:$PORT"
