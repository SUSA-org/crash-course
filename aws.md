# Welcome to AWS - EC2 Management

This tutorial is about using Amazon Web Services (AWS) Command Line Interface (awscli) for launching, starting, stopping instances and the related tasks to do so.

Related tasks:
* Managing Identities to your AWS account (not awscli) [Not Implemented]
* Creating and Authenticating AWS EC2 security groups (awscli)
* Notes on VPCs (can be awscli)
	* IP/CIDR notation and some open questions

Steps to this tutorial:
1. Authentication Management
2. Instance Management
3. Notes on infrastructure for parallel computing / MPI

## 1. Authentication Management - Planned Completion

First, you want to create an admin/root identity for your AWS account. You should be using this at all times to engage in AWS management console.

Then you want to create identity groups with permissions to start instances. And like test them out. Honestly, not sure if you even want to give out this permission because they can charge directly to your account by running instances. Especially p2.xlarges. Well, actually, if you only have 1 p2.xlarge (or whatever instance type being used to perform deep learning, and your identity group can only start p2 instances, than it's not a big deal). 

Then create a key-pair for ec2, and distribute the key to your identity-group.

## 2. Instance Management - Planned Completion

Configure your awscli profile to be making queries from the us-west-2 region (US West - Oregon). It's where the p2.xlarges are located.

Launching and starting an instance. 

```bash
aws ec2 run-instances --image-id [AMI id] --count 1 --security-groups-id "[security group id]" --key-name [name of your key pair (do not include .pem)] --instance-type p2.xlarge
```

Starting instances from instance ids.

```bash
aws ec2 start-instances --instance-ids "[instance-ids]"
```

Finding instance ids.
```bash
aws ec2 describe-instances | grep "InstanceId"
```

Stopping an instance.
```bash
aws ec2 stop-instances --instance-ids "[instance=ids]"
```

## 3. Parallel Computing Infrastructure

You're going to want to specify your own Virtual Private Cloud (VPC) via AWS. And specify your instances to be a part of this VPC, or on the same subnet. This will require specificying an internet gateway to your VPC, as well as specs to allow your instances on the subnet to ping each other. More information, [look here](https://treyperry.com/2015/06/22/ipv4-cidr-vpc-in-a-nutshell/).

More to the point. Maybe also need MPI? It stands for [Message Passing Interface](http://mpitutorial.com/tutorials/launching-an-amazon-ec2-mpi-cluster/). It's a protocol(?) developed by MIT researchers for cluster computing. I don't know how it works. I don't know what types of instances to use with it, and I haven't tried the commands listed in the link (above).
