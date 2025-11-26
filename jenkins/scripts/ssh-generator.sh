#!/bin/bash

# === Variables ===
KEY_TYPE="rsa"          # Options: dsa, ecdsa, ecdsa-sk, ed25519, ed25519-sk, rsa
KEY_BITS="2048"         # Only used for RSA/ECDSA (ignored for ed25519)
KEY_NAME="remote-key"   # Output key file name
KEY_PASSPHRASE=""       # Leave empty for no passphrase

# === Generate SSH keys ===
ssh-keygen \
    -t "$KEY_TYPE" \
    -b "$KEY_BITS" \
    -f "$PWD/$KEY_NAME" \
    -N "$KEY_PASSPHRASE"

echo "SSH keys generated:"
echo " - Private key: $PWD/$KEY_NAME"
echo " - Public key:  $PWD/${KEY_NAME}.pub"
