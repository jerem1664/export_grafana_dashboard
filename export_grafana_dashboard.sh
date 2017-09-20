#!/usr/bin/env bash

# script d'export de tous les dashboard grafana
if [ -z "$1" ]
    then printf "Need args : \n export_grafana_dashboard.sh [Path to grafana keyfile] [Grafana host] [Save directory] \n"
    exit 0
fi
if [ -z "$2" ]
    then printf "Need args : \n export_grafana_dashboard.sh [Path to grafana keyfile] [Grafana host] [Save directory] \n"
    exit 0
fi
if [ -z "$3" ]
    then printf "Need args : \n export_grafana_dashboard.sh [Path to grafana keyfile] [Grafana host] [Save directory] \n"
    exit 0
fi

KEY=`cat $1`
HOST=$2
DIR=$3


if [ ! -d $DIR/ ] ; then
    mkdir -p $DIR/
fi

for dash in $(curl -k -H "Authorization: Bearer $KEY" $HOST/api/search\?query\=\& | jq -r '.[] | .uri'); do
  curl -k -H "Authorization: Bearer $KEY" $HOST/api/dashboards/$dash | sed 's/"id":[0-9]\+,/"id":null,/' | sed 's/\(.*\)}/\1,"overwrite": true}/' > $DIR/$(echo ${dash} |cut -d\" -f 4 |cut -d\/ -f2).json
done
