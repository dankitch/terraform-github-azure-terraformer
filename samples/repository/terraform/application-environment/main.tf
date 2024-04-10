data "azurerm_client_config" "current" {
}

resource "random_string" "main" {
  for_each = var.environments
  length   = 8
  upper    = false
  special  = false
}

locals {
  extended_environments = {
    for key, value in var.environments : key => {
      subscription_id = value
      tenant_id       = module.sp[key].tenant_id
      client_id       = module.sp[key].application.client_id
      client_secret   = module.sp[key].service_principal.client_secret
      backend         = local.backends[key]
    }
  }
}

module "repo" {
  source           = "../../../../modules/repository/terraform/application-environment"
  application_name = var.application_name
  repo_name        = var.repo_name
  commit_user      = var.commit_user
  environments     = local.extended_environments
}

/*
module "azure-terraformer" {
  source  = "markti/azure-terraformer/github//modules/repository/terraform/application-environment"
  version = "1.0.1"

  application_name = "aztflab"
  name             = var.name
  commit_user      = var.commit_user
  environments     = local.extended_environments
}
*/
