#!/bin/bash

## ################################################## ##
## ┌────────────────────────────────────────────────┐ ##
## │ This code should be called from .gitlab-ci.yml │ ##
## └────────────────────────────────────────────────┘ ##
## ################################################## ##

docker build --pull -f Dockerfile \
--build-arg NODE_ENV=$ENVIRONMENT \
--build-arg ADMIN_JWT_SECRET=$ADMIN_JWT_SECRET \
--build-arg GCS_SERVICE_ACCOUNT=$GCS_SERVICE_ACCOUNT \
--build-arg GCS_BUCKET_NAME=$GCS_BUCKET_NAME \
--build-arg DB_HOST=$DB_HOST \
--build-arg DB_PORT=$DB_PORT \
--build-arg DB_NAME=$DB_NAME \
--build-arg DB_USER=$DB_USER \
--build-arg DB_PASS=$DB_PASS \
--build-arg DB_SSL=$DB_SSL \
--build-arg PORTAL_URL=$PORTAL_URL \
--build-arg SENTRY_DSN=$SENTRY_DSN \
--build-arg MAUTIC_CONTACT_FORM_ID=$MAUTIC_CONTACT_FORM_ID \
--build-arg MAUTIC_ESTIMATION_FORM_ID=$MAUTIC_ESTIMATION_FORM_ID \
--build-arg MAUTIC_INTERESTED_PARTNER_FORM_ID=$MAUTIC_INTERESTED_PARTNER_FORM_ID \
--build-arg GOOGLE_ADS_CLI_ID=$GOOGLE_ADS_CLI_ID \
--build-arg GOOGLE_ADS_CLI_SECRET=$GOOGLE_ADS_CLI_SECRET \
--build-arg GOOGLE_ADS_DEV_TOKEN=$GOOGLE_ADS_DEV_TOKEN \
--build-arg GOOGLE_ADS_CALLBACK_URL=$GOOGLE_ADS_CALLBACK_URL \
--build-arg GOOGLE_ADS_CUSTOMER_ID=$GOOGLE_ADS_CUSTOMER_ID \
--build-arg GOOGLE_ADS_CAMPAIGN_ID=$GOOGLE_ADS_CAMPAIGN_ID \
-t $CI_REGISTRY/$CI_RANCHER_WORKLOAD:$VERSION .