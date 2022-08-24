resource "aws_ssm_parameter" "ssm_server_uid" {
  name      = "server_uid"
  type      = "String"
  value     = var.uid
  overwrite = true
}

resource "aws_ssm_parameter" "ssm_ses_email_from" {
  name      = "appenv_ses_email_from"
  type      = "String"
  value     = var.ses_email_from
  overwrite = true
}

resource "aws_ssm_parameter" "ssm_node_env" {
  name      = "appenv_node_env"
  type      = "String"
  value     = var.environment
  overwrite = true
}

