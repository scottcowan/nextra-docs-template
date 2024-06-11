# Nextra Docs Template 

This is a template for creating documentation with [Nextra](https://nextra.site).

[**Live Demo →**](https://nextra-docs-template.vercel.app)

[![](.github/screenshot.png)](https://nextra-docs-template.vercel.app)

## Quick Start

Click the button to clone this repository and deploy it on Vercel:

[![](https://vercel.com/button)](https://vercel.com/new/clone?s=https%3A%2F%2Fgithub.com%2Fshuding%2Fnextra-docs-template&showOptionalTeamCreation=false)

## Local Development

First, run `pnpm i` to install the dependencies.

Then, run `pnpm dev` to start the development server and visit localhost:3000.

## Setup deployments

1. Add permissions for github actions to run in your aws account
    1. [Create a role for OpenID Connect federation (console)](https://docs.aws.amazon.com/IAM/latest/UserGuide/id_roles_create_for-idp_oidc.html#idp_oidc_Create_GitHub)
1. Add and validate a certificate in the AWS Certificate Manager in the N. Virginia region for your domain (for use with CloudFront)
1. Add github variables for
    1. **AWS_ROLE_TO_ASSUME** : ARN for the role created in the first step
    1. **AWS_TERRAFORM_BUCKET** : name of the S3 bucket in AWS used for storing terraform state
    1. **DOMAIN** : domain used to find the certificate to associate with cloudfront and used for the name of the content bucket
    1. **WEB_ACL_ARN** (optional) : ARN for any WAF rules used for whitelisting IPs
    1. **AWS_REGION** : (eg: eu-west-1) used to host the content bucket and needs to be the same region as the terraform bucket. the cloudfront will always hosted in us-east-1
1. Add a CNAME to point to the cloudfront url for your domain.
## License

This project is licensed under the MIT License.
