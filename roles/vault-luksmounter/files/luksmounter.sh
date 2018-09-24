#!/bin/sh

TARGET_DEVICE=$1
LUKS_NAME=$2
MOUNT_POINT=$3

sleep 10

curl -H "X-Vault-Token: $VAULT_TOKEN" \
     -X GET $VAULT_ADDR/v1/secret/home-cloud/luks/password \
  | jq -r .data.value \
  | cryptsetup luksOpen $TARGET_DEVICE $LUKS_NAME

mount /dev/mapper/$LUKS_NAME $MOUNT_POINT
