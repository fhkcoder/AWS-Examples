## Create a VPC for peering && a subnet
```sh
aws ec2 create-vpc \
--tag-specifications 'ResourceType=vpc,Tags=[{Key="Name",Value="vpc-alpha"}]' \
--cidr-block 10.0.0.0/16 \
--query Vpc.VpcId \
--output text
```
```sh
aws ec2 create-subnet \
--vpc-id vpc-0725aed51cc6caafe \
--tag-specifications 'ResourceType=subnet,Tags=[{Key="Name",Value="subnet-alpha"}]' \
--cidr-block 10.0.0.0/16
```

## Create one more VPC and a subnet for it
```sh
aws ec2 create-vpc \
--tag-specifications 'ResourceType=vpc,Tags=[{Key="Name",Value="vpc-beta"}]' \
--cidr-block 12.0.0.0/16 \
--query Vpc.VpcId \
--output text
```
```sh
aws ec2 create-subnet \
--vpc-id vpc-0ed6d9d0774b07828 \
--tag-specifications 'ResourceType=subnet,Tags=[{Key="Name",Value="subnet-beta"}]' \
--cidr-block 12.0.0.0/16
```

## Create IGWs and attach it to both the VPCs 
```sh
aws ec2 create-internet-gateway --query InternetGateway.InternetGatewayId --output text
aws ec2 attach-internet-gateway --internet-gateway-id igw-0cba4b151a39767bd --vpc-id vpc-0ed6d9d0774b07828
```
```sh
aws ec2 create-internet-gateway --query InternetGateway.InternetGatewayId --output text
aws ec2 attach-internet-gateway --internet-gateway-id igw-07dfdb3ab6478907e --vpc-id vpc-0725aed51cc6caafe
```

## Create vpc peering connection
```sh
aws ec2 create-vpc-peering-connection \
--vpc-id vpc-0725aed51cc6caafe \
--peer-vpc-id vpc-0ed6d9d0774b07828 \
--query VpcPeeringConnection.VpcPeeringConnectionId \
--output text
```

## Accept VPC peering connection
```sh
aws ec2 accept-vpc-peering-connection \
--vpc-peering-connection-id pcx-0185e19770810501b
```

## Create a route for the route-tables of both VPCs to peering conection and also inetrnet gateways
```sh
aws ec2 create-route \
--route-table-id rtb-04fb5f966f0fff696 \
--destination-cidr-block 12.0.0.0/16 \
--vpc-peering-connection-id pcx-0185e19770810501b
```
```sh
aws ec2 create-route \
--route-table-id rtb-062144e5191117316 \
--destination-cidr-block 10.0.0.0/16 \
--vpc-peering-connection-id pcx-0185e19770810501b
```
```sh
aws ec2 create-route \
--route-table-id rtb-062144e5191117316 \
--destination-cidr-block 0.0.0.0/0 \
--gateway-id igw-0cba4b151a39767bd
```
```sh
aws ec2 create-route \
--route-table-id rtb-04fb5f966f0fff696 \
--destination-cidr-block 0.0.0.0/0 \
--gateway-id igw-07dfdb3ab6478907e
```

## Create 2 different ec2 instances with different template file configurations
```sh
aws cloudformation deploy \
--template-file template-a.yaml \
--stack-name EC2-A \
--capabilities CAPABILITY_IAM \
--region us-east-2
```
```sh
aws cloudformation deploy \
--template-file template-b.yaml \
--stack-name EC2-B \
--capabilities CAPABILITY_IAM \
--region us-east-2
```