
TARGETS:=$(subst /Dockerfile,,$(wildcard */Dockerfile))

DOCKER_BUILD:=docker build
DOCKER_BUILD+=--build-arg https_proxy=${https_proxy}
DOCKER_BUILD+=--build-arg http_proxy=${http_proxy}

.PHONY: all
all: $(TARGETS)


.PHONY: $(TARGETS)
$(TARGETS):
	$(DOCKER_BUILD) $@ -t tpm2:$@


.PHONY: test
test: $(TEST_TARGETS)


.PHONY: $(TEST_TARGETS)
$(TARGETS:%=test-%): test-%: %
	docker run --rm -it tpm2-$< --test
