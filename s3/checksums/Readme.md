## Create a new bucket

'''md
aws s3 mb s3://checksums-examples-fs-01
'''

## Create a file that we will do checksum versioning on

'''
echo "Hello Mars!" > myfile.txt
'''

## Get a checksum of a file for md5

'''md
md5sum myfile.txt
## ad9fa83779fd19527ed739033310bc2f *myfile.txt
'''

## upload the file and look at its etag
'''sh
aws s3 cp myfile.txt s3://checksums-examples-fs-01
aws s3api head-object --bucket checksums-examples-fs-01 --key myfile.txt
'''
## get the checksum of the file (7z in Windows) convert it into Base64 encoding
'''sh
7z h -scrcCRC32 myfile.txt
echo -n 0x379C2572 | xxd -r -p | base64
'''

## lets upload a file with a different kind of checksum
'''sh
aws s3api put-object \
--bucket="checksums-examples-fs-01" \
--key="myfilecrc32.txt" \
--body="myfile.txt" \
--checksum-algorithm="CRC32" \
--checksum-crc32="N5wlcg=="
'''