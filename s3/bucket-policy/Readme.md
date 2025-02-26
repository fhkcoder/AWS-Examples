## Create a bucket
```sh
aws s3 mb s3://bucket-policy-example-01
```
## Bucket Policy using AWS cli
```sh
aws s3api put-bucket-policy --bucket bucket-policy-example-01 --policy file://policy.json
```