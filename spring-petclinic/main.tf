terraform {
  required_providers {
    clevercloud = {
      source = "clevercloud/clevercloud"
      version = "0.9.0"
    }
  }
}

provider "clevercloud" {
  # Configuration options
  organisation = var.organization_id
}

resource "clevercloud_postgresql" "pg_petclinic_01" {
  name   = "pg-petclinic-01"
  plan   = "xxs_sml"
  region = "par"
}

resource "clevercloud_java_war" "spring_petclinic_01" {
  name                = "spring-petclinic-01"
  region              = "par"
  min_instance_count  = 1
  max_instance_count  = 2
  smallest_flavor     = "XS"
  biggest_flavor      = "M"
  dependencies        = [
    # clevercloud_postgresql.pg_petclinic_01.id
    "postgresql_142e22cd-7bcc-45f1-a363-d398f0732df8"
  ]

  deployment {
    repository = "https://github.com/cpontet/spring-petclinic.git"
  }
  environment = {
    CC_JAVA_VERSION        = "21"
    MAVEN_DEPLOY_GOAL      = "spring-boot:run"
    SPRING_PROFILES_ACTIVE = "postgres"
    POSTGRES_URL           = "jdbc:postgresql://${clevercloud_postgresql.pg_petclinic_01.host}:${clevercloud_postgresql.pg_petclinic_01.port}/${clevercloud_postgresql.pg_petclinic_01.database}"
    POSTGRES_PASS          = clevercloud_postgresql.pg_petclinic_01.password
    POSTGRES_USER          = clevercloud_postgresql.pg_petclinic_01.user
  }
}

output "pg-host" {
  value = clevercloud_postgresql.pg_petclinic_01.host
}

output "pg-addon-id" {
  value = clevercloud_postgresql.pg_petclinic_01.id
}