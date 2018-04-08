# DevOps Tech 2 Screening

#### Task

You want to design a scalable and secure continuous delivery architecture for a full-stack web application. Since the app itself is not going to be scored, you can use any of the implemented technology present for Notejam: https://github.com/komarserjio/notejam (pick the technology you would like to work with on Toptal clients). You should fork the repository and use it as the base for your system.

  * The architecture needs to be broken down into the relevant tiers (application, database, etc…).
  * The architecture should be completely provisioned via Chef/Puppet/Ansible/similar.
  * The deployment of new code and execution of tests should be completely automated. (Bonus points if you are able to catch performance regressions).
  * The database and any mutable storage need to be backed up at least daily.
  * All relevant logs for all tiers need to be easily accessible (having them on the hosts is not an option).

  * You should fork the repository and use it as the base for your system.
  * You should be able to deploy it on one major Cloud provider: AWS / Google Cloud / Azure / DigitalOcean / RackSpace.
  * The system should present relevant historical metrics to spot and debug bottlenecks.


As a solution, please commit to the git repo the following:

  * An architectural diagram / PPT to explain your architecture during the interview.
  * All the relevant configuration scripts (Chef/Puppet/cfengine/ansible/cloud formation)
  * All the relevant runtime handling scripts (start / stop / scale nodes).
  * All the relevant backup scripts (start / stop / scale nodes).
  * The forked version of the app you are going to use


# Terraform Config

Terraform state is stored locally and in the VCS. Advanced configuration would
be storing to the S3 bucket, but it's required to create the bucket manually
upfront, so skipped that option in this case to keep things fully automated.


# AWS Architecture Overview

  * AWS Architecture Diagram => see `docs/ToptalDevOps-AwsArchitectureDiagram.png`

## VPC / Networking

#### VPCs:

  * A production VPC
  * A dev/staging VPC

#### Networking infrastructure per each VPC

  * Internet Gateways - one per each VPC
  * Public subnets containing the bastion hosts
  * Private subnets containing the webservers hosts
  * A default route table with local network access only, and no subnets associated (default no-exit security)
  * A DMZ route table with internet access, and bastion + webservers subnets associated
  * A default NACL allowing all in/out traffic
  * Security groups: Bastions, ALBs, WebServers, Default (unused)

## Database infrstructure

  * RDS MySql instance as application database (turned out the application doesn't have support for anything but Sqlite)

## Bastion Hosts infrastructure per each VPC/environment

  * Bastion Hosts EC2 instances
  * Bastion hosts autoscaling (group of 1, reprovisioning on bastion loss)

## Application infrastructure per each VPC/environment

  * Web servers EC2 instances
  * Web servers autoscaling
  * IAM policies/roles for web servers for S3 access to CodeDeploy bundles and to do backups

## Load Balancers

  * ALB instance per environment to serve web traffic

## Storage

  * S3 bucket for CodeDeploy deployment bundles
  * S3 bucket for Notejam app backups

## Immutable infrastructure - Packer

  * Packer templates for immutable infrastructure AMI creation for Bastion Hosts
  * Packer templates for immutable infrastructure AMI creation for Web Servers
