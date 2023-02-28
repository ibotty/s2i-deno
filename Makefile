FROM=registry.access.redhat.com/ubi9-minimal
IMAGE_NAME=quay.io/ibotty/s2i-deno

# These values are changed in each version branch
# This is the only place they need to be changed
# other than the README.md file.
include versions.mk

TARGET=$(IMAGE_NAME):$(DENO_VERSION)

.PHONY: all
all: build test

build: Containerfile s2i
	podman build -f Containerfile \
	--build-arg DENO_VERSION=v$(DENO_VERSION) \
	-t $(TARGET) .

.PHONY: test
test:
	 #BUILDER=$(TARGET) DENO_VERSION=$(DENO_VERSION) ./test/run.sh

.PHONY: clean
clean:
	podman rmi `podman images $(TARGET) -q`

.PHONY: tag
tag:
	if [ ! -z $(LTS_TAG) ]; then docker tag $(TARGET) $(IMAGE_NAME):$(LTS_TAG); fi
	podman tag $(TARGET) $(IMAGE_NAME):$(DENO_VERSION)

.PHONY: publish
publish: all
	# assume a robot account exists and is configured
	#echo $(DOCKER_PASS) | docker login -u $(DOCKER_USER) --password-stdin
	podman push $(TARGET)
	podman push $(IMAGE_NAME):$(DENO_VERSION)
	if [ ! -z $(LTS_TAG) ]; then podman push $(IMAGE_NAME):$(LTS_TAG); fi
