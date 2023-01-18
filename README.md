# letsdosometerraform


The homework
Create a VPC, a subnet in that VPC, a network interface with an IP from that subnet and create an EC2 instance that uses that network interface. You will need to expose the 80 port to the internet, thus you will also need a security group created with terraform.

Initially use an s3 bucket as a state storage, once everything is created, curl the website from our ec2 instance and migrate the state to terraform cloud then  destroy the infrastructure.

You need to have an infrastructure creation workflow that takes all the possible parameters as input.
One workflow that migrates the state to the terraform cloud and another one that destroys the infrastructure.


-migrate-state  -backend-config=" organization=terraform-rayah workspaces.name=my-new-workspace"


- name: Download remote state file
      run: |
        echo "Fetching remote state file from S3..."
        aws s3 cp s3://bucketforterraformangit/develop/terraform.tfstate .


        wd3F3aMC4IJ2hw.atlasv1.mEIVXSoMMEdrTlSuoV3JUezsx6DhxqrpSIivfS0ycugWalG9blFXD0cfq3ima5mO3o0
   

