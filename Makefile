#!/usr/bin/make -f

TARGET := test

include Makefile.defs

DATE := $(shell date -I)
DTARGET := $(TARGET).$(DATE).tsv

all: $(DTARGET)

MWD_DIR := $(TARGET)
MWD_SRC := $(shell find $(MWD_DIR) -name '*.MWD')

$(DTARGET): $(MWD_SRC)
	@./get-mwd-drilling.awk $^ > $@
	@echo "$(DTARGET) done"

clean:
	rm -f  *.tsv

push: $(DTARGET)
	scp $^ $(USER)@$(HOST):$(PUBDIR)

pull:
	@echo "download from ..."
