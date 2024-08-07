#!/bin/bash

owner=${FORK_OWNER:-kitz0rsoft}

if [ "$1" != "" ]; then
    echo Setting org to "$1"
    owner="$1"
fi

for repo in $(<repos.txt); do
    echo "Creating repo $owner/$repo"
    yes Noooo | gh repo fork "macaroni-os/$repo" "$repo" --org "$owner"
done
