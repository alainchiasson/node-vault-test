#!/usr/bin/env bash
#
vault login root

vault read -field=role_id auth/approle/role/node-app-role/role-id > role-id
vault write -field=secret_id -f auth/approle/role/node-app-role/secret-id > secret-id

export ROLE_ID=$(cat role-id)
export SECRET_ID=$(cat secret-id)

node app.js
