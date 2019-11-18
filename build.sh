#!/bin/bash

# Tag then existing version case "old"
docker tag carlosmonari/jenkins carlosmonari/jenkins:old

# Build then image
docker build --no-cache --tag=carlosmonari/jenkins .
docker push carlosmonari/jenkins

# Delete the old image
docker rmi carlosmonari/jenkins:old
