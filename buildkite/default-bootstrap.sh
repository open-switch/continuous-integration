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

cat <<'PRE' | tee -a /etc/buildkite-agent/hooks/pre-exit
echo "--- Upgrading dbp"
sudo /usr/local/bin/pip3 install --upgrade dbp
PRE

# Agent-specific configuration ################################################

cat <<'PRE' | tee -a /etc/buildkite-agent/hooks/pre-exit
echo "--- Pulling opxhub/gbp"
dbp pull
PRE

dbp pull
) 2>&1 | tee /bootstrap.log
