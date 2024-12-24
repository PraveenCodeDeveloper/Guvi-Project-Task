#!/bin/bash
set -x
IMAGE_TAG="latest"
DEV_REPO="praveenkumar/guviapp-dev"
PROD_REPO="praveenkumar/guviapp-prod"
DEV_CONTAINER_NAME="guvi-app-container-dev"
PROD_CONTAINER_NAME="guvi-app-container-prod"
DEV_COMPOSE_FILE="docker-compose-dev.yml"
PROD_COMPOSE_FILE="docker-compose-prod.yml"
BRANCH_NAME="$1"
echo "$BRANCH_NAME"
BRANCH_NAME="${BRANCH_NAME#origin/}"


# Pull and run the correct Docker image
if [[ "$BRANCH_NAME" == "dev" && "$DEV_REPO" == "praveenkumar/guviapp-dev" ]]; then
    docker pull $DEV_REPO:$IMAGE_TAG
    #docker run -d -p 80:80 --name $CONTAINER_NAME $DEV_REPO:$IMAGE_TAG
    # Stop and remove existing container
    docker stop $PROD_CONTAINER_NAME || true
    docker rm $PROD_CONTAINER_NAME || true
    docker stop $DEV_CONTAINER_NAME || true
    docker rm $DEV_CONTAINER_NAME || true
    docker-compose -f $DEV_COMPOSE_FILE up -d

elif [[ "$BRANCH_NAME" == "main" && "$PROD_REPO" == "praveenkumar/guviapp-prod" ]]; then
    docker pull $PROD_REPO:$IMAGE_TAG
    #docker run -d -p 80:80 --name $CONTAINER_NAME $PROD_REPO:$IMAGE_TAG
    # Stop and remove existing container
    docker stop $DEV_CONTAINER_NAME || true
    docker rm $DEV_CONTAINER_NAME || true
    docker stop $PROD_CONTAINER_NAME || true
    docker rm $PROD_CONTAINER_NAME || true
    docker-compose -f $PROD_COMPOSE_FILE up -d
else
    echo "No valid branch for deployment."
fi

