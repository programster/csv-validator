#!/bin/bash
if ! [ -n "$BASH_VERSION" ];then
    echo "this is not bash, calling self with bash....";
    SCRIPT=$(readlink -f "$0")
    /bin/bash $SCRIPT
    exit;
fi


# Ensure that we are running in this scripts directory
SCRIPT=$(readlink -f "$0")
SCRIPTPATH=$(dirname "$SCRIPT") 
cd $SCRIPTPATH

# Load settings (environment variables)
cp Dockerfile ../.
cp .dockerignore ../.
cd ../.
source .env

#IMAGE_NAME="`echo $REGISTRY`/`echo $PROJECT_NAME`"
IMAGE_NAME=$PROJECT_NAME

# Ask the user if they want to use the docker cache
read -p "Do you want to use a cached build (y/n)? " -n 1 -r
echo ""   # (optional) move to a new line
if [[ $REPLY =~ ^[Yy]$ ]]
then
    docker build --pull --tag="$IMAGE_NAME" .
else
    docker build --pull --no-cache --tag="$IMAGE_NAME" .
fi

# cleanup
rm $SCRIPTPATH/../.dockerignore
rm $SCRIPTPATH/../Dockerfile

# push to the registry
#docker push $IMAGE_NAME

echo "Image bult. You can deploy with:"
echo "docker-compose up"
