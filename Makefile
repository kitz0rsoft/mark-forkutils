environment: environment.in
	@printf "\033[32mContents of environment.in:\033[0m\n"
	@echo
	@sed -e 's/^/    /g' ./environment.in
	@echo
	@printf "\033[32mPlease copy environment.in to environment and fill in the\n"
	@printf "appropriate values for your site.\033[0m\n\n"
	@false

fork: environment
	source ./environment && scripts/create_public_fork.sh
	source ./environment && scripts/set_default_branch.sh
	source ./environment && scripts/set_special_default_branches.sh

clean: environment
	@echo "Removing fork $* momentarily; pausing for reconsideration..."
	sleep 5
	@echo "Okay done sleeping!  Tearing down the walls and roof..."
	source ./environment && scripts/delete_public_fork.sh $*

update: ./environment
	source ./environment && scripts/update_fork.sh
