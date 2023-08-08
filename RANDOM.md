# Decisions / Challenges

Here I will list some of the decisions, challenges and some learnings I made along the way.

For IaC I went with Terraform as it's a tool I have the most experience with and the most popular tool on the market.

This was my first time really working GCP. It is very similar to AWS so nothing was super challenging but there was some key differences in how the networking setup is, specifically around networking. To get the cluster up and running, all I needed was a VPC, subnet and firewall rule, whereas in AWS I would need to create route tables, an internet gateway or a NAT gateway if I opted for a private subnet.

For network isolation between environments, the simplest approach is to just have separate VPCs with no connectivity between them. You could have everything running in the same VPC and have firewall rules to block access between the clusters but I prefer having a more distinct separation. 

With GCP, you could also separate the environments by project. My understanding is that this is kind of similar to having a separate AWS account for each environment. It would allow you to easily see costs, usage etc across environments. In the case of this challenge, I just kept everything in the same project to keep it simple.

GCP would not allow me to deploy a cluster with GPU nodes since I hit a quota limit, I presume I need to spend a bit more money with them before they will allow me to request more. The logic in the deployer helm chart should demonstrate that this will work if a node is there.

## Metaflow

I spent some time trying to get Metaflow up and running but ran into some issues with the deployment. There is a guide [here](https://outerbounds.com/engineering/deployment/gcp-k8s/deployment/) that essentially does everything for you but I wanted to avoid that for the sake of the challenge.

I opted to try and get it installed using helm. They have helm charts [here](https://github.com/outerbounds/metaflow-tools/tree/master/k8s/helm/metaflow) but they're not as well documented as the other deployment options. After installing, I could get the UI up and running but there was an issue with the database and it was stuck in a restart loop. I plan to open an issue on their repo but for now I decided to not spend anymore time with this.