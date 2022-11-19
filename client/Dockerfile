FROM fedora

WORKDIR /workdir

RUN dnf install -y dnf-plugins-core
RUN dnf config-manager --add-repo https://rpm.releases.hashicorp.com/fedora/hashicorp.repo

RUN dnf -y install vault jq nodejs which unzip jq
RUN setcap cap_ipc_lock= /usr/bin/vault

# Copy shell scripts to setup.
COPY scripts/* /usr/local/sbin
COPY vault-test/* /workdir/

# Resolve packages
RUN npm install

# Set command line to wait for login.
CMD exec /bin/bash -c "trap : TERM INT; sleep infinity & wait"
