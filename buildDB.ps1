
$a = (kubectl get pods | select-string '^texts([^\s]+)-(?!deploy)') -match 'texts([^\s]+)'; $podname = $matches[0]
oc cp ./texts.csv ${podname}:/tmp/texts.csv
oc exec ${podname} -- "psql CREATE TABLE IF NOT EXISTS texts (id int, pictureText varchar);"
oc exec ${podname} -- COPY texts FROM '/tmp/texts.csv' WITH (FORMAT csv);