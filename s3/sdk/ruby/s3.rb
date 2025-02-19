require "aws-sdk-s3"   # AWS SDK for Ruby to interact with S3
require "pry"           # Debugging tool (optional, used for interactive debugging)
require "securerandom"  # Standard library to generate random values

# Retrieve the S3 bucket name from environment variables
bucket_name = ENV["BUCKET_NAME"]

# AWS region where the S3 bucket will be created
region = "us-east-2"

# Initialize an S3 client instance
client = Aws::S3::Client.new
#binding.pry
# Create an S3 bucket with the specified name and region
resp = client.create_bucket({
  bucket: bucket_name, 
  create_bucket_configuration: {
    location_constraint: region, 
  } 
})


# Generate a random number of files between 1 and 6
number_of_files = 1 + rand(6)
puts "Number of files to create and upload: #{number_of_files}"

# Loop to create and upload multiple files
number_of_files.times.each do |i|
    puts "Processing file index: #{i}"
    
    # Generate a unique filename
    filename = "file_#{i}.txt"
    
    # Define the file's temporary storage path in the Windows temp folder
    output_path = "C:/Users/SHABAN/AppData/Local/Temp/#{filename}"

    # Create the file and write a unique random string to it
    File.open(output_path, "w") do |file|
        file.write(SecureRandom.uuid)  # Write a unique identifier
    end

    # Open the file in binary read mode and upload it to S3
    File.open(output_path, 'rb') do |file|
        client.put_object(
            bucket: bucket_name,  # Upload to the specified S3 bucket
            key: filename,         # The filename in S3
            body: file             # The file contents
        )
    end
    
    puts "Uploaded: #{filename} to S3 bucket: #{bucket_name}"
end
