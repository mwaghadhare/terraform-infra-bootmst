{
    "assets_path": "s3://my-${env}-assets/services/my-ap",
    "params_role_arn": "${key_access_role}",
    "deployment_path": "s3://my-tools/deployments/praxis_deploy_${env}_versions",
    "ssl": {
        "cert_path": "s3://my-${env}-info/keys/client-terminator/client-terminator-${env}-cert.pem",
        "encrypted_key_path": "s3://my-${env}-info/keys/client-terminator/client-terminator-${env}-key.pem"
    },
    "environment": "${env}",
    "region": "${region}"

}
