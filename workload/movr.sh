# assumes cockroach client installed

cockroach workload init movr \
  'postgresql://<user>:<password>@<host>:26257/<db>?sslmode=require'

cockroach workload run movr \
  --duration=5m \
  --concurrency=64 \
  --tolerate-errors \
  'postgresql://<user>:<password>@<host>:26257/<db>?sslmode=require'
