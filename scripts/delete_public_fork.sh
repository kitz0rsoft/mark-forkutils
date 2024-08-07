#!/bin/bash

owner=${FORK_OWNER:-kitz0rsoft}

if [[ $# == 1 ]] &&  [[ "$1" != "" ]]; then
    echo Setting org to "$1"
    owner="$1"
fi

for repo in $(<repos.txt); do
    echo "Lighting repo $owner/$repo on fire!"
    gh repo delete --yes "$owner/$repo"
done
