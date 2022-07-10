# environment

## Create VM on cloud (gpc, aws, azure)

* Must to get ssh access for each VM
* Must to install docker for each VM
* Must have one VM for RancherServer
* Must have three VM for Kubernets

```bash
$ ssh -i devops-host-a.pem ubuntu@<ip>  - RancherSerber - HOST A
$ ssh -i devops-host-b.pem ubuntu@<ip>  - k8s-1         - HOST B
$ ssh -i devops-host-c.pem ubuntu@<ip>  - k8s-2         - HOST C
$ ssh -i devops-host-d.pem ubuntu@<ip>  - k8s-3         - HOST D
```

* Run the followin commands on each VM to install Docker

```bash
$ sudo su
$ curl https://releases.rancher.com/install-docker/19.03.sh | sh
$ usermod -aG docker ubuntu
```