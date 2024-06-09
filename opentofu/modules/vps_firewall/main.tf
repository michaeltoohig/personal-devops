# TODO: make a firewall.
# Only one firewall can be attached to a VPS.
# Multiple VPS can attach to a single firewall.
#
# I want an initial firewall for `global` that allows SSH
#
# When I deploy an app which uses a port (ie. 80 & 443) I want each app to try to create or check that that firewall rules exists.
# Can a firewall be updated?
# Removing an app would then remove the rule for other apps.
# So the rule should be included in `global` perhaps as a second role to allow it to be run separately.
#

resource "linode_firewall_device" "my_device" {
firewall_id = linode_firewall.vps_firewall.id
entity_id = var.vps_instance_id
}

resource "linode_firewall" "vps_firewall" {
  label = var.label

  inbound_policy = "DROP"
  outbound_policy = "ACCEPT"

  inbound {
    label = "SSH"
    action = "ACCEPT"
    protocol = "TCP"
    ports = "22"
    ipv4 = ["0.0.0.0/0"]
    ipv6 = ["::/0"]
  }

  inbound {
    label    = "http"
    action = "ACCEPT"
    protocol  = "TCP"
    ports     = "80"
    ipv4 = ["0.0.0.0/0"]
    ipv6 = ["::/0"]
  }

  inbound {
    label    = "https"
    action = "ACCEPT"
    protocol  = "TCP"
    ports     = "443"
    ipv4 = ["0.0.0.0/0"]
    ipv6 = ["::/0"]
  }
}
