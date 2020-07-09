# Terraform Task

Terraform code that deploys a VPC, with a private subnet, a public subnet, an EC2 instance in the private subnet and a bastion host to access the EC2 instance via SSH in a secure way.

## Requirements

1.- You have to create an AWS S3 bucket to enable remote state storage.
https://docs.aws.amazon.com/AmazonS3/latest/user-guide/create-bucket.html

2.- You have to create a AWS EC2 Key to prove your identity when connecting to an instance.

https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ec2-key-pairs.html#having-ec2-create-your-key-pair

## Usage

1.- Run this command:

docker build \
-t terraform \
--build-arg AWS_ACCESS_KEY_ID='<Your access key id>' \
--build-arg AWS_SECRET_ACCESS_KEY='<Your secret acces key>' \
--build-arg AWS_DEFAULT_REGION='us-east-1' \
--build-arg s3_bucket='<Your S3 Bucket (requirement 1)>' \
--build-arg key_pair='<Your Key Pair (requirement 2)>' \
 . && \
docker run -it --rm terraform

A docker container will be created and a bash shell is ready to go.

2.- Run this command:

./run_task1.sh

3.- Enjoy!

4.- When you finish your revies, run:

terraform destroy

to eliminate all created infraestructure in this demo.

5.- Run this command:

exit

to exit the docker container.