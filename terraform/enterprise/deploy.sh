#!/bin/bash

set -xe

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

# Some dependent AWS modules (EKS, RDS) do not yet support Terraform 0.12,
# So we need to clone the repo, which has patched versions of the dependent
# modules locally installed.
if [ ! -d $DIR/terraform-aws-astronomer-aws ]; then
  git clone https://github.com/astronomer/terraform-aws-astronomer-aws.git
fi
if [ ! -d $DIR/terraform-kubernetes-astronomer ]; then
  git clone https://github.com/astronomer/terraform-kubernetes-astronomer.git
fi

terraform init

# deploy EKS, RDS
terraform apply -var-file=$DIR/terraform.tfvars.sample --target=module.aws --auto-approve

# install Tiller in the cluster
terraform apply -var-file=$DIR/terraform.tfvars.sample --target=module.system_components --auto-approve

# install astronomer in the cluster
terraform apply -var-file=$DIR/terraform.tfvars.sample --target=module.astronomer --auto-approve
