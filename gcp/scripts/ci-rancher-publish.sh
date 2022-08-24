#!/bin/bash

## ################################################## ##
## ┌────────────────────────────────────────────────┐ ##
## │ This code should be called from .gitlab-ci.yml │ ##
## └────────────────────────────────────────────────┘ ##
## ################################################## ##

rancher kubectl set image deployment/$CI_RANCHER_WORKLOAD $CI_RANCHER_WORKLOAD=$CI_REGISTRY/$CI_RANCHER_WORKLOAD:$VERSION -n $CI_RANCHER_NAMESPACE --record --insecure-skip-tls-verify=true