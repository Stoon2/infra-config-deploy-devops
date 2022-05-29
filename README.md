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

![Docker Logo](https://hdwallpaperim.com/wp-content/uploads/2017/08/25/461265-docker-containers.jpg)

---

# Ansible/Bash


Bash         |  Ansible
:-------------------------:|:-------------------------:
![](https://skorpil.cz/sites/default/files/2022-01/1200px-Bash_Logo_Colored.svg_.png)  |  ![](https://www.freecodecamp.org/news/content/images/2021/09/ansble.png)