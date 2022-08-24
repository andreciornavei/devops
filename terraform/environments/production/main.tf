terraform {
  backend "http" {
  }
  required_providers {
    gitlab = {
      source  = "gitlabhq/gitlab"
      version = "~> 3.1"
    }
  }
}

provider "gitlab" {
  token = var.gitlab_access_token
}

data "aws_caller_identity" "current" {}

module "infra" {
  source             = "../../infra"
  environment        = "production"
  region             = var.region
  database_username  = "root"
  database_password  = var.database_password
  domain             = var.domain
  ses_email_from     = var.email_from
  tagname            = var.tag_name
  projectname        = var.project_name
  uid                = var.app_id
  rds_instance_class = var.rds_instance_class
  ec2_instance_class = var.ec2_instance_class
}
