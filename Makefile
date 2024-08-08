include environment

all: fork update

environment: environment.in
	@printf "\033[32mContents of environment.in:\033[0m\n"
	@echo
	@sed -e 's/^/    /g' ./environment.in
	@echo
	@printf "\033[32mPlease copy environment.in to environment and fill in the\n"
	@printf "appropriate values for your site.\033[0m\n\n"
	@echo
	if [[ -f ./environment ]]; then
		@printf "\033[32mYour environment file is out of date with upstream.\033[0m"
	fi
	@false

fork: environment
	scripts/create_public_fork.sh
	scripts/set_default_branch.sh
	scripts/set_special_default_branches.sh

clean: environment
	@echo "Removing fork at ${FORK_OWNER_DOWNSTREAM} momentarily;" \
		"pausing for reconsideration..."
	sleep 5
	@printf "Okay done sleeping! \033[31mTearing down the walls and roof...\033[0m"
	scripts/delete_public_fork.sh

update: ./environment
	scripts/update_fork.sh
