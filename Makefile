GITHUB_TOKEN=$(shell gh auth token)

run_act:
	act -s GITHUB_TOKEN=$(GITHUB_TOKEN) -e ./events.json pull_request --container-architecture linux/amd64