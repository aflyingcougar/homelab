# Infrastructure
This component creates an Ubuntu vSphere template using Packer and provisions virtual machines (VMs) from that template using Terraform. The resulting VMs are the infrastructure on which the k3s cluster is deployed to.

## 📂 Repository structure

The Git repository contains the following directories under `infra`

```sh
📁 packer               # VSphere infrastructure defined as code
├─📁 http               # cloud-config for the VMs
├─📁 provision_scripts  # scripts executed by "shell" Packer provisioner
```

# Steps to Deploy Infrastructure

## Build the Ubuntu template to your vSphere cluster
At the root of the `infra/packer` directory:
```sh
$ packer build .
```