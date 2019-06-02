#!/bin/bash
#Mukesh Waghadhare

# Retries a command on failure.
# $1 - the max number of attempts
# $2... - the command to run

retry() {
    local -r -i max_attempts="$1"; shift
    local -r cmd="$@"
    local -i attempt_num=1

    until $cmd
    do
        if (( attempt_num == max_attempts ))
        then
            echo "Attempt $attempt_num failed and there are no more attempts left!"
            return 1
        else
            echo "Attempt $attempt_num failed! Trying again in $attempt_num seconds..."
            sleep $(( attempt_num++ ))
        fi
    done
}


CMD="$@"
AWS_ACCOUNT_ID=${AWS_ACCOUNT_ID:-"88888xxxxxxx"}

ASSUME_ROLE="arn:aws:iam::${AWS_ACCOUNT_ID}:role/terraform-provisioner"
ROLE_SESSION_NAME="eu"
TMP_FILE=".temp_credentials"

aws sts assume-role --output json --role-arn ${ASSUME_ROLE} --role-session-name ${ROLE_SESSION_NAME} > ${TMP_FILE}

ACCESS_KEY=$(cat ${TMP_FILE} | jq -r ".Credentials.AccessKeyId")
SECRET_KEY=$(cat ${TMP_FILE} | jq -r ".Credentials.SecretAccessKey")
SESSION_TOKEN=$(cat ${TMP_FILE} | jq -r ".Credentials.SessionToken")
EXPIRATION=$(cat ${TMP_FILE} | jq -r ".Credentials.Expiration")

echo "Retrieved temp access key ${ACCESS_KEY} for role ${ASSUME_ROLE}. Key will expire at ${EXPIRATION}"

AWS_ACCESS_KEY_ID=${ACCESS_KEY} AWS_SECRET_ACCESS_KEY=${SECRET_KEY} AWS_SESSION_TOKEN=${SESSION_TOKEN} ${CMD}
