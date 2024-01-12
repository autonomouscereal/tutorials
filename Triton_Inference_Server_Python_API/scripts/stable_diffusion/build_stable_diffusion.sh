#!/bin/bash

SOURCE_DIR=$(dirname "$(readlink -f "$0")")
DOCKERFILE=${SOURCE_DIR}/docker/Dockerfile

if [ -z "$HF_TOKEN" ]; then
    echo "Please set environment variable HF_TOKEN"
    exit 1
fi


docker run --pull missing --gpus all -it --rm --network host --shm-size=10G --ulimit memlock=-1 --ulimit stack=67108864 -e HF_TOKEN -v $SOURCE_DIR:/mount nvcr.io/nvidia/pytorch:23.12-py3 /bin/bash -c /mount/export_and_convert.sh
