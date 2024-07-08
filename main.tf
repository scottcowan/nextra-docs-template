terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.32.1"
    }
  }

  required_version = "~> 1.8.0"
  backend "s3" {}
}

provider "aws" {
  alias = "virginia"
  region = "us-east-1"
}

variable "domain" {
  description = "url to use for the tfstate file and cloudfront distribution (eg: site.acme.com)"
}

variable "region" {
  description = "the distribution will be created in us-east-1 but bucket will be in the region specified here"
}

variable "source_path" {
  description = "the location of the files to be uploaded"
  default = "./out"
}

variable "web_acl_arn" {
  description = "the arn of the web ACL"
  default = null
}

locals {
  default_tags = {
    App = var.domain
    ManagedByTerraform = "True"
  }
}

module "site_files" {
  source      = "github.com/marketing-delivery/terraform-modules//modules/s3-web-bucket"
  name        = var.domain
  tags        = local.default_tags
}

module "bucket_upload" {
  source      = "github.com/marketing-delivery/terraform-modules//modules/s3-upload"
  bucket_id = module.site_files.id
  source_path = var.source_path 
}

module "cloudfront_distribution" {
  source = "github.com/marketing-delivery/terraform-modules//modules/cloudfront"
  providers = {
    aws = aws.virginia
  }
  domain = var.domain
  bucket_id = module.site_files.id
  bucket_arn = module.site_files.bucket_arn
  bucket_regional_domain_name = module.site_files.bucket_regional_domain_name
  web_acl_id = var.web_acl_arn
  tags = local.default_tags
}

output "distribution_id" {
  value = module.cloudfront_distribution.id
}
