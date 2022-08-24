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

> Ubuntu
```bash
$ #!/bin/bash
$ sudo su
$ sudo apt-get update
$ curl https://releases.rancher.com/install-docker/19.03.sh | sh
$ sudo apt-get -y install docker-ce docker-ce-cli
$ usermod -aG docker ubuntu
```

> AWS Linux 2
```bash
#!/bin/bash
# 1 - Apply pending updates
sudo yum update
# 2 - Install docker
sudo yum install docker -y
# 3 - Add group membership for the default ec2-user so you can run all docker commands without using the sudo command
sudo usermod -a -G docker ec2-user
sudo newgrp docker
# 4 - Enable docker service at AMI boot time
sudo systemctl enable docker.service
# 5 - Start the Docker service
sudo systemctl start docker.service
```
