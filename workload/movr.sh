#!/bin/bash

# assumes cockroach cli client installed
#  drop and recreates movr db

read -sp "Enter password: " PASSWORD

export PGPASSWORD="$PASSWORD"

cockroach sql --url 'postgresql://demo@duane-demo-standard-16600.j77.aws-us-east-1.cockroachlabs.cloud:26257/defaultdb?sslmode=verify-full' <<EOF
drop database movr;
create database movr;
EOF

cockroach workload init movr \
  'postgresql://demo@duane-demo-standard-16600.j77.aws-us-east-1.cockroachlabs.cloud:26257/movr?sslmode=verify-full'

cockroach workload run movr \
  --duration=5m \
  --concurrency=12 \
  --tolerate-errors \
  'postgresql://demo@duane-demo-standard-16600.j77.aws-us-east-1.cockroachlabs.cloud:26257/movr?sslmode=verify-full'
