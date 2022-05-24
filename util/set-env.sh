export RDS_HOSTNAME=$(terraform -chdir=/terraform/ output --raw rds_hostname)
export RDS_PORT=$(terraform -chdir=/terraform/ output --raw rds_port)
export REDIS_HOSTNAME=$(terraform -chdir=/terraform/ output redis_hostname)
export REDIS_PORT=$(terraform -chdir=/terraform/ output redis_port)