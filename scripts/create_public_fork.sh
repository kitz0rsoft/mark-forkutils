#!/bin/bash

downstream_owner=${FORK_OWNER_DOWNSTREAM:-kitz0rsoft}
upstream_owner="${FORK_GITHUB_OWNER_UPSTREAM:-macaroni-os}"

if [ "$1" != "" ]; then
    echo Setting org to "$1"
    downstream_owner="$1"
fi

for repo in $(<repos.txt); do
    echo "Creating repo $downstream_owner/$repo"
    yes Noooo | gh repo fork "$upstream_owner/$repo" "$repo" --org "$downstream_owner"
done
