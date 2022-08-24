#!/bin/bash

## ################################################## ##
## ┌────────────────────────────────────────────────┐ ##
## │ This code should be called from .gitlab-ci.yml │ ##
## └────────────────────────────────────────────────┘ ##
## ################################################## ##

apk add --update make ca-certificates openssl
apk add --no-cache curl jq git
apk add --update --no-cache build-base python3-dev python3 libffi-dev
update-ca-certificates