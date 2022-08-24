#!/bin/bash

## ################################################## ##
## ┌────────────────────────────────────────────────┐ ##
## │ This code should be called from .gitlab-ci.yml │ ##
## └────────────────────────────────────────────────┘ ##
## ################################################## ##

echo $CI_GCLOUD_SERVICE_KEY | base64 -d > ${HOME}/gcloud-service-key.json
wget https://dl.google.com/dl/cloudsdk/release/google-cloud-sdk.tar.gz
tar zxvf google-cloud-sdk.tar.gz && ./google-cloud-sdk/install.sh --usage-reporting=false --path-update=true
google-cloud-sdk/bin/gcloud auth activate-service-account --key-file ${HOME}/gcloud-service-key.json
google-cloud-sdk/bin/gcloud config list