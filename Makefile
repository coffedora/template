default: test_local
act:
	@echo "ACT Smoke Test..."
	act pull_request \
	-s GITHUB_TOKEN="$(gh auth token)" \
	-W .github/workflows/test-pr.yaml
smoke:
	rm -rdf /tmp/init
	rm -rdf /tmp/template
	@docker rmi $(docker images -q --filter=reference="vsc-template*" --format "{{.ID}}") -f  &&\
	rm -rdf /tmp/init &&\
	rm -rdf /tmp/template || true
	docker volume prune -f
	@echo "Local Smoketest..."
	.github/actions/smoke-test/build.sh template
	.github/actions/smoke-test/test.sh template