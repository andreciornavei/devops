#!/bin/bash

## ################################################## ##
## ┌────────────────────────────────────────────────┐ ##
## │ This code should be called from .gitlab-ci.yml │ ##
## └────────────────────────────────────────────────┘ ##
## ################################################## ##

rancher login $CI_RANCHER_URL --skip-verify --token $CI_RANCHER_TOKEN --context $CI_RANCHER_CONTEXT
rancher context current