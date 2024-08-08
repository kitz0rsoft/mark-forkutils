#!/bin/bash

downstream_owner=${FORK_OWNER:-kitz0rsoft}
branch="${FORK_BRANCH:-next}"

if [[ $# == 1 ]] &&  [[ "$1" != "" ]]; then
    echo Setting downstream owner to "$1"
    downstream_owner="$1"
fi

for repo in $(<repos.txt); do
    echo "Setting default branch for $repo to $branch..."
    gh repo edit "$downstream_owner/$repo" --default-branch "$branch"
done
