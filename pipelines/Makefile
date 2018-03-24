team ?= stg

# from opx-build/scripts/opx_build
debian_repos = \
  opx-core \
  opx-logging \
  opx-common-utils \
  opx-cps \
  opx-base-model \
  opx-db-sql \
  opx-sai-api \
  opx-sai-vm \
  opx-nas-common \
  opx-nas-linux \
  opx-nas-ndi-api \
  opx-nas-ndi \
  opx-nas-acl \
  opx-nas-interface \
  opx-nas-l2 \
  opx-nas-l3 \
  opx-nas-qos \
  opx-nas-daemon \
  opx-platform-config \
  opx-sdi-sys \
  opx-pas \
  opx-tmpctl \
  opx-tools \
  opx-alarm \
  opx-snmp \
  opx-onie-installer

opx-build:
	fly -t $(team) set-pipeline -c opx/$@.yaml -p $@ -v repo=$@ -n
	@fly -t $(team) unpause-pipeline -p $@
	@fly -t $(team) expose-pipeline -p $@

opx-core:
	fly -t $(team) set-pipeline -c opx/$@.yaml -p $@ -v repo=$@ -n
	@# fly -t $(team) unpause-pipeline -p $@
	@fly -t $(team) expose-pipeline -p $@

opx-onie-installer:
	fly -t $(team) set-pipeline -c opx/$@.yaml -p $@ -v repo=$@ -n
	@# fly -t $(team) unpause-pipeline -p $@
	@fly -t $(team) expose-pipeline -p $@

opx-sai-api:
	fly -t $(team) set-pipeline -c opx/$@.yaml -p $@ -v repo=$@ -n
	@# fly -t $(team) unpause-pipeline -p $@
	@fly -t $(team) expose-pipeline -p $@

all: $(debian_repos)

.DEFAULT:
	fly -t $(team) set-pipeline -c opx/debian-package.yaml -p $@ -v repo=$@ -n
	@# fly -t $(team) unpause-pipeline -p $@
	@fly -t $(team) expose-pipeline -p $@


