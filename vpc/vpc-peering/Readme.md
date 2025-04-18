## Create a VPC for peering && a subnet
```sh
aws ec2 create-vpc --cidr-block 10.0.0.0/16 --query Vpc.VpcId --output text
aws ec2 create-subnet --vpc-id vpc-004bf84e8e6418907 --cidr-block 10.0.2.0/20
aws ec2 create-tags --resources vpc-004bf84e8e6418907 --tags '[{"Key":"Name","Value":"vpc-alpha"}]'
aws ec2 create-tags --resources subnet-047f38e5e89ad05a8 --tags '[{"Key":"Name","Value":"subnet-alpha"}]'
```

## Create one more VPC and a subnet for it
```sh
aws ec2 create-vpc --cidr-block 12.0.0.0/16 --query Vpc.VpcId --output text
aws ec2 create-tags --resources vpc-0f60c56108b1736c9 --tags '[{"Key":"Name","Value":"vpc-beta"}]'

aws ec2 create-subnet \
--vpc-id vpc-0f60c56108b1736c9 \
--tag-specifications 'ResourceType=subnet,Tags=[{Key="Name",Value="subnet-beta"}]' \
--cidr-block 12.0.2.0/20
```

## Create vpc peering connection
```sh
aws ec2 create-vpc-peering-connection --vpc-id vpc-004bf84e8e6418907 --peer-vpc-id vpc-0f60c56108b1736c9
```

## Accept VPC peeing connection
```sh
aws ec2 accept-vpc-peering-connection --vpc-peering-connection-id pcx-09a1545e9f457b277
```

## Create a route for the route-tables of both VPCs to connect
```sh
aws ec2 create-route --route-table-id rtb-09169ac2540f98ad6 --destination-cidr-block 12.0.0.0/16 --vpc-peering-connection-id pcx-09
a1545e9f457b277

aws ec2 create-route --route-table-id rtb-03bf927ac9f177f2b --destination-cidr-block 10.0.0.0/16 --vpc-peering-connection-id pcx-09a1545e9f457b277
```