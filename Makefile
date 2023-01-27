
all: docker_fargate

terraform:
	terraform -chdir=./terraform init
	terraform -chdir=./terraform apply
	
docker_fargate:
	docker build -f Dockerfiles/Fargate.Dockerfile . -t ditto
	aws ecr-public get-login-password --region us-east-1 | docker login --username AWS --password-stdin public.ecr.aws/x3d9o0r7
	docker tag ditto:latest public.ecr.aws/x3d9o0r7/ditto:latest
	docker push public.ecr.aws/x3d9o0r7/ditto:latest


docker_lambda:
	docker build -f Dockerfiles/Lambda.Dockerfile . -t ditto_lambda:latest

versions:
	aws --version
	aws sts get-caller-identity
	terraform --version

stream: 
	export PROMPT="NonpareilDevOps/$$(basename "$$PWD") $$ " 
