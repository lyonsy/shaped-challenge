# Decisions / Challenges

Here I will list some of the decisions, challenges and some learnings I made along the way.

For IaC I went with Terraform as it's a tool I have the most experience with and the most popular tool on the market.

This was my first time really working GCP. It is very similar to AWS so nothing was super challenging but there was some key differences in how the networking setup is, specifically around networking. To get the cluster up and running, all I needed was a VPC, subnet and firewall rule, whereas in AWS I would need to create route tables, an internet gateway or a NAT gateway if I opted for a private subnet.

For network isolation between environments, the simplest approach is to just have separate VPCs with no connectivity between them. You could have everything running in the same VPC and have firewall rules to block access between the clusters but I prefer having a more distinct separation. 

With GCP, you could also separate the environments by project. My understanding is that this is kind of similar to having a separate AWS account for each environment. It would allow you to easily see costs, usage etc across environments. In the case of this challenge, I just kept everything in the same project to keep it simple.

GCP would not allow me to deploy a cluster with GPU nodes since I hit a quota limit, I presume I need to spend a bit more money with them before they will allow me to request more. The logic in the helm chart should demonstrate that this 
