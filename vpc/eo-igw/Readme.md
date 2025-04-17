## Create a VPC with ipv6 address
```sh
aws ec2 create-vpc --cidr-block 10.0.0.0/16 --amazon-provided-ipv6-cidr-block
```

## Create a Subnet
```sh
aws ec2 create-subnet --vpc-id [vpc-id] --ipv6-cidr-block [ipv6-cidr]/64 --cidr-block 10.0.2.0/24
```

## Enable dns-64 for NAT translation from ipv6 to ipv4
```sh
aws ec2 modify-subnet-attribute --subnet-id [subnet-id] --enable-dns64 Value=true
```

## Create the eo-IGW && IGW and attach it
```sh
aws ec2 create-egress-only-internet-gateway --vpc-id [vpc-id]
aws ec2 create-internet-gateway
aws ec2 attach-internet-gateway --internet-gateway-id [igw-id] --vpc-id [vpc-id]
```

## Create an elasticIP address && NAT Gateway
```sh
aws ec2 allocate-address
aws ec2 create-nat-gateway --subnet-id [subnet-id] --allocation-id [Allocation-id from elasticip address]
```

## Create a Route-Table
```sh
aws ec2 create-route-table --vpc-id
```

## Create a Route for the eo-IGW/NAT-Gateway/IGW
```sh
aws ec2 create-route --route-table-id [RT-id] \
--destination-ipv6-cidr-block ::/0 \
--egress-only-internet-gateway-id [egress-igw-id]

aws ec2 create-route --route-table-id [RT-id] \
--destination-ipv6-cidr-block 64:ff9b::/96 \
--nat-gateway-id [NAT-gateway-id]

aws ec2 create-route --route-table-id [RT-id] \
--destination-cidr-block 0.0.0.0/0 --gateway-id [igw-id]
```
64:ff9b::/96 ----> used for ipv6 to ipv4 address translation

## Associate the Subnet with the Route Table
```sh
aws ec2 associate-route-table --route-table-id [RT-id] --subnet-id [subnet-id]
```

## Launch an ec2 instance
```sh
aws ec2 run-instances \
--tag-specifications ResourceType=instance,Tags=[{Key=Name,Value=Ipv6-server}] \
--image-id [image-id] \
--instance-type t3.micro \
--count 1 \
--associate-public-ip-address=true \
--iam-instance-profile Name=AmazonSSMManagedInstanceCore \
--network-interfaces DeviceIndex=0,Ipv6AddressCount=1,SubnetId=[subnet-id]
```

## To attach elastic IP to the ec2 instance
```sh
aws ec2 allocate-address --domain vpc

aws ec2 describe-instances --instance-ids [instance-id] \
--query "Reservations[].Instances[].NetworkInterfaces[].NetworkInterfaceId"

aws ec2 associate-address \
--allocation-id [eip-alloc-xxxx] \
--network-interface-id [eni-xxxx]
```

## Session Manager Commands to validate

sudo su - ec2-user
curl ifconfig.me

## Clean up

Terminate Instance
Delete NAT Gateway
Release Elastic IP
Delete VPC