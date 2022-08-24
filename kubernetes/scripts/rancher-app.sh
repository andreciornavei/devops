#!/usr/bin/env bash
#
NAMESPACE=$1
PROJECT=$2
PORT=$3
EXTERNAL_IP=""
SERVER_DNS=services.fluky.comm.br

echo "- switch to namespace $NAMESPACE"
kubens $1

echo "- API install"

echo '
apiVersion: apps/v1
kind: Deployment
metadata:
  name: '$PROJECT'
  namespace: '$NAMESPACE'
  labels:
    app: '$PROJECT'
spec:
  selector:
    matchLabels:
      app: '$PROJECT'
  replicas: 1
  template:
    metadata:
      labels:
        app: '$PROJECT'
    spec:
      containers:
      - image: nginx
        name: '$PROJECT'
        ports:
        - containerPort: '$PORT'
      restartPolicy: Always
      imagePullSecrets:
        - name: docker-registry                          
---
apiVersion: v1
kind: Service
metadata:
  labels:
    app: '$PROJECT'
  name: '$PROJECT'-service
  namespace: '$NAMESPACE'
spec:
  type: ClusterIP
  ports:
    - port: '$PORT'
  selector:
    app: '$PROJECT'
---
apiVersion: networking.k8s.io/v1beta1
kind: Ingress
metadata:
  name: '$PROJECT'-ingress
  namespace: '$NAMESPACE'
  annotations:
   kubernetes.io/ingress.class: nginx
   cert-manager.io/cluster-issuer: letsencrypt-staging
   ingress.kubernetes.io/service-upstream: "true"
   nginx.ingress.kubernetes.io/ssl-redirect: "false"
   external-dns.alpha.kubernetes.io/hostname: '$PROJECT'.'$SERVER_DNS'
spec:
  tls:
  - secretName: cert-wildcard-hml
    hosts:
    - '$PROJECT'.'$SERVER_DNS'
  rules:
  - host: '$PROJECT'.'$SERVER_DNS'
    http:
      paths:
      - backend:
          serviceName: '$PROJECT'-service
          servicePort: '$PORT'
' | kubectl apply -f -


echo ""
echo ""
echo "--------------------------------------"
echo 'Project '$1' - Setup'
echo ""
echo "API URL: https://$PROJECT.$SERVER_DNS/"
echo ""
echo "--------------------------------------"
