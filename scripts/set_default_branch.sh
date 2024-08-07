#!/bin/bash

owner=${FORK_OWNER:-kitz0rsoft}
branch="${FORK_BRANCH:-next}"

if [[ $# == 1 ]] &&  [[ "$1" != "" ]]; then
    echo Setting owner to "$1"
    owner="$1"
fi

for repo in $(<repos.txt); do
    echo "Setting default branch for $repo to $branch..."
    gh repo edit "$owner/$repo" --default-branch "$branch"
done
