#!/bin/bash

DESTINATION=$1

if [ -z "$DESTINATION" ]; then
    echo "Usage: $0 <destination>"
    exit 1
fi

# check if venv exists
if [ ! -d "venv" ]; then
    python3 -m venv --system-site-packages venv
    source venv/bin/activate
    echo 'test -z "$VIRTUAL_ENV" && source' "$DESTINATION/venv/bin/activate" >> /home/jupyter/.zshrc
else
    source venv/bin/activate
fi
