#!/bin/bash

## ################################################## ##
## ┌────────────────────────────────────────────────┐ ##
## │ This code should be called from .gitlab-ci.yml │ ##
## └────────────────────────────────────────────────┘ ##
## ################################################## ##

SLACK_MESSAGE=$1
curl -X POST -d "token=${CI_SLACK_BOT_TOKEN}&channel=${CI_SLACK_CHANNEL}&text=${SLACK_MESSAGE}" https://slack.com/api/chat.postMessage