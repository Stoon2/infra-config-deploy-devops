RDS_HOSTNAME=$(terraform -chdir=/terraform/ output --raw rds_hostname)
RDS_PORT=$(terraform -chdir=/terraform/ output --raw rds_port)

REDIS_HOSTNAME=$(terraform -chdir=/terraform/ output redis_hostname)
REDIS_PORT=$(terraform -chdir=/terraform/ output redis_port)