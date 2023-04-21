

#==============================================================================#
#                                                                              #
#                             grafana group var                                #
#                                                                              #
#==============================================================================#
# Defines a release name for grafana
variable "grafana_helm_release_name"{
  type= string
  default = "grafana"
}
#--------------------------------------------------------------------------------
# Defines the repository name for grafana helm deploy
variable "grafana_helm_repo" {
  type = string
  default = "https://charts.bitnami.com/bitnami"
}
#--------------------------------------------------------------------------------
# Defines the chart name for grafana helm deploy
variable "grafana_helm_chart_name" {
  type = string
  default = "grafana"
}
#--------------------------------------------------------------------------------
# Defines the namespace name for grafana helm deploy
variable "grafana_helm_namespace" {
  type = string
  default = "default"
}
#--------------------------------------------------------------------------------
# Defines the chart version for grafana helm deploy
variable "grafana_helm_chart_version" {
  type = string
  default = "8.2.22"
}
#--------------------------------------------------------------------------------
# Defines the storage for grafana persistence volume
variable "grafana_helm_storage" {
  type = string
  default = "10Gi"
}
#==============================================================================#
#                                                                              #
#                             Backstage group var                              #
#                                                                              #
#==============================================================================#
variable "backstage_namespace" {
  type = string
  default = "backstage"
}
#==============================================================================#
#                                                                              #
#                             Postgresql group var                             #
#                                                                              #
#==============================================================================#
# Defines a release name for postgresql
variable "postgresql_helm_release_name"{
  type= string
  default = "postgresql"
}
#--------------------------------------------------------------------------------
# Defines the repository name for postgresql helm deploy
variable "postgresql_helm_repo" {
  type = string
  default = "https://charts.bitnami.com/bitnami"
}
#--------------------------------------------------------------------------------
# Defines the chart name for postgresql helm deploy
variable "postgresql_helm_chart_name" {
  type = string
  default = "postgresql"
}

#--------------------------------------------------------------------------------
# Defines the chart version for postgresql helm deploy
variable "postgresql_helm_chart_version" {
  type = string
  default = "12.2.8"
}
#--------------------------------------------------------------------------------
# Defines the storage for postgresql persistence volume
variable "postgresql_helm_storage" {
  type = string
  default = "20Gi"
}
#--------------------------------------------------------------------------------
# Defines the username for postgresql
variable "postgresql_helm_username" {
  type = string
  default = "kaiser"
}
#--------------------------------------------------------------------------------
# Defines the username for postgresql
variable "postgresql_helm_password" {
  type = string
  default = "DevopsHobbies!@#$%"
}
#==============================================================================#
#                                                                              #
#                             Backstage group var                              #
#                                                                              #
#==============================================================================#
#--------------------------------------------------------------------------------
#Defines the backstage instance name
variable "backstage_name" {
  type = string
  default = "backstage"
}
#--------------------------------------------------------------------------------
#defines backstage github token
variable "backstage_secret_github_token" {
  type = string
  default = "....."
}
#--------------------------------------------------------------------------------
#defines backstage github oAth2.0 client id for Authentication/authorization
variable "backstage_secret_auth_github_client_id" {
  type = string
  default = "....."
}
#--------------------------------------------------------------------------------
#defines backstage github oAth2.0 client secret for Authentication/authorization
variable "backstage_secret_auth_github_client_secret" {
  type = string
  default = "....."
}
#--------------------------------------------------------------------------------
#defines backstage rolbar token
variable "backstage_secret_auth_rolbar_token" {
  type = string
  default = "....."
}
#--------------------------------------------------------------------------------
#defines backstage gitlab token
variable "backstage_secret_auth_gitlab_token" {
  type = string
  default = "....."
}




