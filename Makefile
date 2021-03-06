export EMACS ?= emacs
export BATCH = --batch -q -l .emacs/init.el

ELS = $(wildcard *.el)
LINT_ELS = $(filter-out adafruit-wisdom.el-autoloads.el,$(ELS))
TESTS = $(wildcard test/*.el)
OBJECTS = $(ELS:.el=.elc)
BACKUPS = $(ELS:.el=.el~)

.PHONY: version lint test clean cleanelpa

.elpa:
	mkdir -p .emacs/elpa/gnupg && \
	chmod 700 .emacs/elpa/gnupg && \
	echo "disable-ipv6" > .emacs/elpa/gnupg/dirmngr.conf && \
	for i in {1..3}; do \
	gpg --keyserver keyserver.ubuntu.com \
	    --homedir .emacs/elpa/gnupg \
	    --recv-keys 066DAFCB81E42C40 \
	    && break || sleep 15; \
	done
	$(EMACS) $(BATCH)
	touch .elpa

version: .elpa
	$(EMACS) $(BATCH) --version

lint: .elpa
	$(EMACS) $(BATCH) -f elisp-lint-files-batch $(LINT_ELS) $(TESTS)

test: .elpa
	$(EMACS) $(BATCH) -f buttercup-run-discover

coverage.json: .elpa $(ELS) $(TESTS)
	UNDERCOVER_FORCE=1 $(EMACS) $(BATCH) -f buttercup-run-discover

submit-coverage: coverage.json
	curl -s https://codecov.io/bash | bash -s - -f coverage.json

clean:
	rm -f $(OBJECTS) $(BACKUPS) adafruit-wisdom.el-autoloads.el *~ coverage.json

cleanall: clean
	rm -rf .emacs/elpa .emacs/.emacs-custom.el* .elpa

