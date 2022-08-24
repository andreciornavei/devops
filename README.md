# step-by-step

##  1 - Gitlab
### 1.1 - Create account
### 1.2 - Create group
### 1.3 - Configure Env. group variables
### 1.4 - Create context-project
### 1.5 - Create application projects

---

## 2 - Setup Server + Cloud Services (Terraform)

---

## 3 - Setup Kubernetes
### 3.1 - Install Helm (Package Manager for Kubernetes)
```bash
$ curl https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash
```
### 3.2 - Install cert-manager on kubernetes
```bash
$ kubectl apply --validate=false -f https://github.com/jetstack/cert-manager/releases/download/v1.4.0/cert-manager.yaml
```
### 3.3 - Create a namespace for cert-manager
```bash
$ kubectl create namespace cert-manager
```
### 3.4 - Add the Jetstack Helm repository
```bash
$ helm repo add jetstack https://charts.jetstack.io
```
### 3.5 - Update your local Helm chart repository cache
```bash
$ helm repo update
```
### 3.6 - Install the cert-manager Helm chart
```bash
helm install \
  cert-manager jetstack/cert-manager \
  --namespace cert-manager \
  --version v1.0.4
```
### 3.7 - Check cert-manager deployment
```bash
$ kubectl get pods --namespace cert-manager
```

---

## 4 - Setup Rancher
### 4.1 - Add Rancher to Helm repository
```bash
$ helm repo add rancher-stable https://releases.rancher.com/server-charts/stable
```
### 4.2 - Update your local Helm chart repository cache
```bash
$ helm repo update
```
### 4.3 - Crate a namespace for rancher on kubernetes
```bash
$ kubectl create namespace cattle-system
```

### 4.5 - Install Rancher on Kubernetes
```bash
helm install rancher rancher-stable/rancher \
  --namespace cattle-system \
  --set hostname=services.mydomain.com.br \
  --set ingress.tls.source=letsEncrypt \
  --set letsEncrypt.email=andre.ciornavei@gmail.com
```

### 4.6 - Wait for rancher rollout
```bash
kubectl -n cattle-system rollout status deploy/rancher
# Waiting for deployment "rancher" rollout to finish: 0 of 3 updated replicas are available...
# deployment "rancher" successfully rolled out
```

### 4.7 - Show Rancher Deployment
```bash
kubectl -n cattle-system get deploy rancher
```

---

## 5 - Setup Application

---