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
# Set up the Terraform Service Account
#
sa_exists=$(gcloud iam service-accounts list --project=${PROJECT_ID} --filter="email:${SA_EMAIL}" --format="value(email)" 2>/dev/null)
if [[ -n "${sa_exists}" ]]; then
    echo "Service Account [${SA_EMAIL}] already exists."
else
    gcloud iam service-accounts create ${SA_NAME} --display-name=${SA_DISP} --project=${PROJECT_ID}
fi

#
# Set up IAM
#
gcloud projects add-iam-policy-binding ${PROJECT_ID} \
  --member="serviceAccount:${SA_EMAIL}" \
  --role="roles/owner" \
  --quiet >/dev/null

if [[ -z "${BILLING_ACCOUNT_ID}" ]]; then
    echo "ERROR: Environment variable BILLING_ACCOUNT_ID is unset! export and try again..."
    exit 1
fi
gcloud billing accounts add-iam-policy-binding ${BILLING_ACCOUNT_ID} \
  --member="serviceAccount:${SA_EMAIL}" \
  --role="roles/billing.costsManager" \
  --quiet >/dev/null

#
# Set up the key
#
mkdir -p $(dirname "${KEY_PATH}")

# Fetch old key IDs
key_ids=$(gcloud iam service-accounts keys list --iam-account ${SA_EMAIL} --format="value(name)" --managed-by=user)

# Create a new key
gcloud iam service-accounts keys create ${KEY_PATH} --iam-account ${SA_EMAIL}

# Delete old keys
for key_id in ${key_ids}; do
    echo "Deleting key ID [${key_id}]"
    gcloud iam service-accounts keys delete ${key_id} --iam-account ${SA_EMAIL} --quiet
done
echo "Old keys deleted successfully"

echo
echo "Terraform Service Account setup complete!"

