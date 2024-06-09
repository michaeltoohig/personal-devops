terraform {
  required_providers {
    namecheap = {
      source = "namecheap/namecheap"
      version = "2.1.2"
    }
  }
}

provider "namecheap" {
  user_name = var.username
  api_user = var.username
  api_key = var.token
  client_ip = var.client_ip
  use_sandbox = false
}

