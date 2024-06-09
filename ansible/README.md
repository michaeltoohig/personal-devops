# Ansible

Configuration management for resources provisioned from OpenTofu.

## Managing Secrets

Secrets for each project are stored in `environments/{{ enviornment_name }}/vars/` directory.

Use the global vault password file `vault_password` when creating or editing a vault file.

```sh
ansible-vault {create|edit} --vault-password-file vault_password environments/{{ enviornment_name }}/vars/proj_name_vault.yml
```

Then use the same vault file when running playbooks.

```sh
ansible-playbook --vault-password-file vault_password -i environments/{{ enviornment_name }} playbook.yml
```

The secrets are included in the playbook in the `playbooks/proj_name.yml` file.

```yml
- name: Playbook name
  vars_files:
    - ../environments/{{ enviornment_name }}/vars/proj_name_vars.yml # unencrypted vars
    - ../environments/{{ enviornment_name }}/vars/proj_name_vault.yml # encrypted vars
  roles:
    - ../roles/proj_name
```
