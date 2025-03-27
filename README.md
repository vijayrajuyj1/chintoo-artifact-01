# Deploy Springboot application on ec2 instance

**steps**

1) Create Infrastructure using Terraform **[main.tf]**  in the code (vpc, subnets, internet gateway, subnenet association,  security groups , s3 , ec2 instances )

2) Write .github/workflows/ant.yaml cicd fior automation in that we have some stages

   - github runners
     
   - install java 8
     
   - install awscli
     
   - copy that .*jar file to s3
     
   - Deploy to ec2
     
   - copy that .*jar file s3  to ec2 and run that .jarfile in background
  
     # note: All the stages are explinaed in the .github/workflows/ant.yaml
     
