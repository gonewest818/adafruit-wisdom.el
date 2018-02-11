export EMACS ?= emacs
export BATCH = --batch -q -l .emacs/init.el

ELS = $(wildcard *.el)
OBJECTS = $(ELS:.el=.elc)

.PHONY: version lint test clean cleanelpa

.elpa:
	$(EMACS) $(BATCH)
	touch .elpa

version: .elpa
	$(EMACS) $(BATCH) --version

lint: .elpa
	$(EMACS) $(BATCH) -f elisp-lint-files-batch $(ELS)

test: .elpa
	$(EMACS) $(BATCH) -f buttercup-run-discover

clean:
	rm -f $(OBJECTS)

cleanelpa: clean
	rm -rf .emacs/elpa .emacs/quelpa .emacs/.emacs-custom.el .elpa
