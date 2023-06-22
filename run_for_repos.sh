#!/bin/bash

# Function to check if the pattern is found in the logs
function check_logs {
    docker logs "$crawler_name" | grep -q "$pattern" >> /dev/null
    if [ $? -eq 0 ]; then
        echo "Pattern found in the logs"
        return 0
    else
        echo "Pattern not found in the logs"
        return 1
    fi
}

sleepTime=10
# Load variables from .env file
source .env
source repo_list.env

#list of repos to crawl
set -f                      # avoid globbing (expansion of *).
repos=(${repositories//,/ })
tokens=(${token_list//,/ })

token_num=${#tokens[@]}

# Create db folder if not exist
if [ ! -d $db_folder ]; then
    echo "Creating $db_folder folder"
    mkdir $db_folder
fi
# Spin up the database containers
docker-compose -f db.docker-compose.yml up -d

# sleep to make sure the database is up
sleep 2


for repo in "${repos[@]}"
do
    crawler_name="${repo//\//-}"
    random_index=$((RANDOM % token_num))
    # Select the element at the random index
    random_token=${tokens[random_index]}

    echo "Starting the crawler for $crawler_name with token $random_token"
    repositories=$repo crawler_name=$crawler_name token=$random_token no_build="yes" docker-compose --project-name=$crawler_name  up -d

    pattern="createdb $repo."
    echo "Wait for the docker to reach maturity level from the logs"
    echo "We check pattern '$pattern' in the container logs..."
    while ! check_logs; do
        echo "Sleeping for $sleepTime seconds"
        sleep $sleepTime
    done
done