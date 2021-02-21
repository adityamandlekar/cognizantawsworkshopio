#!/bin/bash

echo "  

        *************   Please wait as the script cleans the Resources created during the workshop. This will take approx. 8-10 minutes. *************  


"

set +e

sudo yum install jq -y&>install.out


export bucketname=$(aws secretsmanager get-secret-value --secret-id wrkshpSecrets| jq --raw-output .SecretString | jq -r .'Reports')

echo "  
        *************   Step : 1/9 :: Deleting the E2E Assurance Pipeline and Stack. *************  
"
aws cloudformation delete-stack --stack-name E2EAssurance
echo "  
                =======   Waiting for E2E Assurance Pipeline and Stack to be deleted. =======  
"
aws cloudformation wait stack-delete-complete --stack-name E2EAssurance

echo "  
        *************   E2E Assurance Pipeline and Stack deleted successfully. *************  

"

echo "  
        *************   Step : 2/9 :: Deleting the Experience Assurance Pipeline and Stack. *************  
"
aws cloudformation delete-stack --stack-name ExperienceAssurance

echo "  
                =======   Waiting for Experience Assurance Pipeline and Stack to be deleted. =======  
"
aws cloudformation wait stack-delete-complete --stack-name ExperienceAssurance
echo "  
        *************   Experience Assurance Pipeline and Stack deleted successfully. *************  

"


echo "  
        *************   Step : 3/9 :: Deleting the Functional Assurance Pipeline and Stack. *************  
"
aws cloudformation delete-stack --stack-name FunctionalAssurance
echo "  
                =======   Waiting for Functional Assurance Pipeline and Stack to be deleted. =======  
"
aws cloudformation wait stack-delete-complete --stack-name FunctionalAssurance
echo "  
        *************   Functional Assurance Pipeline and Stack deleted successfully. *************  

"


echo "  
        *************   Step : 4/9 :: Deleting the Post Build QA Pipeline and Stack. *************  
"
aws cloudformation delete-stack --stack-name PostBuildQA
echo "  
                =======   Waiting for Post Build QA Pipeline and Stack to be deleted. =======  
"
aws cloudformation wait stack-delete-complete --stack-name PostBuildQA
echo "  
        *************   Post Build QA Pipeline and Stack deleted successfully. *************  

"

echo "  
        *************   Step : 5/9 :: Deleting the Pre Build QA Pipeline and Stack. *************  
"
aws cloudformation delete-stack --stack-name PreBuildQA
echo "  
                =======   Waiting for Pre Build QA Pipeline and Stack to be deleted. =======  
"
aws cloudformation wait stack-delete-complete --stack-name PreBuildQA
echo "  
        *************   Pre Build QA Pipeline and Stack deleted successfully. *************  

"



echo "  
        *************   Step : 6/9 :: Deleting the ECR Repo. *************  
"
aws ecr delete-repository --repository-name awswrkshp-aut-frontend --force

echo "  
        *************   Finished ECR Repo deletion. *************  

"

echo "  
        *************   Step : 7/9 :: Deleting the S3 Bucket. *************  
"
aws s3 rm --recursive s3://$bucketname --quiet

aws s3 rb s3://$bucketname --force

echo "  
        *************   S3 Bucket deleted successfully. *************  

"


echo "  
        *************   Step : 8/9 :: Deleting the Create Repositories Stack. *************  
"
aws cloudformation delete-stack --stack-name CreateRepositories
echo "  
                =======   Waiting for Create Repositories Stack to be deleted. =======  
"
aws cloudformation wait stack-delete-complete --stack-name CreateRepositories
echo "  
        *************   Create Repositories Stack deleted successfully. *************  

"

echo "  
        *************   Step : 9/9 :: Initiating the Create Foundation Stack deletion. *************  
"
aws cloudformation delete-stack --stack-name CreateFoundationStack



echo "  


        *************   CleanUp Completed. Please check CloudFormation console to ensure all CloudFormation Templates are deleted *************  

"