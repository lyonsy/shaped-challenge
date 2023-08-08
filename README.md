# Shaped SRE Challenge Submission

In this repository you will find Terraform files split up into each environment to provision a GKE cluster with Argo Workflows installed:
* networking.tf -> VPC, subnet and firewall rule
* k8s.tf -> GKE cluster, node pool, GPU node pool
* argo.tf -> helm installation of argo workflows
* provider.tf -> standard terraform config
* variables.tf -> standard terraform config

To provide network isolation among environments, this is accomplished by having different VPCs for each environment.

## Infrastrcuture

To provision the infrastructure, first you will need to update the `provider.tf` file with your google project name as well as the path to your service account credentials file. Docs on generating the service account credentials can be found [here](https://cloud.google.com/iam/docs/keys-create-delete). To be able to reach the cluster, you will need to update the `whitelist_ip` [variable](dev/variables.tf) with your IP.

Once the cluster is provisioned the terraform apply will fail on installing Argo and the Argo namespace. This is because we do not have access to the cluster. To fix this, we need to follow the steps [here](https://cloud.google.com/kubernetes-engine/docs/how-to/cluster-access-for-kubectl). These two commands should do the trick assuming you have gcloud cli installed:
`gcloud components install gke-gcloud-auth-plugin`

`gcloud container clusters get-credentials shaped-cluster-dev --region=us-central1`

## Argo

With Argo installed, we can use port forwarding to view the Argo UI by running the following command: `kubectl -n argo port-forward deployment/argo-workflows-server 2746:2646`

## Deploying a service

To deploy services, I created a simple Helm chart that allows us to deploy Argo Workflows with less than 10 lines of YAML. To deploy with the chart, you can run `helm install deployer-release /root/shaped_challenge/deployer-chart/deployer/  -f deployer/examples/big-machine.yaml`. Unfortunately GCP would not allow me to create a cluster with GPU nodes but the logic to deploy specific workloads to a GPU node pool is all there.
There is more detail in a separate README [here](/deployer-chart/deployer/README.MD)

## CI/CD

Terraform and helm are tools that can easily be integrated with most CI/CD tooling. For Terraform, all you need is a remote state and a host with permissions to provision cloud resources. For Helm, you could store the deployer helm chart in an artifact registry that your CI/CD tool has access to and deploy from there.

## Improvements

My main issue with the current setup right now is that you have to apply Terraform twice to get your cluster fully up and running with Argo installed. In an ideal setup, Terraform would be executed from a CI/CD tool with elevated permissions around GKE clusters. This would allow you to automate the generation of clusters.

For the terraform code itself, I would create a module that would handle all of the networking and cluster setup. This way you can easily customize the cluster, add/remove nodes, use different instance types etc.