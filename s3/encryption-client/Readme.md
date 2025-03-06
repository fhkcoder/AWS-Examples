## Create a bucket
```sh
aws s3 mb s3://encrypt-client-example-01
```
## Run our sdk ruby script
```sh
bundle exec ruby encrypt.rb
```
## Clean up
```sh
aws s3 rm s3://encrypt-client-example-01/hello.txt
aws s3 rb s3://encrypt-client-example-01
```