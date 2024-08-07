%:
	FORK_OWNER=poo scripts/create_public_fork.sh $*
	scripts/set_default_branches.sh $*
	scripts/set_special_default_branches.sh $*


%-clean:
	@echo "Removing fork $* momentarily; pausing for reconsideration..."
	sleep 5
	@echo "Okay done sleeping!  Tearing down the walls and roof..."
	scripts/delete_public_fork.sh $*
