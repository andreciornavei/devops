# environment

## Create VM on cloud (gpc, aws, azure)

* Must to get ssh access for each VM
* Must to install docker for each VM
* Must have one VM for RancherServer
* Must have three VM for Kubernets


> make key not visible at public level
```bash
$ chmod 400 devops-host.cer
```

> access vm machine throught ssh
```bash
$ ssh -i devops-host.cer ubuntu@<ip>  - RancherServer - HOST A
$ ssh -i devops-host.cer ubuntu@<ip>  - k8s-1         - HOST B
$ ssh -i devops-host.cer ubuntu@<ip>  - k8s-2         - HOST C
$ ssh -i devops-host.cer ubuntu@<ip>  - k8s-3         - HOST D
```

> Run the following commands on each VM to install Docker
```bash
$ sudo su
$ sudo apt-get update
$ curl https://releases.rancher.com/install-docker/19.03.sh | sh
$ sudo apt-get install docker-ce docker-ce-cli
$ usermod -aG docker ubuntu
```