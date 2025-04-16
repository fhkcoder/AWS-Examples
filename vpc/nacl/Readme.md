## Get the VPC ID
```sh
aws ec2 describe-vpcs \
--filters "Name=tag:Name,Values=nacl-example-vpc" \
--query "Vpcs[0].VpcId" --output text
```

## NACL
```sh
aws ec2 create-network-acl --vpc-id vpc-0abc1234def567890
```

## Add Entry
```sh
aws ec2 create-network-acl-entry \
--network-acl-id acl-090d4eef36a8a50a5 \
--ingress \
--rule-number 90 \
--protocol -1 \
--rule-action deny \
--cidr-block 223.123.9.246/32 \
--region us-east-2
```

## Get AMI for Amazon Linux 2
```sh
aws ec2 describe-images \
--region us-east-2 \
--owners amazon \
--filters "Name=name,Values=amzn2-ami-hvm-*-x86_64-gp2" "Name=state,Values=available" \
--query "Images | sort_by(@, &CreationDate) | [-1].ImageId" \
--output text
```

ami-04985531f48a27ae7