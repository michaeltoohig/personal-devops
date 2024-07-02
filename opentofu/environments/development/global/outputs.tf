output "vps_public_ip" {
  value = "${module.vps_provision.vps_public_ip}"
}

output "vps_public_ipv6" {
  value = "${module.vps_provision.vps_public_ipv6}"
}
