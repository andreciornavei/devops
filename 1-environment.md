# cloud - environment

## Create VM on cloud (gpc, aws, azure)

* Must to get ssh access for each VM
* Must to install docker for each VM
* Must have one VM for RancherServer
* Must have three VM for Kubernets
* Each VM shoud have 2-4/vCpu and 6-8/gb-memory

> make key not visible at public level
```bash
$ chmod 400 devops-rancher-ssh.cer
```

> access vm machine throught ssh
```bash
$ ssh -i devops-rancher-ssh.cer ubuntu@<ip>  - RancherServer - HOST A
$ ssh -i devops-rancher-ssh.cer ubuntu@<ip>  - k8s-1         - HOST B
$ ssh -i devops-rancher-ssh.cer ubuntu@<ip>  - k8s-2         - HOST C
$ ssh -i devops-rancher-ssh.cer ubuntu@<ip>  - k8s-3         - HOST D
```

> Run the following commands on each VM to install Docker or add this script on user-data (AWS) to  running on instance launch.
```bash
$ #!/bin/bash
$ sudo su
$ sudo apt-get update
$ curl https://releases.rancher.com/install-docker/19.03.sh | sh
$ sudo apt-get -y install docker-ce docker-ce-cli
$ usermod -aG docker ubuntu
```