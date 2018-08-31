(
# Common configuration ########################################################

yum -y install python36
easy_install-3.6 pip
/usr/local/bin/pip3 install --upgrade pip
/usr/local/bin/pip3 install black dbp pipenv

echo "buildkite-agent ALL=(ALL) NOPASSWD:ALL" | tee -a /etc/sudoers

cat <<'ENV' | tee -a /etc/buildkite-agent/hooks/environment
export BUILDKITE_CLEAN_CHECKOUT=true
ENV

cat <<'PRE' | tee -a /etc/buildkite-agent/hooks/pre-command
# For Python3
export PATH=/usr/local/bin:$PATH
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export PIPENV_VENV_IN_PROJECT=yes
PRE

cat <<'PRE' | tee -a /etc/buildkite-agent/hooks/pre-checkout
if [[ -d /var/lib/buildkite-agent/.gitconfig ]]; then
  sudo rm -rf /var/lib/buildkite-agent/.gitconfig
fi
PRE

# Agent-specific configuration ################################################

cat <<'PRE' | tee -a /etc/buildkite-agent/hooks/pre-command
echo "$APTLY_KEY" | gpg --import || true
echo "$APTLY_KEY" | gpg --no-default-keyring --keyring trustedkeys.gpg --import || true
aws s3 sync --delete s3://aptly.openswitch.net/ /aptly
PRE

cat <<'POST' | tee -a /etc/buildkite-agent/hooks/post-command
aptly db cleanup
aws s3 sync --delete /aptly s3://aptly.openswitch.net/
POST

yum -y install graphviz gnupg

# Set up Aptly
APTLY_DIR=aptly_1.3.0_linux_amd64
curl -sL "https://bintray.com/artifact/download/smira/aptly/$APTLY_DIR.tar.gz" | tar xz
mv "$APTLY_DIR/aptly" /usr/local/bin/aptly && rm -rf "$APTLY_DIR/"
cat <<APTLY | tee /etc/aptly.conf
{
  "rootDir": "/aptly",
  "S3PublishEndpoints":{
    "opx":{
      "region":"us-west-2",
      "bucket":"deb.openswitch.net",
      "acl":"public-read"
    }
  }
}
APTLY
mkdir /aptly
chown buildkite-agent: /aptly
) 2>&1 | tee /bootstrap.log
