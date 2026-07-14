# Exercise 16: Build a Production EKS Platform

This repository demonstrates how to provision a **production-ready Amazon EKS (Elastic Kubernetes Service) platform** using **Terraform**. The infrastructure follows AWS best practices and includes managed node groups, autoscaling, monitoring components, and namespace isolation for different environments.

---

# Objective

Build a production-ready Kubernetes platform on AWS with the following components:

- Amazon EKS Cluster
- Custom VPC with Public and Private Subnets
- Managed Node Groups
- IAM Roles for Service Accounts (IRSA)
- Cluster Autoscaler
- Metrics Server
- Separate Development and Production Namespaces
- Infrastructure provisioned using Terraform

---

# Architecture Overview

```text
                    Developer
                        │
                        ▼
                  Terraform Apply
                        │
                        ▼
                  AWS Infrastructure
                        │
        ┌───────────────┴────────────────┐
        │                                │
        ▼                                ▼
      VPC                         IAM Roles (IRSA)
        │
        ▼
 Amazon EKS Cluster
        │
        ▼
 Managed Node Groups
        │
        ▼
 Kubernetes Cluster
        │
 ┌──────┴──────────────┐
 │                     │
 ▼                     ▼
dev Namespace     prod Namespace
 │                     │
 └────────────┬────────┘
              ▼
   Metrics Server + Cluster Autoscaler
```

---

# Features

- Production-ready Amazon EKS Cluster
- Highly available VPC architecture
- Public and Private Subnets
- Managed Worker Nodes
- IAM Roles for Service Accounts (IRSA)
- Cluster Autoscaler installed using Helm
- Metrics Server installed using Helm
- Environment isolation using Kubernetes Namespaces
- Infrastructure as Code with Terraform

---

# Technologies Used

- AWS EKS
- Terraform
- Kubernetes
- Helm
- AWS IAM
- Amazon VPC
- EC2 Managed Node Groups
- Cluster Autoscaler
- Metrics Server

---

# Prerequisites

Before deploying the infrastructure, ensure the following tools are installed.

- AWS CLI
- Terraform (v1.x or later)
- kubectl
- Helm
- AWS Account with sufficient IAM permissions

Configure AWS credentials.

```bash
aws configure
```

---

# Deployment

## Initialize Terraform

```bash
terraform init
```

---

## Review the Execution Plan

```bash
terraform plan
```

---

## Deploy the Infrastructure

```bash
terraform apply -auto-approve
```

Terraform provisions:

- VPC
- Internet Gateway
- NAT Gateway
- Public and Private Subnets
- Route Tables
- Amazon EKS Cluster
- Managed Node Groups
- IAM Roles
- Security Groups

---

# Configure kubectl

After deployment, connect to the cluster.

```bash
aws eks update-kubeconfig \
--region us-east-1 \
--name production-eks-cluster
```

---

# Install Metrics Server

```bash
helm repo add metrics-server https://kubernetes-sigs.github.io/metrics-server/

helm repo update

helm install metrics-server metrics-server/metrics-server \
-n kube-system
```

---

# Install Cluster Autoscaler

```bash
helm repo add autoscaler https://kubernetes.github.io/autoscaler

helm repo update

helm install cluster-autoscaler \
autoscaler/cluster-autoscaler \
-n kube-system
```

---

# Create Namespaces

```bash
kubectl create namespace dev

kubectl create namespace prod
```

---

# Validation

## Verify Cluster

```bash
kubectl get nodes
```

Expected Output

```text
NAME                             STATUS   ROLES    AGE
ip-10-0-1-15.ec2.internal        Ready    <none>
ip-10-0-2-20.ec2.internal        Ready    <none>
```

---

## Verify Namespaces

```bash
kubectl get namespaces
```

Expected Output

```text
default
kube-system
kube-public
dev
prod
```

---

## Verify Metrics Server

```bash
kubectl top nodes
```

---

## Verify Autoscaler

```bash
kubectl get pods -n kube-system
```

Ensure the **cluster-autoscaler** pod is in the **Running** state.

---

# Project Structure

```text
.
├── main.tf
├── variables.tf
├── outputs.tf
├── provider.tf
├── vpc.tf
├── eks.tf
├── iam.tf
├── nodegroup.tf
└── README.md
```

---

# Monitoring Components

| Component | Purpose |
|-----------|---------|
| Metrics Server | Collects CPU and Memory metrics |
| Cluster Autoscaler | Automatically scales worker nodes |
| IAM Roles for Service Accounts | Secure AWS API access |
| Managed Node Groups | Simplified node management |

---

# Validation Commands

```bash
kubectl get nodes

kubectl get pods -A

kubectl get namespaces

kubectl top nodes

kubectl top pods

kubectl get deployments -A
```

---

# Learning Outcomes

- Provisioned a production-ready Amazon EKS cluster.
- Built networking with VPC, subnets, and routing.
- Configured Managed Node Groups.
- Installed Kubernetes add-ons using Helm.
- Implemented namespace isolation for multiple environments.
- Configured Cluster Autoscaler for automatic scaling.
- Enabled Metrics Server for resource monitoring.
- Managed infrastructure using Terraform Infrastructure as Code.

---

# Cleanup

Destroy all AWS resources.

```bash
terraform destroy -auto-approve
```

---

# Author

**Sanjay Nivas G**

DevOps | AWS | Kubernetes | Terraform | Docker | CI/CD
