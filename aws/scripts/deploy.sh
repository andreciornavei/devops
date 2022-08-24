# 1º_ARG = AWS_ID
export AWS_ACCESS_KEY_ID=$1
# 2º_ARG = AWS_SECRET
export AWS_SECRET_ACCESS_KEY=$2
# 3º_ARG = AWS_REGION
export AWS_DEFAULT_REGION=$3

# get aws account id
AWS_ACCOUNT_ID=$(aws sts get-caller-identity --query "Account" --output text)
echo $AWS_ACCOUNT_ID
# define docker image name
DOCKER_IMAGE_NAME=llmatos
# build docker image
docker build --no-cache \
--build-arg ADMIN_JWT_SECRET=${APP_ADMIN_JWT_SECRET} \
--build-arg JWT_SECRET=${APP_JWT_SECRET} \
--build-arg DB_HOST=${APP_DB_HOST} \
--build-arg DB_PORT=${APP_DB_PORT} \
--build-arg DB_NAME=${APP_DB_NAME} \
--build-arg DB_USER=${APP_DB_USER} \
--build-arg DB_PASS=${APP_DB_PASS} \
--build-arg DB_SSL=${APP_DB_SSL} \
--build-arg MAIL_PROVIDER=${APP_MAIL_PROVIDER} \
--build-arg MAIL_USERNAME=${APP_MAIL_USERNAME} \
--build-arg MAIL_PASSWORD=${APP_MAIL_PASSWORD} \
--build-arg MAIL_REGION=${APP_MAIL_REGION} \
--build-arg MAIL_DEFAULT_FROM=${APP_MAIL_DEFAULT_FROM} \
--build-arg MAIL_DEFAULT_REPLY_TO=${APP_MAIL_DEFAULT_REPLY_TO} \
--build-arg STORAGE_PROVIDER=${APP_STORAGE_PROVIDER} \
--build-arg STORAGE_ENDPOINT=${APP_STORAGE_ENDPOINT} \
--build-arg STORAGE_ACCESS_KEY=${APP_STORAGE_ACCESS_KEY} \
--build-arg STORAGE_SECRET_KEY=${APP_STORAGE_SECRET_KEY} \
--build-arg STORAGE_BUCKET=${APP_STORAGE_BUCKET} \
--build-arg STORAGE_BUCKET=${APP_STORAGE_BUCKET} \
--build-arg STORAGE_REGION=${APP_STORAGE_REGION} \
-t ${DOCKER_IMAGE_NAME} .
# check built image
docker images --filter reference=${DOCKER_IMAGE_NAME}
# authenticate to aws ecr
aws ecr get-login-password --region ${AWS_DEFAULT_REGION} | docker login --username AWS --password-stdin ${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_DEFAULT_REGION}.amazonaws.com/${DOCKER_IMAGE_NAME}
# Tag the image to push on aws ecr repository.
docker tag ${DOCKER_IMAGE_NAME}:latest ${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_DEFAULT_REGION}.amazonaws.com/${DOCKER_IMAGE_NAME}:latest
# Push the image
docker push ${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_DEFAULT_REGION}.amazonaws.com/${DOCKER_IMAGE_NAME}:latest
