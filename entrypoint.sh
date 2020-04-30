#!/bin/bash
set -e

USER=$1
TOKEN=$2
SHA=$3
REPO=$4
DUMP=$5

echo "USER: $USER"
echo "TOKEN: $TOKEN"
echo "SHA: $SHA"
echo "REPO: $REPO"
echo "DUMP: $DUMP"

HEADERS=( 'Accept:application/vnd.github.groot-preview+json' )
command="curl"

for header in $HEADERS; do
  command+=" -H '$header'"
done

auth=" -u "${USER}:${TOKEN}
echo ${auth}
command+=${auth}

protocol="https://"
api="api.github.com"

command+=" "${protocol}${api}"/repos/"${REPO}"/commits/"${SHA}"/pulls"

echo Running: ${command}
eval ${command} > output.json
output=$(cat output.json)

if [[ $DUMP == "true" ]] ; then
  echo "::set-output name=dump::${output}"
fi
jq -r '.[] | .merge_commit_sha' output.json
if [[ "$(jq -r '.[] | .merge_commit_sha' output.json)" == "${SHA}"* ]]; then
  isMerged=true
else
  isMerged=false
fi
echo "::set-output name=isMerged::${isMerged}"

