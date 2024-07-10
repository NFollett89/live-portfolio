#!/usr/bin/env bash
#
# MIT License
#
# Copyright 2024 Nick Follett
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.
#


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

