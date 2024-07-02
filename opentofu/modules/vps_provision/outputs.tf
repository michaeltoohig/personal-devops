output "vps_public_ip" {
  value = "${linode_instance.instance.ip_address}"
}

output "vps_public_ipv6" {
  value = "${linode_instance.instance.ipv6}"
}

output "vps_instance_id" {
  value = "${linode_instance.instance.id}"
}
