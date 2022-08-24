#!/bin/bash

## ################################################## ##
## ┌────────────────────────────────────────────────┐ ##
## │ This code should be called from .gitlab-ci.yml │ ##
## └────────────────────────────────────────────────┘ ##
## ################################################## ##

apk add --update ca-certificates
apk add --update -t deps curl
curl -L https://storage.googleapis.com/kubernetes-release/release/v1.24.3/bin/linux/amd64/kubectl -o /usr/bin/kubectl
chmod +x /usr/bin/kubectl
apk del --purge deps
rm /var/cache/apk/*

wget https://github.com/rancher/cli/releases/download/v2.6.6-rc4/rancher-linux-amd64-v2.6.6-rc4.tar.gz
tar -zxvf rancher-linux-amd64-v2.6.6-rc4.tar.gz
mv ./rancher-v2.6.6-rc4/rancher /usr/bin