# Aptly Resource

Uploads Debian packages through an Aptly API and publishes an update.

## Source Configuration

- `api`: *Optional.* The URI of the Aptly API.

## Behavior

### `check`: Does nothing.

### `in`: Does nothing. Should not be used.

### `out`: Upload packages to Aptly and publish an update.

The resulting version is the package version.

#### Parameters

- `package_file`: *Required.* A path to a file to get the source package name from.
- `aptly_repo`: *Required.* The Aptly repository to add packages to.
- `publish_dist`: *Required.* The Debian distribution to publish to.
- `publish_endpoint`: *Optional.* The Aptly endpoint to publish to.
- `publish_prefix`: *Optional.* The Aptly prefix to publish to.

## Example

```yaml
resource_types:
- name: aptly-resource
  type: docker-image
  source:
    repository: opxhub/aptly-resource

resources:
- name: aptly
  type: aptly-resource
  source:
    api: http://aptly:8080/api

jobs:
- name: build-rootfs
  plan:
  - put: aptly
    params:
      package_file: package
      aptly_repo: opx-stable
      publish_dist: stable
      publish_endpoint: filesystem:public:
      publish_prefix: .
```

