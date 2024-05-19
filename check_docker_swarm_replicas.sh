#!/usr/bin/env bash
# This monitoring script simple checks on any swarn manager node if all configured and active service replicas match. Eg 4/4 OK, 3/4 Warning, 0/4 Critical.

replicas=$(HOME=/tmp docker service ls --format "{{.Name}}: {{.Replicas}}" 2>/dev/null)
if [ -z "${replicas}" ]; then echo -e "Unknow $0 does not work properly" && exit 3; fi # Unknow

replica_status=$(for i in "${replicas[@]}" ; do
  printf -- "$i" | awk  '
    BEGIN { FS="[/[[:space:]]" }
    $2 != $3 { if ($2=="0") { printf $i " Critical\n"} else  { printf $i " Warning\n"} }
    $2 == $3 { printf $i " OK\n" }
    '
done )

replicas_warning=$(grep -c Warning <<< "$replica_status")
replicas_critical=$(grep -c Critical <<< "$replica_status")

if [[ $replicas_warning -eq 0 && $replicas_critical -eq 0 ]]; then
  echo -e "OK $replicas_warning replicas with problems.\n\n$replica_status" && exit 0 # OK
elif [ ! $replicas_critical -eq 0 ]; then
  echo -e "Critical $replicas_critical services with 0 replicas activ and $replicas_warning in warning.\n\n$replica_status" && exit 2 # Critical
else
   echo -e "Warning $replicas_warning replicas with problems.\n\n$replica_status" && exit 1 # Warning
fi
