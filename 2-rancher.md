# Instalação do Rancher

> access rancher-server vm machine throught ssh
```bash
ssh -i devops-rancher-ssh.cer ubuntu@<ip>  - RancherServer - HOST A
```

> run docker run to install the rancher server (single-node) on v2.5.3
```bash
docker ps -a
docker run -d --name rancher --restart=unless-stopped -v /opt/rancher:/var/lib/rancher -p 80:80 -p 443:443 --privileged rancher/rancher:v2.5.3
```

> run the followin command to track rancher logs and check if it has been bootstrap successfully

```bash
docker logs --follow rancher
```

> Maybe you can get errors talking about \"failed to find memory cgroup\" or \"Failed to find cpuset cgroup\", so you can check if it is enabled on your system and apply it to your environment

```bash
cat /proc/cgroups
```

> Add configs to cmdline file

> `cgroup_enable=cpuset cgroup_memory=1 cgroup_enable=memory`

```bash
vim /boot/cmdline.txt
```

> then restart the machine
```bash
sudo reboot
```


> Configure your custom domain with a subdomain \<rancher\> pointing to rancher-server ip

> it is necessary for rancher configuration handle orchestration nodes

```bash
rancher.<domain> A <rancher-server-ip-on-cloud>
```

Then is possible to access the domain and finish rancher account configuration to get access to rancher dashboard