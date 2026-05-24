#!/usr/bin/env bash
# Environment bootstrap script for AzureShield
set -e

echo "Checking prerequisites..."

tools=("az" "kubectl" "helm" "trivy" "cosign" "conftest")

for tool in "${tools[@]}"; do
    if ! command -v $tool &> /dev/null; then
        echo "$tool could not be found. Please install it."
        exit 1
    else
        echo "$tool is installed. Version:"
        $tool --version | head -n 1
    fi
done

echo "Checking Azure login status..."
if ! az account show &> /dev/null; then
    echo "Please run 'az login' to authenticate with Azure."
    exit 1
fi

echo "Environment setup complete and verified!"
