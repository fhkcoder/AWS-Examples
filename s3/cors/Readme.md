# Create Website 1

## Create a bucket
```sh
aws s3 mb s3://cors-example-fs-01
```

## Change block public access
```sh
aws s3api put-public-access-block \
--bucket cors-example-fs-01 \
--public-access-block-configuration "BlockPublicAcls=true,IgnorePublicAcls=true,BlockPublicPolicy=false,RestrictPublicBuckets=false"
```

## Create a bucket policy
```sh
aws s3api put-bucket-policy --bucket cors-example-fs-01 --policy file://bucket-policy.json
```
## Turn on static website hosting
```sh
aws s3api put-bucket-website --bucket cors-example-fs-01 --website-configuration file://website.json
```
## Upload index.html file and include a resource that would be cross-origin
```sh
aws s3 cp index.html s3://cors-example-fs-01
```

## View the website using following endpoint
(either website. or website-)
```sh
http://cors-example-fs-01.s3-website.us-east-2.amazonaws.com
```

# Create Website 2

## Create a bucket
```sh
aws s3 mb s3://cors-example-fs-02
```

## Change block public access
```sh
aws s3api put-public-access-block \
--bucket cors-example-fs-02 \
--public-access-block-configuration "BlockPublicAcls=true,IgnorePublicAcls=true,BlockPublicPolicy=false,RestrictPublicBuckets=false"
```

## Create a bucket policy
```sh
aws s3api put-bucket-policy --bucket cors-example-fs-02 --policy file://bucket-policy2.json
```
## Turn on static website hosting
```sh
aws s3api put-bucket-website --bucket cors-example-fs-02 --website-configuration file://website.json
```

## Upload javascript file and include a resource that would be cross-origin
```sh
aws s3 cp hello.js s3://cors-example-fs-02
```

## Create an API Gateway with mock response and then test it

```sh
curl -X POST https://kkqgcbuc21.execute-api.us-east-2.amazonaws.com/prod/hello \
-H "Content-Type: application/json"
```

## Get CORS on the bucket
```sh
aws s3api put-bucket-cors --bucket cors-example-fs-01 --cors-configuration file://cors.json
```