# step-by-step

##  1 - Gitlab
### 1.1 - Create account
### 1.2 - Create group
### 1.3 - Configure Env. group variables
### 1.4 - Create context-project
### 1.5 - Create application projects

---

## 2 - Setup Server + Cloud Services (Terraform)

### 2.2 - Apontamento dos serviços
* 1 - Após subir as maquinas na cloud, deve-se obter o IP público das mesmas;
* 2 - Deve-se criar um DNS wildcard para receber o trafego de todos os serviços da empresa
* 3 - Utilizar o pattern para o registro: RECORD = `*.services.mydomain.com.br` `A` `ip-da-maquina`
* 4 - Devese apontar o wilrdcard para TODOS os IPs do cluster;

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

### 3.8 - Traefik
#### 3.8.1 - Controle de permissão do traefik
```bash
$ kubectl apply -f ./kubernetes/templates/traefik-rbac.yaml
```
#### 3.8.2 - Deployment do traefik
```bash
$ kubectl apply -f ./kubernetes/templates/traefik-ds.yaml
```
#### 3.8.2 - List pods to check if traefik ingress roles was created
```bash
$ kubectl get pods -n kube-system
```

#### 3.8.2 - Config the domain DNS to view traefik interface
```bash
$ kubectl apply -f ./kubernetes/templates/traefik-ui.yaml
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