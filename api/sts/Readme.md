## Create a User with no permission

We need to create a new user with no permission and generate access keys
```sh
aws iam create-user --user-name sts-machine-user
aws iam create-access-key --user-name sts-machine-user --output table
```

copy the access key and secret key here
```sh
aws configure --profile sts   
```
Make sure to give --profile name not to replace with default access keys if you don't want to change permanently

Then edit credentials file to change away from the default profile 
```sh
vi ~/.aws/credentials
```
Test who you are
```sh
aws sts get-caller-identity
aws sts get-caller-identity --profile sts 
```

Make sure you don't have access to s3
```sh
aws s3 ls --profile sts
```
>An error occurred (AccessDenied) when calling the ListBuckets operation: User: arn:aws:iam::872515279375:user/sts-machine-user is not authorized to perform: s3:ListAllMyBuckets because no identity-based policy allows the s3:ListAllMyBuckets action

## Create a Role

We need to create a role that will access a new resource
```sh
./bin/deploy
```

## Use new credentials and assume role
```sh
aws sts assume-role \
--role-arn arn:aws:iam::872515279375:role/my-sts-stack-1122-StsRole-FuP0aXhYhe9A \
--role-session-name s3-sts-fun \
--profile sts
```
