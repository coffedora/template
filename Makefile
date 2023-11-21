default: test_local
act:
	@echo "ACT Smoke Test..."
	act pull_request \
	-s GITHUB_TOKEN="$(gh auth token)" \
	-W .github/workflows/test-pr.yaml
smoke:
	@echo "Local Smoketest..."
	.github/actions/smoke-test/build.sh init
	.github/actions/smoke-test/test.sh init