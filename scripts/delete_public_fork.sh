#!/bin/bash

downstream_owner=${FORK_OWNER_DOWNSTREAM:-kitz0rsoft}

if [[ $# == 1 ]] &&  [[ "$1" != "" ]]; then
    echo Setting org to "$1"
    downstream_owner="$1"
fi

for repo in $(<repos.txt); do
    printf "\033[31mLighting repo\033[0m \033[33m%s\033[0m \033[31mon fire!\033[0m\n" "$downstream_owner/$repo"
    gh repo delete --yes "$downstream_owner/$repo"
done
