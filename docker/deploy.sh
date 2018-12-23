#!/bin/bash

# ensure running bash
if ! [ -n "$BASH_VERSION" ];then
    echo "this is not bash, calling self with bash....";
    SCRIPT=$(readlink -f "$0")
    /bin/bash $SCRIPT
    exit;
fi

# Setup for relative paths.
SCRIPT=$(readlink -f "$0")
SCRIPTPATH=$(dirname "$SCRIPT") 
cd $SCRIPTPATH

# load the variables from the relative path
source $SCRIPTPATH/env

# Check required environment variables.
REQUIRED_ENV_VARS=()
REQUIRED_ENV_VARS+=("ENVIRONMENT")
REQUIRED_ENV_VARS+=("DB_HOST")
REQUIRED_ENV_VARS+=("DB_USER")
REQUIRED_ENV_VARS+=("DB_PASSWORD")
REQUIRED_ENV_VARS+=("DB_NAME")
REQUIRED_ENV_VARS+=("PROJECT_NAME")

for i in "${REQUIRED_ENV_VARS[@]}"
do
    if [[ ! -v $i ]]; then
        echo "Missing required environment variable: $i";
        exit 1
    fi
done

source 

# Deploy a MySQL container for the validator to use.
docker run -d \
  --name="mysql" \
  --restart=always \
  -p 3306:3306 \
  -e MYSQL_DATABASE=$DB_NAME \
  -e MYSQL_USER=$DB_USER \
  -e MYSQL_PASSWORD=$DB_PASSWORD \
  -e MYSQL_ROOT_PASSWORD=$DB_ROOT_PASSWORD \
  -v $HOME/volumes/mysql:/var/lib/mysql \
  mysql:5.7





if false; then
    CONTAINER_IMAGE="`echo $REGISTRY`/`echo $PROJECT_NAME`"
    docker pull $CONTAINER_IMAGE
else
    CONTAINER_IMAGE=$PROJECT_NAME
fi

# Kill the site if it is already running.
# e.g. we are replacing the container
docker kill $PROJECT_NAME
docker rm $PROJECT_NAME


# Now start our site container.
docker run -d \
  -p 80:80 \
  --restart=always \
  --name="$PROJECT_NAME" \
  $CONTAINER_IMAGE
