resource "random_password" "password" {
  length  = 16
  lower   = true
  upper   = true
  special = true
}
