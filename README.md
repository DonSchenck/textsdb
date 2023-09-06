## Create ephemeral PostgreSQL instance
`oc new-app openshift/postgresql-ephemeral -p DATABASE_SERVICE_NAME=textsdb -e POSTGRESQL_USER=textsdb -e  POSTGRESQL_DATABASE=textsdb -e POSTGRESQL_PASSWORD=textsdb --labels=app.kubernetes.io/part-of=picturethis,systemname=picturethis,tier=database,database=postgresql,picturethis=database`  


## Get pod
### PowerShell
`$a = (kubectl get pods | select-string '^postgres([^\s]+)-(?!deploy)') -match 'postgres([^\s]+)'; $podname = $matches[0]`


## Copy files
### PowerShell
`oc cp ./customers.csv ${podname}:customers.csv`

## Create table
`oc exec ${podname} -- CREATE TABLE customer (id int, customerName varchar);`

## Run import
`oc exec ${podname} -- COPY customer FROM 'customers.csv' WITH (FORMAT csv);`