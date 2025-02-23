## Create a bucket

```sh
aws s3api create-bucket --bucket acls-example-fs-01 \
--region us-west-1 \
--create-bucket-configuration LocationConstraint=us-west-1
``` 

## To perform the ACL tasks you need to have one more account
## Turn off Block Public Access for ACLs

```sh
aws s3api put-public-access-block \
--bucket acls-example-fs-01 \
--public-access-block-configuration "BlockPublicAcls=false,IgnorePublicAcls=false,BlockPublicPolicy=true,RestrictPublicBuckets=true"
```

```sh
aws s3api get-public-access-block --bucket acls-example-fs-01
```

## Change bucket ownership

```sh
aws s3api put-bucket-ownership-controls \
--bucket acls-example-fs-01 \
--ownership-controls="Rules=[{ObjectOwnership=BucketOwnerPreferred}]"
```
## Change ACLs to allow for a user in another AWS account

```sh
aws s3api put-bucket-acl --bucket amzn-s3-demo-bucket \
--access-control-policy file://policy.json  //or full path
```

## To find the canonical ID of the AWS account through cli

```sh
aws s3api list-buckets --query Owner.ID --output text
```

## Access bucket from the other account

```sh
touch bootcamp.txt
aws s3 cp bootcamp.txt s3://acls-example-fs-01
aws s3 ls s3://acls-example-fs-01
```

## Cleanup

```sh
aws s3 rm s3://acls-example-fs-01/bootcamp.txt
aws s3 rb s3://acls-example-fs-01
```