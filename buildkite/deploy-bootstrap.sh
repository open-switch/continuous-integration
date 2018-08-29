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

# Agent-specific configuration ################################################

yum -y install python27
easy_install-2.7 pip
/usr/local/bin/pip2 install --upgrade pip
/usr/local/bin/pip2 install ansible

TF_ZIP=terraform_0.11.7_linux_amd64.zip
wget "https://releases.hashicorp.com/terraform/0.11.7/$TF_ZIP"
unzip "$TF_ZIP" -d /usr/local/bin && rm -f "$TF_ZIP"
) 2>&1 | tee /bootstrap.log
