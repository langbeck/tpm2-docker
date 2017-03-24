
TARGETS:=$(subst /Dockerfile,,$(wildcard */Dockerfile))


.PHONY: all
all: $(TARGETS)


.PHONY: $(TARGETS)
$(TARGETS):
	docker build $@ -t tpm2-$@


.PHONY: test
test: $(TEST_TARGETS)


.PHONY: $(TEST_TARGETS)
$(TARGETS:%=test-%): test-%: %
	docker run --rm -it tpm2-$< --test
