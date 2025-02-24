## Create a bucket

```sh
aws s3 mb s3://metadata-bucket-fs-01
```

## Create a new file

```sh
echo ""Hello Mars!" > hello.txt
```

## Upload file with metadata

```sh
aws s3api put-object --bucket metadata-bucket-fs-01 --key hello.txt --body hello.txt --metadata planet=Mars
```

## Get metadata through HEAD object

```sh
aws s3api head-object --bucket metadata-bucket-fs-01 --key hello.txt
```

## Cleanup

```sh
aws s3 rm s3://metadata-bucket-fs-01/hello.txt
aws s3 rb s3://metadata-bucket-fs-01
```