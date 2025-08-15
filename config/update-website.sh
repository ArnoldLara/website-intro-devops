#!/bin/bash

# APP_NAME=${1:-"prod-website-devops"}
# RESOURCE_GROUP=${2:-"prod-website-devops-rg"}

APP_NAME=$1
RESOURCE_GROUP=$2

if [ -z "$APP_NAME" ] || [ -z "$RESOURCE_GROUP" ]; then
  echo "You must provide the app name and resource group."
  echo "Usage: $0 <app-name> <resource-group>"
  exit 1
fi

cd ..

# Zip the website files
zip website.zip index.html styles.css app.js

echo "az webapp deploy --resource-group $RESOURCE_GROUP --name $APP_NAME --src-path website.zip"

az webapp deploy --resource-group $RESOURCE_GROUP --name $APP_NAME --src-path website.zip