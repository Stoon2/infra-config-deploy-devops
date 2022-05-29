# Full CI/CD Pipeline (AWS)

Using available DevOps tools, in this project I automated the deployment of both the Infrastructure and Application using these tools:

---

**Jenkins** - **Terraofrm** - **Ansible** - **Docker** - **Bash**

![Jenkins](https://t4.ftcdn.net/jpg/02/90/22/59/360_F_290225913_HpgaxOy6sQgbqhDyn5uh8IncU6zxKWSS.jpg)

---

# Jenkins

Using a Multibranch Jenkins Project, I was able to create this singular repository, and isolate the configuration for different pipelines with Jenkinsfiles. The different pipeline configurations files are automatically detected by Jenkins. This is illustrated in the image below:

![Multibranch Pipeline](https://dz2cdn1.dzone.com/storage/temp/12713975-multibranch-pipeline.png)

---

# Terraform / AWS

Terraform was used here to create the IaC (Infrastructure as Code) part of the project. This makes our infrastructure a lot more durable. If it goes down, we can simply bring it back up. This was all done on AWS with 2 public machines, one as a and slave machine, the other as a Jenkins master.

![AWS Architecture Graph](https://miro.medium.com/max/1240/0*AhqLCTAzV4MFY2MV)

---

# Docker

Using Docker containers, we are easily able to deploy our Jenkins Master with some modifications. Then pushing this custom image to Dockerhub right after building it with Jenkins.

![Docker Logo](https://hsto.org/getpro/habr/post_images/792/138/92e/79213892e85d57177c0ba9864dd75cc6.png)

---

# Ansible/Bash

Using Bash, we can manipulate the enviornment of a Docker container where our Infrastructure is being built. Then later update the needed config files for Ansible, so it can keep track of the infrastructure built with Terraform. After the creation of our Infra, we can now configure it with Ansible, using some prewritten scripts.

|                                    Bash                                     |                                  Ansible                                  |
| :-------------------------------------------------------------------------: | :-----------------------------------------------------------------------: |
| ![](https://tecadmin.net/tutorial/wp-content/uploads/2017/09/bash-logo.jpg) | ![](https://sachsenhofer.io/wp-content/uploads/2018/06/ansible-white.png) |

---

## Installation:

1. Create an EC2 instance, this will be your master node.
2. Give this machine an Admin Role
3. [Install Docker](https://docs.docker.com/engine/install/ubuntu/)
4. Run Jenkins container

```
docker run -p 8080:8080 jenkins/jenkins:latest
```

5. Configure Jenkins
6. Edit Jenkins settings to allow better granularity for permissions.

---

## Notes for Installation and Deployment:

---

Ensure that the variables output of Terraform is fed manually into the application container manually.
I wish to automate this in a coming iteration of the project.
