#!/bin/bash

downstream_owner="${FORK_OWNER_DOWNSTREAM:-kitz0rsoft}"

if [[ $# == 1 ]] &&  [[ "$1" != "" ]]; then
    echo Setting downstream owner to "$1"
    downstream_owner="$1"
fi

declare -A repos
repos[mate-kit]='next/1.26-prime'
repos[kde-kit]='next/5.27-release'
repos[gnome-kit]='next-3.36-prime'
repos[qt-kit]='next-5.15.2-release'
repos[xfce-kit]='next-4.16-release'

for repo in "${!repos[@]}"; do
    branch="${repos[$repo]}"
    echo Setting default branch of $repo to $branch...
    gh repo edit "$downstream_owner/$repo" --default-branch "$branch"
done

