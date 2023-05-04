#!/bin/bash

# Variables
QUAY_API_URL="https://your-quay-instance/api/v1"
QUAY_USERNAME="your-username"
QUAY_PASSWORD="your-password"
REMOTE_REGISTRY_URL="https://your-remote-registry"
REMOTE_REGISTRY_USERNAME="remote-registry-username"
REMOTE_REGISTRY_PASSWORD="remote-registry-password"
MIRROR_NAME="my-mirror"

# Authenticate to Quay
auth_response=$(curl -s -u "${QUAY_USERNAME}:${QUAY_PASSWORD}" -XPOST "${QUAY_API_URL}/users/login")
token=$(echo "${auth_response}" | jq -r '.token')

# Create Mirror
create_mirror_data=$(cat <<EOF
{
  "remote_repository": "${REMOTE_REGISTRY_URL}",
  "remote_username": "${REMOTE_REGISTRY_USERNAME}",
  "remote_password": "${REMOTE_REGISTRY_PASSWORD}",
  "description": "Mirror for ${REMOTE_REGISTRY_URL}",
  "enabled": true
}
EOF
)

create_mirror_response=$(curl -s -XPOST -H "Content-Type: application/json" -H "Authorization: Bearer ${token}" -d "${create_mirror_data}" "${QUAY_API_URL}/repository/${MIRROR_NAME}/mirror")

# Check if mirror creation was successful
if [[ "$(echo "${create_mirror_response}" | jq -r '.status')" == "ok" ]]; then
  echo "Mirror created successfully!"
else
  error_message=$(echo "${create_mirror_response}" | jq -r '.error_message')
  echo "Failed to create mirror. Error: ${error_message}"
fi

Before running the script, make sure to replace the following placeholders with your actual values:

- `QUAY_API_URL`: The URL of your Red Hat Quay instance's API.
- `QUAY_USERNAME` and `QUAY_PASSWORD`: Your Red Hat Quay account credentials.
- `REMOTE_REGISTRY_URL`: The URL of the remote registry you want to mirror.
- `REMOTE_REGISTRY_USERNAME` and `REMOTE_REGISTRY_PASSWORD`: Credentials for the remote registry, if required.
- `MIRROR_NAME`: The name you want to assign to the mirror repository in Quay.

Make sure you have the `curl` command-line tool and `jq` JSON processor installed on your system to run this script successfully. You can modify the script to suit your specific requirements or add error handling as needed.
