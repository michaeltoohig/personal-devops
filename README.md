# Personal DevOps

This repo contains my Ansible and OpenTofu scripts for deploying my personal projects.
This is heavily influenced by a project by `tboronczyk` which can can be found [here](https://github.com/tboronczyk/provision-linode.git).

## Getting Started

Before you begin, ensure both OpenTofu and Ansible are installed locally.

First, generate SSH keypairs for the root and user accounts.

```sh
ssh-keygen -N "" -C root@example.com -f keys/example-root
ssh-keygen -N "" -C user@example.com -f keys/example-user
```

Second, prepare the environment variables for OpenTofu.
Each environment is a separate directory in the `opentofu/environments` directory.

```sh
cd opentofu/environments
mkdir ./${ENVIRONMENT_NAME}
cp terraform.tfvars.example ./${ENVIRONMENT_NAME}/terraform.tfvars
```

Third, from within an environments directory, run OpenTofu to provision the infrastructure.

```sh
cd opentofu/environments/${ENVIRONMENT_NAME}
tofu init
tofu plan
tofu apply
tofu destroy
```

### Adding a New Project

#### Provisioning a New Project

It is likely the `global` service found in `opentofu/environments/${ENVIRONMENT_NAME}` will likely cover my needs for my small projects.
It is likely that a new project will need a domain or subdomain provisioned so when that is the case create a new `proj_` service and module

```sh
mkdir opentofu/environments/${ENVIRONMENT_NAME}/proj_${PROJECT_NAME}
mkdir opentofu/modules/proj_${PROJECT_NAME}
```

In the project's service you can import the global `vps_public_ip` from Terraform remote state for DNS or other infrastructure that requires it.

```hcl
data "terraform_remote_state" "global" {
  backend = "local"
  config = {
    path = "../global/terraform.tfstate"
  }
}
```

Be sure to include the appropriate `environment_name` in the project's `locals`.

```hcl
locals {
  environment_name = "development"
}
```

Then run the project's module which should provision everything required by the project.

#### Configuring a New Project

Once the appropriate infrastructure is provisioned the configuration can be built.
First, we need a project playbook and role.

```sh
mkdir ansible/playbooks/proj_${PROJECT_NAME}.yml
mkdir ansible/roles/proj_${PROJECT_NAME}
```

Once common roles are run in the playbook the project role can run in the playbook.
This should mean any given project can be deployed in any order of the other projects.
Later, I may want to change this and create setup roles or playbooks for particular types of projects that share the same basic configuration setup for Nginx, Docker, etc.

The project's variables can be stored in the appropriate environment directory.

```sh
nano ansible/environments/${ENVIRONMENT_NAME}/vars/proj_{PROJECT_NAME}_vars.yml
ansible-vault create --vault-password-file vault_password -i environments/${ENVIRONMENT_NAME}/vars/proj_${PROJECT_NAME}_vault.yml
```
