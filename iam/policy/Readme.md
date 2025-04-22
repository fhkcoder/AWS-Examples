## Convert to json

```sh
yq -o json policy.yml > policy.json
```

## Create an IAM policy
```sh
aws iam create-policy --policy-name my-policy --policy-document file://policy.json
```

## Attach Policies
```sh
aws iam attach-user-policy --user-name Faisal --policy-arn arn:aws:iam::872515279375:policy/my-policy
```

## Create-policy version (update-policy)
```sh
aws iam create-policy-version \
--policy-arn arn:aws:iam::872515279375:policy/my-policy \
--policy-document "$(yq -o json policy.yml)" \
--set-as-default
```