#!/bin/bash

# sensitive credentials
if [[ -z "$FORK_LIBRARY_USER" ]] || [[ -z "$FORK_LIBRARY_TOKEN" ]]; then
	echo "Please define FORK_USER and FORK_TOKEN in your environment."
	exit 66
fi

user=$FORK_LIBRARY_USER
cred=$FORK_LIBRARY_TOKEN
upstream_owner=${FORK_LIBRARY_OWNER_UPSTREAM:-mirror-core}
upstream_remote=${FORK_REMOTE_NAME_UPSTREAM:-upstream}
fork=${FORK_OWNER_DOWNSTREAM:-kitz0rsoft}
library=${FORK_LIBRARY:-library.edoras.riddermark}
merge_dir=${FORK_MERGE_DIR:-$HOME/merging/${fork}}

declare -A releases
releases['next']='master'
releases['mark-testing']='mark-testing'
releases['mark-unstable']='mark-unstable'
releases['mark-xl']='mark-xl'
releases['mark-iii']='mark-iii'

repo="kit-fixups"

# initial setup
if [[ ! -d "$merge_dir" ]]; then
	git clone \
		"https://$user:$cred@$library/$fork/$repo" "$merge_dir" || exit
	cd "$merge_dir" || exit
	git remote rename origin "$fork" || exit

	# get list of branches and other metadata for fork remote
	git fetch "$fork" || exit

	# check out branches for active releases
	for branch in "${releases[@]}"; do
		[ "$branch" == "mark-testing" ] && continue
		git checkout -b "$branch" --track "$fork/$branch" || exit
	done

	# intentionally neglect credentials, to avoid unwanted pushes upstream
	git remote add "$upstream_remote" \
		"https://$library/$upstream_owner/$repo" || exit

	# get list of branches and other metadata for upstream remote
	git fetch "$upstream_remote" || exit

	# don't rebase, to keep merge commits in the tree
	git config pull.rebase false || exit
fi

# do the merge
cd "${merge_dir}" || exit
git pull || exit
for branch in "${releases[@]}"; do
	git checkout $branch || exit
	git fetch "$upstream_remote" || exit
	git merge --no-edit "$upstream_remote/$branch" || exit
	git push "$fork" || exit
done
