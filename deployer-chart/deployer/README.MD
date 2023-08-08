# Deployer Helm Chart

This chart can be used to deploy Argo workflows to a Kubernetes cluster. By using Helm, we can set common sense defaults for deployments and use it to apply any naming conventions while abstracting away most of the configuration and allowing the user to focus on the parts important to them. 

## Usage

The simplest way to use this is use the helm CLI:

`helm install deployer-release /root/shaped_challenge/deployer-chart/deployer/  -f deployer/examples/big-machine.yaml`

To create your own file, copy the `values.yaml` file in this directory and custoimize the variables to your liking.

To ensure the workload runs on a node with a GPU, I used node affinities to match the workload up with a node labeled `gpu-node`.


## Improvements

This works great for personal projects but at a larger scale you would want to have your deployments automated. A more suitable setup would be to have this deployment automatically triggered when a push is made to a Github repo for example. Also, in its current state, the chart only allows for a simple one step deployment. It could be improved to allow for more complex deployments with multiple steps and even different resource requirements per step.
