#!/usr/bin/env bash
# This script loops through each file in the template folder,
# applies envsubst, and writes the output to the base folder.

TEMPLATE_DIR="template"
OUTPUT_DIR="base"

# Create the output directory if it doesn't exist
mkdir -p "$OUTPUT_DIR"

# Define only the variables we want to substitute
ENVSUBST_VARS='$API_DOMAIN $DASHBOARD_DOMAIN $WEB_HOSTING_BASE_DOMAIN $DEPLOY_ENV $MINIO_ROOT_USER $MINIO_ROOT_PASSWORD'

for file in "$TEMPLATE_DIR"/*; do
    filename=$(basename "$file")
    envsubst "$ENVSUBST_VARS" < "$file" > "$OUTPUT_DIR/$filename"
    echo "Processed $file -> $OUTPUT_DIR/$filename"
done

