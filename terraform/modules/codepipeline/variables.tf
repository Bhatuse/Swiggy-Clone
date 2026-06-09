variable "project_name"             {}
variable "environment"              {}
variable "codepipeline_role_arn"    {}
variable "artifact_bucket"          {}
variable "codestar_connection_arn"  {}
variable "github_repo"              {}   # "your-username/swiggy-clone"
variable "github_branch"            {}   # "main"
variable "codebuild_project_name"   {}
variable "codedeploy_app_name"      {}
variable "codedeploy_dg_name"       {}