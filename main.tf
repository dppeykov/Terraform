# 1. Configure a provider

# AWS region (georgraphical area = us-east-2) -> multiple isolated AZs (DCs = us-east-2a, 2b ...)

provider "aws" {
    region = "us-east-2"
}

# 2. Configure a resource

# For each provider there are many different kinds of resources (servers, DBs, LBs ...)
# Resourse format: 
# resource "<PROVIDER>_<TYPE>" "<NAME>" {
# [CONFIG ...]
# }

resource "aws_instance" "example" {
ami = "ami-0c55b159cbfafe1f0"
instance_type = "t2.micro"

tags = {
    Name = "terraform-example" # EC2 name
}

}

# ami = required parameter - Amazon Machine Image (AMI) to run the EC2 instance - can find free/paid on AWS marketplace or build with Packer
# instance_type = required parameter - https://aws.amazon.com/ec2/instance-types/ - t2.micro = free tier
# terraform documentation - https://www.terraform.io/docs/providers/aws/r/instance.html

# To run the main.tf file go to the same folder in the terminal and type: terraform init
# The initial binary doesn't have the code for the providers, so on the first run it will scan the code and download what is needed
# terraform init (idempotent command - can run multiple times with the same result) -> terraform plan (to see what will be deployed before actually do it)
# terraform plan: (+) - be created, (–) - be deleted, (~) - be modified in place
# terraform apply - to actually create the infrastructure - asks for a confirmation to apply - keeps track of what's already created from that file

# Good to exclude from version control = .gitignore - .terraform (folder for temp scratch files), *.tfstate (terraform state files) and *.tfstate.backup
