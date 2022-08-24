#!/bin/bash

## ################################################## ##
## ┌────────────────────────────────────────────────┐ ##
## │ This code should be called from .gitlab-ci.yml │ ##
## └────────────────────────────────────────────────┘ ##
## ################################################## ##

docker login -u oauth2accesstoken -p "$(google-cloud-sdk/bin/gcloud auth print-access-token)" $CI_REGISTRY