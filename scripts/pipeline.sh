set -eou pipefail

aws cloudformation deploy \
  --template-file ci/codepipeline.yml \
  --stack-name codepipeline-flame-backups \
  --capabilities CAPABILITY_IAM \
  --region eu-west-1 \
  --profile backups
