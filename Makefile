# Minimal makefile for Sphinx documentation
#

# You can set these variables from the command line, and also
# from the environment for the first two.
SPHINXOPTS    ?=
SPHINXBUILD   ?= env/bin/sphinx-build
SOURCEDIR     = vadovas
BUILDDIR      = build

export PATH := env/bin:$(PATH)

.PHONY: env
env: env/done requirements.txt


.PHONY: upgrade
upgrade: env/bin/pip-compile
	env/bin/pip-compile --upgrade requirements.in -o requirements.txt


env/done: env/bin/pip requirements.txt
	env/bin/pip install -r requirements.txt
	touch env/done

env/bin/pip:
	python -m venv env
	env/bin/pip install --upgrade pip wheel setuptools

requirements.txt: env/bin/pip-compile requirements.in
	env/bin/pip-compile requirements.in -o requirements.txt

env/bin/pip-compile: env/bin/pip
	env/bin/pip install pip-tools

requirements.in:
	true


# Put it first so that "make" without argument is like "make help".
help:
	@$(SPHINXBUILD) -M help "$(SOURCEDIR)" "$(BUILDDIR)" $(SPHINXOPTS) $(O)

auto:
	env/bin/sphinx-autobuild -b html $(SOURCEDIR) $(BUILDDIR)/html $(SPHINXOPTS)

open:
	xdg-open http://127.0.0.1:8000

.PHONY: help Makefile

# Catch-all target: route all unknown targets to Sphinx using the new
# "make mode" option.  $(O) is meant as a shortcut for $(SPHINXOPTS).
%: Makefile
	@echo $@
	@echo $(SPHINXBUILD) -M $@ "$(SOURCEDIR)" "$(BUILDDIR)" $(SPHINXOPTS) $(O)
	@$(SPHINXBUILD) -M $@ "$(SOURCEDIR)" "$(BUILDDIR)" $(SPHINXOPTS) $(O)
