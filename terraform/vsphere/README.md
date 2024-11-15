# Infrastructure
This component creates a Talos Kubernetes cluster using VMware. A highly-available cluster will be provisioned with 3 control plane nodes and 3 worker nodes.

## Overview

## Prerequisites
Install the following packages:
- Terraform CLI
- `talosctl`

Import the talos OVA into vCenter Content Library

## 📂 Repository structure

The Git repository contains the following directories under `infra`

```sh
📁 packer               # VSphere infrastructure defined as code
├─📁 http               # cloud-config for the VMs
├─📁 provision_scripts  # scripts executed by "shell" Packer provisioner
📁 talos                # Talos configuration files
```

# Steps to Deploy Infrastructure

## Create the Machine Configuration Files
### Generating Base Configurations
At the root of the `talos` directory:
```sh
$ talosctl gen config vmware-cluster https://192.168.20.40:6443 --config-patch-control-plane @cp.patch.yaml --config-patch @all.patch.yaml
created controlplane.yaml
created worker.yaml
created talosconfig
```
### Validate the Configuration Files
```sh
$ talosctl validate --config controlplane.yaml --mode cloud
controlplane.yaml is valid for cloud mode
$ talosctl validate --config worker.yaml --mode cloud
worker.yaml is valid for cloud mode
```
## Create the Control Plane and Worker Nodes
After the configuration files are validated, change directories to the `infra` directory, initialize the Terraform workspace, and apply the configuration to create the three control plane and three worker nodes from the talos OVA.
```sh
$ cd ..
$ terraform init
$ terraform apply
```
## Bootstrap Cluster
In vSphere UI, open a console to `k3s-control-01`. You should see some output stating that etcd should be boostrapped. This text should look like:
```sh
"etcd is waiting to join the cluster, if this node is the first node in the cluster, please run `talosctl bootstrap` against one of the following IPs:
```
Bootstrap the cluster:
```sh
$ cd talos
$ talosctl --talosconfig talosconfig bootstrap -e 192.168.20.20 -n 192.168.20.20
```

## Retreive the `kubeconfig`
```sh
$ talosctl --talosconfig talosconfig config endpoint 192.168.20.20
$ talosctl --talosconfig talosconfig config node 192.168.20.20
$ talosctl --talosconfig talosconfig kubeconfig .
```

## Configure talos-vmtoolsd
Create a new talosconfig with:
```sh
$ talosctl --talosconfig talosconfig -n 192.168.20.20 config new vmtoolsd-secret.yaml --roles os:admin
```

Create a secret from the talosconfig:
```sh
$ kubectl --kubeconfig kubeconfig -n kube-system create secret generic talos-vmtoolsd-config \
  --from-file=talosconfig=./vmtoolsd-secret.yaml
```

Delete the generated file from local system:
```sh
rm vmtoolsd-secret.yaml
```

## Post-Deploy
☢️ If you run into problems, you can run `terraform destroy` to destroy the VMs and start over.