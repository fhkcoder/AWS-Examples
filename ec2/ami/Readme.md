## Create an AMI of the instance
```sh
aws ec2 create-image --instance-id i-0183e692cc3e9d85e --name "MyAMI-001"
```

## Copy the AMI to another region
```sh
aws ec2 copy-image \
--source-region us-east-2 \
--source-image-id ami-06309794e73dc40c9 \
--name "MyAMI-002" \
--region ca-central-1 \
--encrypted
```