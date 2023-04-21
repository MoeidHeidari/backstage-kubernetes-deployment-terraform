
#==============================================================================#
#                                                                              #
#                             Grafana                                          #
#                                                                              #
#==============================================================================#

# Deploys Grafana and all of it's component with helmchart
resource "helm_release" "grafana" {
  name       = var.grafana_helm_release_name
  repository = var.grafana_helm_repo
  chart      = var.grafana_helm_chart_name
  namespace  = var.grafana_helm_namespace
  version    = var.grafana_helm_chart_version
  wait       = "false"

  set {
    name  = "persistence.size"
    value = var.grafana_helm_storage
  }
}
#==============================================================================#
#                                                                              #
#                             Backstage-Postgresql                             #
#                                                                              #
#==============================================================================#
#--------------------------------------------------------------------------------
# Makes a separated namespace for backstage with all 3th party services deployes in the same namespace
resource "kubernetes_namespace" "backstage_namespace" {
  metadata {
    name = var.backstage_namespace
  }
}
#--------------------------------------------------------------------------------
# Deploys Postgresql and all of it's component with helmchart
resource "helm_release" "postgresql" {
  name       = var.postgresql_helm_release_name
  repository = var.postgresql_helm_repo
  chart      = var.postgresql_helm_chart_name
  namespace  = var.backstage_namespace
  version    = var.postgresql_helm_chart_version
  wait       = "false"

  set {
    name  = "persistence.size"
    value = var.postgresql_helm_storage
  }
  set {
    name  = "global.postgresql.auth.username"
    value = var.postgresql_helm_username
  }
  set {
    name  = "global.postgresql.auth.password"
    value = var.postgresql_helm_password
  }
  set {
    name  = "persistence.size"
    value = var.postgresql_helm_storage
  }
}
#--------------------------------------------------------------------------------
# Deploys a secret for backstage that holds all secret data required for backstage configuration
resource "kubernetes_secret" "backstage_secrets" {
  metadata {
    name = "${var.backstage_name}-secrets"
    namespace = var.backstage_namespace
  }
  type = "Opaque"
  data = {
    "GITHUB_TOKEN"=var.backstage_secret_github_token
    "GITLAB_TOKEN"=var.backstage_secret_auth_gitlab_token
    "AZURE_TOKEN"=var.backstage_secret_auth_gitlab_token
    "AUTH_GITHUB_CLIENT_ID": var.backstage_secret_auth_github_client_id
    "AUTH_GITHUB_CLIENT_SECRET": var.backstage_secret_auth_github_client_secret
    "ROLLBAR_ACCOUNT_TOKEN"=var.backstage_secret_auth_rolbar_token
    "POSTGRES_HOST"="postgresql.backstage.svc.cluster.local"
    "POSTGRES_PORT"="5432"
    "POSTGRES_USER"=var.postgresql_helm_username
    "POSTGRES_PASSWORD"=var.postgresql_helm_password
    "BACKEND_SECRET"="z2TyOZZOqrTv7aiihv+kNAYWBy0ssuz+"

  }
}
#--------------------------------------------------------------------------------
# Deploys backstage deployment
resource "kubernetes_deployment" "backstage_deployment" {
  metadata {
    name = var.backstage_name
    namespace = var.backstage_namespace
  }
  spec {
    replicas = "1"
    selector {
      match_labels = {"app":"backstage"}
    }
    template {
      metadata {
        labels = {"app":"backstage"}

      }
      spec {
        container {
          name = "backstage-backend"
        image = "devopshobbies/backstage:v1.4.0"
          image_pull_policy = "IfNotPresent"
        port {
          name = "http"
          container_port = 7007

        }
          env_from {
            secret_ref {
              name = "${var.backstage_name}-secrets"
            }
          }
          env_from {
            secret_ref {
              name = "postgresql"
            }
          }
        }
      }
    }
  }
}