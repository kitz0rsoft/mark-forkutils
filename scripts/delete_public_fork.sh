#!/bin/bash

downstream_owner=${FORK_OWNER_DOWNSTREAM:-kitz0rsoft}

if [[ $# == 1 ]] &&  [[ "$1" != "" ]]; then
    echo Setting org to "$1"
    downstream_owner="$1"
fi

for repo in $(<repos.txt); do
    echo "Lighting repo $downstream_owner/$repo on fire!"
    gh repo delete --yes "$downstream_owner/$repo"
done
