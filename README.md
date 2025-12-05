
# React Application – AWS CI/CD Deployment (Docker, Jenkins, EC2, DockerHub, Prometheus, Alertmanager, Slack Alerts)

## 📌 Project Summary  
This project demonstrates a complete CI/CD workflow for deploying a containerized React application to AWS EC2 using Jenkins automation, DockerHub (Dev & Prod registries), and real-time monitoring using Prometheus + Alertmanager + Slack.  
The goal was to automate **build → push → deploy → monitor → alert** cycle end-to-end in a production-like environment.

---

## ✔️ What I Did

### **1. Dockerization**
- Containerized the React application using Nginx.
- Created production-ready `Dockerfile`.
- Built and tested Docker image locally.
- Added `.dockerignore` and `.gitignore` for clean build context.
- Created two DockerHub repositories:
  - `react-nginx-app-dev` *(public – development image builds)*
  - `react-nginx-app-prod` *(private – production stable builds)*

---

### **2. Jenkins CI/CD Pipeline**
- Connected GitHub repository to Jenkins using Webhook.
- Configured Jenkins as Multi-Branch Pipeline for **dev & main/master**.
- CI/CD workflow:
  - Push to **dev** → Jenkins auto builds + pushes image to **public Dev DockerHub repo**
  - Merge to **main/master** → Jenkins builds + pushes image to **private Prod repo**
  - Jenkins then automatically deploys latest Prod image to AWS EC2.
- Enabled credential binding for secure DockerHub authentication.
- Automated tagging system: `latest / stable / timestamp-version`.

---

### **3. Deployment on AWS EC2**
- Launched **t2.micro Ubuntu EC2 instance**.
- Installed Docker & Docker Compose.
- Pulled production image from private DockerHub repo and deployed container.
- Configured Security Group:
  - HTTP port 80 open to **anyone**
  - SSH port 22 restricted to **my IP only**
- Application successfully deployed and accessible using EC2 public IP.

---

### **4. Monitoring & Alerting (Open Source Stack)**
- Installed **Prometheus + Alertmanager + Blackbox Exporter** in EC2.
- Configured endpoint probing to monitor application on port 80.
- Created alert rule to detect downtime:
  ```
  probe_success == 0 for 1m
  ```
- Integrated Alertmanager with **Slack Incoming Webhook**.
- Slack alerts workflow:
  - App DOWN → 🔴 Immediate alert notification on Slack
  - App UP again → 🟢 RESOLVED notification sent
- Monitoring works 24/7 without manual check.

---

## 🎯 Final Outcome
- Application successfully containerized with Docker.
- Fully automated CI/CD pipeline using **GitHub → Jenkins → DockerHub → EC2**.
- Separate Dev & Prod release workflow implemented.
- Real-time alerting system using Prometheus + Alertmanager + Slack.
- Application accessible publicly and monitored for failures.
- Production deployment requires **zero manual involvement**.

---

## 🌍 Production Access  
Application accessible at:  
`http://<EC2-PUBLIC-IP>`  
*(dynamic IP — will change when instance restarts unless Elastic IP assigned)*

Slack alerts configured via webhook to monitor uptime and send downtime notifications.

---

## 📸 Screenshots & Proof of Work  
📂 **Screenshots Drive Link:**  
👉 [Click here to view screenshots](https://docs.google.com/document/d/1hUY0QWHGp9SZWNBIS0BIe0OS8XVbedCcB1neo4Qx-7s/edit?usp=sharing)

Includes:
- Docker build & image push
- Jenkins pipeline execution
- Dev → Prod branch automation
- DockerHub repositories (public + private)
- EC2 deployment & running container
- Prometheus alerts panel
- Slack downtime/resolved notifications

---