## Create a User
```sh
aws iam create-user --user-name Faisal
```

## Attach Policies
```sh
aws iam attach-user-policy --user-name Faisal --policy-arn
```

## Create a policy and then attach it through Arn
```sh
aws iam create-policy --policy-name AllowEc2AccesstoFaisal --policy-document file://policy.json
```
```sh
aws iam attach-user-policy --user-name Faisal --policy-arn arn:aws:iam::872515279375:policy/AllowEc2AccesstoFaisal
```

## Create an Inline policy(hint: you don't need to attach it SEPARATELY)
```sh
aws iam put-user-policy \
--user-name Faisal \
--policy-name AllowEc2AccesstoFaisal2 \
--policy-document file://inline-policy.json
```
## Detach policies (name or arn)
```sh
aws iam detach-user-policy --user-name Faisal --policy-arn
```

## Inline-policy (only name)
```sh
aws iam delete-user-policy --user-name Faisal --policy-name AllowEc2AccesstoFaisal2
```

## Delete policy
```sh
aws iam delete-policy --policy-arn arn:aws:iam::872515279375:policy/AllowEc2AccesstoFaisal
```

## Delete User
```sh
aws iam delete-user --user-name Faisal
```