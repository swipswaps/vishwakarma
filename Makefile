TF_DOCS := $(shell which terraform-docs 2> /dev/null)
TF_FILES = $(shell find . -type f -name "*.tf" -not -path "*/.terraform/*" -exec dirname {} \;|sort -u)
TF_EXAMPLES = $(shell find ./examples -type f -name "*.tf" -not -path "*/.terraform/*" -exec dirname {} \; |sort -u)

SEMTAG=tools/semtag
TAG_QUERY=v1.0.0..

scope ?= "minor"

export GO111MODULE := on

define terraform-docs
	$(if $(TF_DOCS),,$(error "terraform-docs revision >= a8b59f8 is required (https://github.com/segmentio/terraform-docs)"))

	@echo '<!-- DO NOT EDIT. THIS FILE IS GENERATED BY THE MAKEFILE. -->' > $1
	@echo '# Terraform variable inputs and outputs' >> $1
	@echo $2 >> $1
	terraform-docs markdown --no-required --no-providers --no-requirements $3 $4 $5 $6 >> $1
endef

default: validate

.PHONY: validate
validate:
	@for m in $(TF_EXAMPLES); do terraform init "$$m" > /dev/null 2>&1; echo "$$m: "; terraform validate "$$m"; done

.PHONY: fmt
fmt:
	@for m in $(TF_FILES); do (terraform fmt -diff "$$m" && echo "√ $$m"); done

.PHONY: test-kubernetes-cluster
test-kubernetes-cluster:
	(cd test && go test -timeout 60m -v -run TestKubernetesCluster)

.PHONY: changelog
changelog:
	git-chglog -o CHANGELOG.md $(TAG_QUERY)

.PHONY: release
release:
	$(SEMTAG) final -s $(scope)

.PHONY: docs
docs:
	$(call terraform-docs, docs/variables/aws/elastikube.md, \
		'This document gives an overview of variables used in the AWS platform of the elastikube module.', \
		modules/aws/elastikube)

	$(call terraform-docs, docs/variables/aws/kube-worker.md, \
		'This document gives an overview of variables used in the AWS platform of the kube-worker module.', \
		modules/aws/kube-worker)

	$(call terraform-docs, docs/variables/aws/network.md, \
		'This document gives an overview of variables used in the AWS platform of the network module.', \
		modules/aws/network)