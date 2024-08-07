#!/bin/bash

owner=${FORK_OWNER:-kitz0rsoft}
upstream_owner="macaroni-os"

if [ "$1" != "" ]; then
    echo Setting org to "$1"
    owner="$1"
fi

exit

for repo in $(<repos.txt); do
    echo "Creating repo $owner/$repo"
    yes Noooo | gh repo fork "$upstream_owner/$repo" "$repo" --org "$owner"
done
