resource "null_resource" "setup" {
  provisioner "remote-exec" {
    connection {
      type = "ssh"
      user = "root"
      host = "${var.host}"
      private_key = "${chomp(file(var.root_ssh_privkey))}"
    }

    inline = [
      # install Python dependency for Ansible
      "which python || apt-get -y install python",

      # non-root user account
      "id -u ${var.username} || useradd -m -s /bin/bash ${var.username}",
      "groups ${var.username} | grep -q sudo || usermod -a -G sudo ${var.username}",
      "[ -f /etc/sudoers.d/${var.username} ] || echo '${var.username} ALL = NOPASSWD : ALL' > /etc/sudoers.d/${var.username}",
      "[ -d /home/${var.username}/.ssh ] || mkdir /home/${var.username}/.ssh",
      "[ -f /home/${var.username}/.ssh/authorized_keys ] || echo '${chomp(file(var.user_ssh_pubkey))}' > /home/${var.username}/.ssh/authorized_keys",
      "chown -R ${var.username}:${var.username} /home/${var.username}/.ssh",
      "chmod 701 /home/${var.username}/.ssh",
      "chmod 601 /home/${var.username}/.ssh/authorized_keys"
    ]
  }
}

resource "null_resource" "ansible_setup" {
  depends_on = [null_resource.setup]

  provisioner "local-exec" {
    command = "ansible-galaxy install -r ../../../../ansible/requirements.yml"
  }

  provisioner "local-exec" {
    command = "../../../generate-inventory.sh > ../../../../ansible/environments/${var.environment_name}/inventory"

    environment = {
      USERNAME = "${var.username}"
      SSH_PRIVKEY = "${var.user_ssh_privkey}"
      HOST_IP = "${var.host}"
    }
  }

}

resource "null_resource" "ansible_playbook" {
  depends_on = [null_resource.ansible_setup]

  provisioner "local-exec" {
    command = "cd ../../../../ansible && ansible-playbook -i ./environments/${var.environment_name}/inventory playbooks/001-tofu-init-vps.yml"

    environment = {
      ANSIBLE_HOST_KEY_CHECKING = "False"
    }
  }
}
