# Nextra Docs Template 

This is a template for creating documentation with [Nextra](https://nextra.site).

[**Live Demo →**](https://nextra-docs-template.vercel.app)

[![](.github/screenshot.png)](https://nextra-docs-template.vercel.app)

## Install dependencies and run locally for previews

**npm**

```sh
npm install
npm run dev
```

**yarn**

```sh
yarn install
yarn dev
```

**pnpm**

```sh
pnpm i
pnpm dev
```

This will start the development server and you can view the app in your browser at http://localhost:3000.

## AWS deployment

1. Add permissions for github actions to run in your aws account
    1. [Create a role for OpenID Connect federation (console)](https://docs.aws.amazon.com/IAM/latest/UserGuide/id_roles_create_for-idp_oidc.html#idp_oidc_Create_GitHub)
1. Create policies and assign to the role

**Policy document**
```json
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "Statement1",
            "Effect": "Allow",
            "Action": [
                "s3:GetObjectTagging",
				"s3:ListBucket",
                "s3:GetObject",
                "s3:PutObject",
                "s3:DeleteObject",
				"s3:PutBucketWebsite",
                "s3:CreateBucket",
                "s3:PutBucketPolicy",
                "s3:GetBucketPolicy",
                "s3:GetBucketLocation",
                "s3:DeleteBucket",
                "s3:GetBucketAcl",
                "s3:GetBucketCors",
                "s3:GetBucketWebsite",
                "s3:GetBucketVersioning",
                "s3:GetAccelerateConfiguration",
                "s3:GetBucketRequestPayment",
                "s3:GetBucketLogging",
                "s3:GetLifecycleConfiguration",
                "s3:GetReplicationConfiguration",
                "s3:GetEncryptionConfiguration",
                "s3:GetObjectAttributes",
                "s3:GetBucketTagging",
                "s3:GetBucketObjectLockConfiguration",
                "s3:PutBucketTagging",
				"cloudfront:CreateCloudFrontOriginAccessIdentity",
                "cloudfront:GetCloudFrontOriginAccessIdentity",
                "cloudfront:DeleteCloudFrontOriginAccessIdentity",
				"cloudfront:CreateDistribution",
                "cloudfront:GetDistribution",
                "cloudfront:UpdateDistribution",
                "cloudfront:DeleteDistribution",
                "cloudfront:ListDistributions",
                "cloudfront:TagResource",
                "cloudfront:UntagResource",
                "cloudfront:ListTagsForResource"
            ],
            "Resource": [
                "*"
            ]
        }
    ]
}
```

3. Add and validate a certificate in the AWS Certificate Manager in the N. Virginia region for your domain (for use with CloudFront)
1. Add github variables for
    1. **AWS_ROLE_TO_ASSUME** : ARN for the role created in the first step
    1. **AWS_TERRAFORM_BUCKET** : name of the S3 bucket in AWS used for storing terraform state
    1. **DOMAIN** : domain used to find the certificate to associate with cloudfront and used for the name of the content bucket
    1. **WEB_ACL_ARN** (optional) : ARN for any WAF rules used for whitelisting IPs
    1. **AWS_REGION** : (eg: eu-west-1) used to host the content bucket and needs to be the same region as the terraform bucket. the cloudfront will always hosted in us-east-1
1. Add a CNAME to point to the cloudfront url for your domain.

## License

This project is licensed under the MIT License.
