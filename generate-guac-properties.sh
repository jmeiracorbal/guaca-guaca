#!/bin/bash

set -e

# Export variables from .env file to the actual environment
export $(grep -v '^#' .env | xargs)

# Persist the data on the guacamole home
mkdir -p data/guac_home

# Load the guacamole.properties from template
envsubst < data/guac_home/guacamole.properties.template > data/guac_home/guacamole.properties

echo "File guacamole.properties correctly generated into data/guac_home/"