###############################################################
## iam_group_membership
###############################################################

output "dev_group_name" {
  value = module.dev_group.group_name
}

output "infra_group_name" {
  value = module.infra_group.group_name
}

output "dev_group_user_names" {
  value = module.dev_group.user_names
}

output "infra_group_user_names" {
  value = module.infra_group.user_names
}

output "dev_group_encrypted_passwords" {
  value = module.dev_group.formatted_decrypted_passwords
}

output "infra_group_encrypted_passwords" {
  value = module.infra_group.formatted_decrypted_passwords
}

###############################################################
## iam_policy
###############################################################

output "lambda_policy_arn" {
  value = module.lambda_iam_policy.arn
}

###############################################################
## iam_role
###############################################################

output "lambda_role_arn" {
  value = module.lambda_iam_role.arn
}

###############################################################
## Frontend_S3
###############################################################

output "S3_arn" {
  value = module.s3.bucket_arn
}

output "S3_url" {
  value = module.s3.website_endpoint
}