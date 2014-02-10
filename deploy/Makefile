.PHONY: test

# CWD in your make targets is the directory with the Makefile (i.e., here
# it's the `deploy/` directory).

build: TARGET=./targets/build/go
build:
	@echo ">>> Building the app"; \
	if [ -x "${TARGET}" ]; then "${TARGET}"; fi


test: TARGET=./targets/test/go
test: build
	@echo ">>> Running tests"; \
	if [ -x "${TARGET}" ]; then "${TARGET}"; fi


run: TARGET=./targets/run/go
run:
	@echo ">>> Starting the application"; \
	if [ -x "${TARGET}" ]; then "${TARGET}"; fi
