#!/bin/bash
USERNAME="twbrandon7"
IMAGE_NAME="pytorch-dev-container"
TAG="torch-2.5.1-cu124-py3.11"

docker build \
    --build-arg PYTHON_VERSION=3.11 \
    -t "$USERNAME/$IMAGE_NAME:$TAG" .
