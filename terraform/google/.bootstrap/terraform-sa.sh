#!/usr/bin/env bash

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
# Give 'roles/editor' to the Service Account
#
gcloud projects add-iam-policy-binding ${PROJECT_ID} \
  --member="serviceAccount:${SA_EMAIL}" \
  --role="roles/editor" \
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
    gcloud iam service-accounts keys delete "${key_id}" --iam-account "${SA_EMAIL}" --quiet
done
echo "Old keys deleted successfully"

echo
echo "Terraform Service Account setup complete!"

