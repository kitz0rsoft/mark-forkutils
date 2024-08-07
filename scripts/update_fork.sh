#!/bin/bash

# sensitive credentials
if [[ -z "$FORK_LIBRARY_USER" ]] || [[ -z "$FORK_LIBRARY_TOKEN" ]]; then
	echo "Please define FORK_USER and FORK_TOKEN in your environment."
	exit 66
fi

user="$FORK_LIBRARY_USER"
cred="$FORK_LIBRARY_TOKEN"
upstream="${FORK_UPSTREAM:-mirror-core}"
fork="${FORK_OWNER:-kitz0rsoft}"
library="${FORK_LIBRARY:-library.edoras.riddermark}"
merge_dir="${FORK_MERGE_DIR:-$HOME/merging/${fork}}"

# initial setup
if [[ ! -d "$merge_dir" ]]; then
	git clone \
		"https://$user:$cred@$library/$fork/kit-fixups" \
		"$merge_dir" || exit
	cd "$merge_dir" || exit
	git remote rename origin "$fork" || exit
	# intentionally neglect credentials, to avoid unwanted pushes upstream
	git remote add "$upstream" "https://$library/$upstream/kit-fixups" || exit
	git config pull.rebase false || exit
fi

# do the merge
cd "${merge_dir}" || exit
git pull
git fetch "$upstream"
git merge --no-edit "$upstream/master"
git push "$fork"
