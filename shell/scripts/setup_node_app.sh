#!/usr/bin/env bash
#

# Using a preset Vault Root Token 
vault login root

# Enaable Approles
vault auth enable approle

# Populate secrets (this should be another "entity")
vault kv put secret/mysql/webapp db_name="users" username="admin" password="passw0rd"

# Creat a policy to ONLY read it.
vault policy write readonly-kv-backend - <<EOF
path "secret/data/mysql/webapp" {
  capabilities = [ "read" ]
}
EOF

# Create thte node AppRole
vault write auth/approle/role/node-app-role \
    token_ttl=1h \
    token_max_ttl=4h \
    token_policies=readonly-kv-backend
