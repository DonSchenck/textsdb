(kubectl get pods | select-string '^textsdb([^\s]+)-(?!deploy)') -match 'textsdb([^\s]+)'; $podname = $matches[0]

Write-Host $podname

oc cp .\create_table_texts.sql ${podname}:/tmp/create_table_texts.sql

oc cp .\texts.csv ${podname}:/tmp/texts.csv

oc exec ${podname} -- psql -d textsdb -U textsdb --no-password -f "/tmp/create_table_texts.sql"

oc exec ${podname} -- psql -d textsdb -U textsdb -c "\copy texts FROM '/tmp/texts.csv' delimiter ',' csv"
