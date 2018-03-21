# OpenSwitch Concourse Configuration

We store our general Concourse tasks and custom resources here.

## Resources

- [Aptly](resources/aptly)

## Creating Secrets in Kubernetes

https://github.com/kubernetes/charts/tree/master/stable/concourse#kubernetes-secrets

For staging, use `concourse-stg-main` for the main team, or `concourse-main` for production.

From the link above, adjusted for us.

In production instance, team `opx`, pipeline `opx-core`; the expression `((api-key))` resolves to:

1. the secret value in namespace: `concourse-prod-opx` secret: `opx-core.api-key`, key: `value`
2. and if not found, is the value in namespace: `concourse-prod-opx` secret: `api-key`, key: `value`

In staging instance, team `opx`, pipeline `opx-core`; the expression `((api-key))` resolves to:

1. the secret value in namespace: `concourse-stg-opx` secret: `opx-core.api-key`, key: `value`
2. and if not found, is the value in namespace: `concourse-stg-opx` secret: `api-key`, key: `value`

In staging instance, team `opx`, pipeline `opx-core`; the expression `((common.api-key))` resolves to:

1. the secret value in namespace: `concourse-stg-opx` secret: `opx-core.common`, key: `api-key`
2. and if not found, is the value in namespace: `concourse-stg-opx` secret: `common`, key: `api-key`

Be mindful of your team and pipeline names, to ensure they can be used in namespace and secret names, e.g. no underscores.

To test, create a secret in namespace `concourse-stg-opx`:

```console
kubectl -n concourse-stg-opx create secret generic hello --from-literal 'value=Hello world!'
```

Then `fly set-pipeline` with the following pipeline, and trigger it:

```yaml
jobs:
- name: hello-world
  plan:
  - task: say-hello
    config:
      platform: linux
      image_resource:
        type: docker-image
        source: {repository: alpine}
      params:
        HELLO: ((hello))
      run:
        path: /bin/sh
        args: ["-c", "echo $HELLO"]
```

