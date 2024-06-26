variable "application_name" {
  type = string
}
variable "repo_name" {
  type = string
}
variable "commit_user" {
  type = object({
    name  = string
    email = string
  })
}
variable "visibility" {
  type    = string
  default = "public"
}
variable "environments" {
  type = map(object({

    subscription_id = string
    tenant_id       = string
    client_id       = string
    client_secret   = string
    backend = object({
      resource_group_name  = string
      storage_account_name = string
      container_name       = string
    })
  }))
}
variable "terraform_version" {
  type    = string
  default = "1.6.6"
}
