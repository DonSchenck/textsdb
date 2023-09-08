PODNAME=$(oc get pods -l name=textsdb -o jsonpath='{.items[0].metadata.name}')

echo $PODNAME 

oc cp ./create_table_texts.sql $PODNAME:/tmp/create_table_texts.sql

oc cp ./texts.csv $PODNAME:/tmp/texts.csv

oc exec $PODNAME -- psql -d textsdb -U textsdb --no-password -f "/tmp/create_table_texts.sql"

oc exec $PODNAME -- psql -d textsdb -U textsdb -c "\copy texts FROM '/tmp/texts.csv' delimiter ',' csv"
