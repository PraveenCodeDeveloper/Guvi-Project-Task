#!/bin/bash
set -x
IMAGE_NAME="guvi"
IMAGE_TAG="latest"
DEV_REPO="praveenkumar/guviapp-dev"
PROD_REPO="praveenkumar/guviapp-prod"
BRANCH_NAME="$1"
echo "$BRANCH_NAME"
BRANCH_NAME="${BRANCH_NAME#origin/}"
DEV_COMPOSE_FILE="docker-compose-dev.yml"
PROD_COMPOSE_FILE="docker-compose-prod.yml"
# Build Docker image

#docker build -t $IMAGE_NAME:$IMAGE_TAG .

# Push to Docker Hub based on the current branch
if [[ "$BRANCH_NAME" == "dev" && "$DEV_REPO" == "praveenkumar/guviapp-dev" ]]; then
    docker-compose -f $DEV_COMPOSE_FILE --build
    docker tag $IMAGE_NAME:$IMAGE_TAG $DEV_REPO:$IMAGE_TAG
    docker push $DEV_REPO:$IMAGE_TAG
elif [[ "$BRANCH_NAME" == "main" && "$PROD_REPO" == "praveenkumar/guviapp-prod" ]]; then
    docker-compose -f $PROD_COMPOSE_FILE --build
    docker tag $IMAGE_NAME:$IMAGE_TAG $PROD_REPO:$IMAGE_TAG
    docker push $PROD_REPO:$IMAGE_TAG
else
    echo "No valid branch. Image won't be pushed."
fi

