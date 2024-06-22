#!/usr/bin/env bash

set -e

source ./config.sh

#
# Create the Administration Project if it does not exist
#
p_exists=$(gcloud projects list --filter="projectId:${PROJECT_ID}" --format="value(projectId)")
if [[ -n "${p_exists}" ]]; then
    echo "Google Cloud Project ID [${PROJECT_ID}] already exists."
else
    gcloud projects create "${PROJECT_ID}" --name="${PROJECT_NAME}"
fi

#
# Link the Project to the Billing Account
#
if [[ -z "${BILLING_ACCOUNT_ID}" ]]; then
    echo "ERROR: Environment variable BILLING_ACCOUNT_ID is unset! export and try again..."
    exit 1
fi
gcloud beta billing projects link "${PROJECT_ID}" --billing-account="${BILLING_ACCOUNT_ID}"


#
# Set up the centralized Terraform State Bucket
#
bucket_exists=$(gsutil ls -p "${PROJECT_ID}" | grep "gs://${BUCKET_NAME}/" || /usr/bin/true)
if [[ -n "${bucket_exists}" ]]; then
    echo "Bucket [${BUCKET_NAME}] already exists."
else
    gcloud storage buckets create "gs://${BUCKET_NAME}" \
        --project="${PROJECT_ID}" \
        --location="${BUCKET_LOCATION}" \
        --uniform-bucket-level-access

    gsutil versioning set on "gs://${BUCKET_NAME}"
fi

echo "Project bootstrap complete!"
echo

