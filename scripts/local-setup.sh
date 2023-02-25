#!/bin/bash
set -e

ATLANTIS_VERSION=v0.19.4

echo "Download atlantis lib"
curl -LO https://github.com/runatlantis/atlantis/releases/download/${ATLANTIS_VERSION}/atlantis_darwin_amd64.zip
unzip atlantis_darwin_amd64.zip

echo "Download ngrok"
curl -LO https://bin.equinox.io/c/4VmDzA7iaHb/ngrok-stable-darwin-amd64.zip
unzip ngrok-stable-darwin-amd64.zip

echo "Generate random secret string"
echo $(openssl rand -hex 10)
