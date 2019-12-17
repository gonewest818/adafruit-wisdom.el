export EMACS ?= emacs
export BATCH = --batch -q -l .emacs/init.el

ELS = $(wildcard *.el)
LINT_ELS = $(filter-out adafruit-wisdom.el-autoloads.el,$(ELS))
TESTS = $(wildcard test/*.el)
OBJECTS = $(ELS:.el=.elc)
BACKUPS = $(ELS:.el=.el~)

.PHONY: version lint test clean cleanelpa

.elpa:
	$(EMACS) $(BATCH)
	touch .elpa

version: .elpa
	$(EMACS) $(BATCH) --version

lint: .elpa
	$(EMACS) $(BATCH) -f elisp-lint-files-batch $(LINT_ELS)
	$(EMACS) $(BATCH) -L test/ -f elisp-lint-files-batch \
	                  --no-byte-compile \
	                  --no-package-format \
	                  --no-check-declare \
	                  --no-checkdoc $(TESTS)

test: .elpa
	$(EMACS) $(BATCH) -f buttercup-run-discover

coverage.json: .elpa $(ELS) $(TESTS)
	UNDERCOVER_FORCE=1 $(EMACS) $(BATCH) -f buttercup-run-discover

submit-coverage: coverage.json
	curl -s https://codecov.io/bash | bash -s - -f coverage.json

clean:
	rm -f $(OBJECTS) $(BACKUPS) coverage.json

cleanall: clean
	rm -rf .emacs/elpa .emacs/.emacs-custom.el* .elpa

