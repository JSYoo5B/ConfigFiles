#!/bin/sh

# Fetch all remotes
git fetch --all

# Get every branch and its upstream remote branch
git for-each-ref --format="%(refname:short) %(upstream:short)" refs/heads | \
while read local remote
do
	# Skip the branch which doesn't have remotes
	[ -z "$remote" ] && continue

	# Get ahead and behind commit counts
	git rev-list --left-right ${local}...${remote} -- 2>/dev/null >/tmp/git_upstream_status_delta || continue
	LEFT_AHEAD=$(grep -c '^<' /tmp/git_upstream_status_delta)
	RIGHT_AHEAD=$(grep -c '^>' /tmp/git_upstream_status_delta)

	# Skip if branch has no difference between local and remote
	[ "$RIGHT_AHEAD" -eq "0" ] && continue

	# Reset difference local branches into recent remote branch
	git checkout $local
	git reset --hard $remote
done
