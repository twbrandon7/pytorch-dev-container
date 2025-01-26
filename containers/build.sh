#!/bin/bash
TAG="torch-2.5.1-cu124-py3.11"
docker build \
    --build-arg PYTORCH_VERSION=2.5.1 \
    --build-arg TORCHVISION_VERSION=0.20.1 \
    --build-arg TORCHAUDIO_VERSION=2.5.1 \
    --build-arg PYTORCH_INDEX_URL=https://download.pytorch.org/whl/cu124 \
    --build-arg PYTHON_VERSION=3.11 \
    -t "twbrandon7/pytorch-dev-container:$TAG" .
