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

