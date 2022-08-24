#!/usr/bin/env bash
#
NAMESPACE=$1
PROJECT=$2
PORT=$3
EXTERNAL_IP=""
PASSWD_MYSQL=$(pwgen -s 18 1)
SERVER_DNS=services.fluky.comm.br

echo "- switch to namespace $NAMESPACE"
kubens $1

echo "- mySQL install"
kubectl delete secret mysql-password-$PROJECT
kubectl create secret generic mysql-password-$PROJECT --from-literal=password=$PASSWD_MYSQL

echo '
apiVersion: v1
kind: Service
metadata:
  name: mysql-'$PROJECT'-service
  namespace: '$NAMESPACE'
  labels:
    app: '$PROJECT'
  annotations:
    external-dns.alpha.kubernetes.io/hostname: mysql-'$PROJECT'.'$SERVER_DNS'
  labels:
    app: mysql-'$PROJECT'
spec:
  ports:
    - port: 3306
  selector:
    app: mysql-'$PROJECT'
    tier: mysql
  type: LoadBalancer
---
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: mysql-pv-claim-'$PROJECT'
  namespace: '$NAMESPACE'
  labels:
    app: mysql-'$PROJECT'
spec:
  accessModes:
    - ReadWriteOnce
  resources:
    requests:
      storage: 1Gi
---
apiVersion: apps/v1
kind: Deployment
metadata:
  name: mysql-'$PROJECT'
  namespace: '$NAMESPACE'
  labels:
    app: mysql-'$PROJECT'
spec:
  selector:
    matchLabels:
      app: mysql-'$PROJECT'
      tier: mysql
  strategy:
    type: Recreate
  template:
    metadata:
      labels:
        app: mysql-'$PROJECT'
        tier: mysql
    spec:
      containers:         
      - image: mysql:8
        name: mysql
        env:
        - name: MYSQL_ROOT_PASSWORD
          valueFrom:
            secretKeyRef:
              name: mysql-password-'$PROJECT'
              key: password                   
        ports:
        - containerPort: 3306
          name: mysql
        volumeMounts:
        - name: mysql-persistent-storage
          mountPath: /var/lib/mysql 
        resources:
          requests:
            cpu: "100m"
            memory: "256Mi"
          limits:
            #cpu: "100m"
            #memory: "512Mi"   
      volumes:
      - name: mysql-persistent-storage
        persistentVolumeClaim:
          claimName: mysql-pv-claim-'$PROJECT'

' | kubectl apply -f -

echo ""
echo "--------------------------------------"
echo 'Project '$1' - mySQL - Setup'
echo ""
echo "HOSTNAME: mysql-$PROJECT.$SERVER_DNS"
echo ""
echo "USER: root"
echo ""
echo "PASSWORD: $PASSWD_MYSQL"
echo ""
echo "--------------------------------------"
