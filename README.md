# Vault Node Approle quick test.

The goal is to have a quick vault environment for building and testing vault integration and code breakout. This work is based on : https://codersociety.com/blog/articles/hashicorp-vault-node

# Startup 

To start, launch docker compose. 

    docker compose up -d --build

Our docker composes uses Hashicorp's vault container. It is started up with the root key as "root" to simplify the initial setup. The root token is used to setup everything, but this should ideally be a admin type account with only enough policies to do what is necessary.

# Initial provisioning 

The shell container has the initial provisioing script. : 

    docker compose exec shell /bin/bash -c setup_node_app.sh

This will create a secret to be read, a policy to read the secret and an approle that will have the policy. 

# Launching the client

The client is a simple login-read-print written in nodejs. To run it simply:

    docker compose exec client /bin/bash -c get_role_creds.sh 

This will authenticate with vault (as root), generate the roleId and secretId, assign them to environment variables and launch the node script app.js. The app.js will use the roleid and secretid to authemnticate with Vault, fetch the secret and print it out.

# Doing things by hand

The images are built using fedora as a base - so you should be able to use DNF to install a wide variety of packages. To "connct" intop an image : 

    docker compose exec shell /bin/bash
    docker compose exec client /bin/bash
    docker compose exec vault /bin/sh

It should drop you into /workdir except for the vault image - this is using the alpine mage from Hashicorp.

