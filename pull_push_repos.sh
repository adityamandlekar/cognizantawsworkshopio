#!/bin/bash

echo "

================== Please wait as the code is downloaded to your codecommit repositories. This will take approx. 3-5 minutes. ================== 

"

region=$(aws configure get region)


export REPO_PATH="https://git-codecommit."$region".amazonaws.com/v1/repos/"
export FRONTEND_REPO=$REPO_PATH"awswrkshp-aut-frontend.git"
export BACKEND_REPO=$REPO_PATH"awswrkshp-aut-backend.git"
export DASHBOARD_REPO=$REPO_PATH"awswrkshp-report-dashboard.git"
export FUNCTIONAL_REPO=$REPO_PATH"awswrkshp-functional-assurance.git"
export PERFORMANCE_REPO=$REPO_PATH"awswrkshp-tests-performance.git"
export SECURITY_REPO=$REPO_PATH"awswrkshp-tests-security.git"
export ACCESSIBILITY_REPO=$REPO_PATH"awswrkshp-tests-accessibility.git"



#download all repos
aws s3 cp s3://aws-wrkshp-artifacts/awsworkshop_code_repositories . --recursive --quiet

#frontend repo

cd awswrkshp-aut-frontend
git init
git add .
git commit -m "init commit"  --quiet
git remote add origin $FRONTEND_REPO
git push -u origin master --quiet
cd ..

# backend repo

cd awswrkshp-aut-backend
git init
git add .
git commit -m "init commit" --quiet
git remote add origin $BACKEND_REPO
git push -u origin master --quiet
cd ..

#dashboard repo
cd awswrkshp-report-dashboard
git init
git add .
git commit -m "init commit" --quiet
git remote add origin $DASHBOARD_REPO
git push -u origin master --quiet
cd ..


#functional test repo
cd awswrkshp-functional-assurance
git init
git add .
git commit -m "init commit" --quiet
git remote add origin $FUNCTIONAL_REPO
git push -u origin master --quiet
cd ..
#nft - performance repo
cd awswrkshp-tests-performance
git init
git add .
git commit -m "init commit" --quiet
git remote add origin $PERFORMANCE_REPO
git push -u origin master --quiet
cd ..
#nft - security repo
cd awswrkshp-tests-security
git init
git add .
git commit -m "init commit" --quiet
git remote add origin $SECURITY_REPO
git push -u origin master --quiet
cd ..
#nft - accessbility repo
cd awswrkshp-tests-accessibility
git init
git add .
git commit -m "init commit" --quiet
git remote add origin $ACCESSIBILITY_REPO
git push -u origin master --quiet

echo "

        ==================      All the repositories are now uploded to your code commit        ================== 

"
