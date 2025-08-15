#!/bin/bash
# This script deploys the website files to an Azure App Service.
# Author: Arnold Lara
# Date: 2025-08-15
# Usage: ./update-website.sh

# Load app details from the terraform output file
APP_NAME=$(cat ../terraform/app_details.txt | grep app_name | awk -F= '{print $2}')
RESOURCE_GROUP=$(cat ../terraform/app_details.txt | grep group_name | awk -F= '{print $2}')

# Print the loaded values for verification
echo "Using App Name: $APP_NAME"
echo "Using Resource Group: $RESOURCE_GROUP"

# Check if the variables were loaded correctly
if [ -z "$APP_NAME" ] || [ -z "$RESOURCE_GROUP" ]; then
  echo "ERROR: App name or Resource group is not set. Please ensure terraform has been applied and the app_details.txt file exists."
  exit 1
fi

# Navigate to the project directory
cd ..

# Zip the website files
echo "Zipping website files..."
zip website.zip index.html styles.css app.js

# Deploy the zipped website to Azure App Service
echo "Deploying website to Azure App Service..."
echo "az webapp deploy --resource-group $RESOURCE_GROUP --name $APP_NAME --src-path website.zip"

az webapp deploy --resource-group $RESOURCE_GROUP --name $APP_NAME --src-path website.zip

# Clean up the zip file
echo "Cleaning up..."
rm website.zip

echo "Deployment complete."