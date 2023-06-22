#!/bin/bash
clone_repository() {
    git clone https://github.com/inspiring71/etcr-infrastructure.git --depth=1
}
# Retry loop
max_attempts=5
attempt=1
failureSleep=2

cd /

pwd
apt update 
# log in red
echo -e "\e[31mInstalling the packages\e[0m"
apt install libssl-dev
apt install openjdk-11-jdk -y
apt install -y git
git config --global http.postBuffer 524288000
git config --global https.postBuffer 524288000

echo -e "\e[31mClonning Crawler Repository\e[0m"
mkdir code
cd code


while [[ $attempt -le $max_attempts ]]; do
    echo -e "\e[31mAttempt $attempt: Cloning repository...[0m"
    clone_repository

    # Check the exit status of the clone command
    if [[ $? -eq 0 ]]; then
        echo -e "\e[31mRepository cloned successfully![0m"
        break  # Exit the loop if the command succeeds
    else
        echo -e "\e[31mCloning failed. Retrying...[0m"
        attempt=$((attempt + 1))
        sleep $failureSleep 
    fi
done

echo -e "\e[31mCrawler is cloned!\e[0m"

pwd
cd etcr-infrastructure
mkdir logs
echo -e "\e[31mRunning the scripts!\e[0m"
source ./createdbs.sh
source ./crawl.sh