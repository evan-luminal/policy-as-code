LWCFLAGS = --warnings --werror

default: check

LUDWIG = $(shell find . -name deps -prune -o -name '*.lw' -print)

ludwig: $(LUDWIG)

$(LUDWIG):
	lwc $(LWCFLAGS) $@ > /dev/null

check: ludwig

.PHONY: $(LUDWIG) ludwig check
