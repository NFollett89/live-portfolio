#!/usr/bin/env bash

PROJECT_ID="nflp-admin"
PROJECT_NAME="Administration"
SA_NAME="terraform"
SA_DISP="Terraform Service Account"
SA_EMAIL="${SA_NAME}@${PROJECT_ID}.iam.gserviceaccount.com"
BUCKET_NAME="nflp-tfstate"
BUCKET_LOCATION="us-east1" # Moncks Corner, South Carolina
KEY_PATH="/Users/nfollett/.google-cloud/keys/${PROJECT_ID}/${SA_NAME}.json"
