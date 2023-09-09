# eks-with-eksctl
This repository provides an example of deploying an Amazon Elastic Kubernetes Service (EKS) cluster using eksctl

## why eksctl? 
  * Simplicity and Ease of Use: eksctl is purpose-built specifically for creating and managing EKS clusters. It abstracts away much of the complexity of creating an EKS cluster and simplifies the process with straightforward commands and configurations. This makes it a great choice for users who want a quick and simple way to get an EKS cluster up and running without dealing with excessive configuration.

  * EKS-Specific Features: eksctl is designed to support all the latest features and updates of Amazon EKS. As a dedicated tool for EKS, it typically has quicker support for new EKS features, which might take a bit longer to be available in Terraform's EKS provider.

  * Native EKS Best Practices: eksctl follows native EKS best practices and recommendations by AWS, ensuring that you create a well-architected cluster that aligns with AWS's guidelines and security measures.

  * Abstraction of Infrastructure: eksctl abstracts the infrastructure management and focuses on the Kubernetes cluster itself. It allows users to concentrate more on Kubernetes-specific configurations rather than managing the underlying AWS resources.

  * Simplified Cluster Configuration: eksctl allows you to configure your EKS cluster using a YAML or JSON configuration file. This configuration file contains most of the common settings needed to create a cluster, reducing the complexity of the process.

  * Seamless Updates: eksctl simplifies updates and upgrades of your EKS cluster. It provides straightforward commands to update the Kubernetes version or change the node group configurations.

## Prerequisites
* [kubectl](https://docs.aws.amazon.com/eks/latest/userguide/install-kubectl.html)
* [aws-cli](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html)
* [eksctl](https://docs.aws.amazon.com/eks/latest/userguide/eksctl.html)
* [AWS access credentials](https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-files.html)

## Creating EKS Cluster
To create a basic cluster for testing, run:
```
eksctl create cluster --name=eks-demo
```
But, for Production,  create a cluster with a config file; this helps to keep configuration Consistency, Reproducibility, Version Control, Modularity and Reusability, Documentation etc.


Edit the eksctl-basic-demo.yaml file to include your desired cluster configuration. This file specifies the cluster name, region, node group configuration, and any add-ons.

Run the following command to create the EKS cluster:

```
eksctl create cluster -f eksctl-demo-basic.yaml
```

This will create an EKS cluster based on the configuration specified in the eksctl-demo-basic.yaml file.

Verify that the cluster was created successfully by running the following command:

```
kubectl get nodes
```
This will list the worker nodes in the cluster.

## Deploy sample application
Deploy Nginx application
```
kubectl create deploy nginx --image=nginx
kubectl get pod
```
Access the nginx pod externally

```
kubectl port-forward deploy/nginx 8080:80
```
Access nginx in the browser http://localhost:8080

## Maintain EKS Cluster
Upgrade EKS version
Edit the config file to the desired version
```
eksctl upgrade cluster -f eksctl-demo-upgrade.yaml --approve
kubectl get nodes
```
## Upgrade the Node Group: 
To perform the upgrade, you will need to create a new node group with the updated configuration and delete the existing node group. 
This can be achieved using the following steps:
```
eksctl create nodegroup --config-file=eksctl-demo-upgrade.yaml
```
Drain and delete the old node group:

Before proceeding with this step, ensure that you have tested your applications on the new node group and have confirmed that they are functioning as expected.

```
eksctl drain nodegroup --cluster=eks-demo --name=ng-1
eksctl delete nodegroup --cluster=eks-demo --name=ng-1
or
eksctl delete nodegroup -f eksctl-demo-upgrade.yaml --only-missing --approve
```

## Delete EKS Cluster
To delete the cluster, run the following command:
```
eksctl delete cluster -f eksctl-demo-basic.yaml
```
This will delete the EKS cluster along with any associated resources.

### Conclusion
This example demonstrates how to deploy an EKS cluster using eksctl. You can customize the cluster configuration in the eksctl-demo-basic.yaml file to meet your specific requirements.
