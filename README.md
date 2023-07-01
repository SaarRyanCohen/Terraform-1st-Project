# Terraform-1st-Project
to create a full Devops work environment with several tools already integrated into an EC2 instance on AWS using Terraform, Ansible, Jenkins AND Docker.

Requirements:
Using Terraform
Create a VPC
Create 1 Public Subnet
Create Security group
Create Route table
Create Keypair
Create Internet Gateway
And connect all of them to an EC2.
On top of that add an event bridge that will turn on the EC2 at 7am and off at 7pm
And add an alert that will notify you when the EC2 is turn on and when it turned off
You can use SNS or SQS or Both.

Using Ansible
Create an ansible Playbook that will install on the EC2 the CI/CD tool Jenkins on port 8080.
Showing me the Login page with the EC2 instance public ip address is sufficient.
Install on the same Ec2 docker engine.
Do not use USER DATA
Pro Tip:
Try to add the ansible script as part of your terraform process.
It should run after the EC2 is deployed ( use depends_on) and read about the best ways to
use ansible with terraform together.

Bonus: Add Route 53 Using Terraform to the Architecture.
