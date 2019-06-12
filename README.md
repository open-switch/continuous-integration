# OpenSwitch Continuous Integration

## Reading Buildkite logs

Buildkite is [working on enabling public access](https://github.com/buildkite/feedback/issues/137#issuecomment-360336774). Until then, you'll need to be a member of our [organization](https://buildkite.com/opx) to read them.

## The Buildkite script

Create, read, update, and delete Buildkite pipelines.

Required
- Buildkite API token
- GitHub API token

```bash
./bin/buildkite create all
./bin/buildkite read all
./bin/buildkite update all
./bin/buildkite delete all
```

## Repositories without pipelines

* [`opx-docs`](https://github.com/opx-docs)
* [`opx-manifest`](https://github.com/opx-manifest)
* [`opx-northbound`](https://github.com/opx-northbound)
* [`opx-test`](https://github.com/opx-test)

## Changing an agent's environment

Agent environments are bootstrapped from a script. Visit the parameters of any stack to find out what it is. Updating the script URL will recreate the auto-scaling group.

## Adding secrets

Secrets are pulled in from the `/env` file in the managed secrets S3 bucket. Each stack has its own bucket. Download the file, edit it, and upload it back to commit changes. No further action is necessary.

## privup script is used to upload packages to s3 bucket deb.openswitch.net

This script contacts AWS s3 buckets to upload packages. It also contacts the Secrets Manager for API access tokens.
