## Create a bucket
```sh
aws s3 mb s3://encryption-bucket-011
```

### Create a file and put object with SSE-S3 encryption 
```sh
echo "Hello World!" > hello.txt
aws s3 cp hello.txt s3://encryption-bucket-011
```

### Put Object with SSE-KMS encryption
```sh
aws s3api put-object --bucket encryption-bucket-011 \
--key hello.txt --body hello.txt \
--server-side-encryption aws:kms \
--ssekms-key-id b3831067-f79d-47c2-a474-54e8da69dd87
```

### Put Object with SSE-C encryption [Failed Attempt]

export BASE64_ENCODED_KEY=$(openssl rand 32 | base64)
echo $BASE64_ENCODED_KEY

export MD5_VALUE=$(echo -n $BASE64_ENCODED_KEY | base64 --decode | md5sum | awk '{print $1}' | base64)
echo $MD5_VALUE

aws s3api put-object --bucket encryption-bucket-011 \
--key hello.txt --body hello.txt \
--sse-customer-algorithm AES256 \
--sse-customer-key $BASE64_ENCODED_KEY \
--sse-customer-key-md5 $MD5_VALUE

### Put Object with SSE-C encryption
```sh
https://catalog.us-east-2.prod.workshops.aws/workshops/aad9ff1e-b607-45bc-893f-121ea5224f24/en-US/s3/serverside/ssec

openssl rand -out ssec.key 32

aws s3 cp hello.txt s3://encryption-bucket-011/hello.txt \
--sse-c AES256 --sse-c-key fileb://ssec.key

aws s3 cp s3://encryption-bucket-011/hello.txt hello.txt \
--sse-c AES256 --sse-c-key fileb://ssec.key
```

//No option for dsse for s3 