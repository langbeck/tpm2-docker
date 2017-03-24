

TARGETS=inteltss ibmtss ibmacs

.PHONY: all
all: $(TARGETS)

.PHONY: $(TARGETS)
$(TARGETS):
	docker build $@ -t tpm2-$@
