#!/usr/bin/env bash

shellcheck --shell=bash --external-sources \
	bin/* --source-path=template/lib/ \
	lib/* \
	scripts/*

shfmt --language-dialect bash --diff \
	./**/*

markdownlint-cli2 "**/*.md"

yamllint .
