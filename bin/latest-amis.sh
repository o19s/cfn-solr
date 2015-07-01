#!/usr/bin/env bash
# This script will find AMIs for the following OWNERS and Matches.
# We are looking for the latest RHEL-6.4_GA-x64_64 and amazon ami pv ebs
OWNERS=('RHEL' 'AMZN')
AMI_OWNERS=('309956199498' '137112412989')
AMI_MATCHES_309956199498=('Images[?Name!=`null`]|[?starts_with(Name, `RHEL-6.4_GA-x86_64-`) == `true`].[CreationDate,ImageId,Name]' 'Images[?Name!=`null`]|[?starts_with(Name, `RHEL-6.4_GA-i386-`) == `true`].[CreationDate,ImageId,Name]')
AMI_MATCHES_137112412989=('Images[?Name!=`null`]|[?starts_with(Name, `amzn-ami-pv-`) == `true`]|[?ends_with(Name, `x86_64-ebs`) == `true`].[CreationDate,ImageId,Name]')
REGIONS='us-east-1 us-west-1 us-west-2 eu-west-1 ap-southeast-1 ap-southeast-2 ap-northeast-1 sa-east-1'
for ((i=0; i < ${#OWNERS[@]}; i++)); do
    for region in $REGIONS; do
        AWS_DEFAULT_REGION=$region
        declare -n MATCH_ARRAY="AMI_MATCHES_${AMI_OWNERS[$i]}"
        for ((j=0; j < ${#MATCH_ARRAY[@]}; j++)); do
            RESULT=$(aws ec2 describe-images --owners "${AMI_OWNERS[$i]}" --output text --query "${MATCH_ARRAY[$j]}" | sort -k1 | tail -n1)
            ami=$(echo $RESULT | awk '{print $2}')
            name=$(echo $RESULT | awk '{print $3}')
            echo $ami $region $name
        done
    done
done
