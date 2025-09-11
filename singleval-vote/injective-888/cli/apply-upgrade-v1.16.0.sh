#!/bin/bash

set -e

ECHO_ONLY=
TX_OPTS="--keyring-backend=test --from=account0 --chain-id=injective-888 --gas-prices 500000000inj --gas=auto --gas-adjustment=1.5 --broadcast-mode=sync --yes"

# calculate halt height
CUR_HEIGHT=$(curl -sS http://localhost:26657/block | jq .result.block.header.height | tr -d '"')
HALT_HEIGHT=$(($CUR_HEIGHT + 60))

fetch_proposal_id() {
    current_proposal_id=$(curl 'http://localhost:10337/cosmos/gov/v1beta1/proposals?proposal_status=0&pagination.limit=1&pagination.reverse=true' | jq -r '.proposals[].proposal_id')
    proposal=$((current_proposal_id))
}

post_proposal() {
    $ECHO_ONLY $(dirname $0)/injectived-cli-v1.15.0.sh tx upgrade software-upgrade v1.16.0-beta.2 \
    --title "UPGRADE_TESTNET_v1.16.0-beta.2" \
    --upgrade-height $HALT_HEIGHT \
    --summary "UPGRADE_TESTNET_v1.16.0-beta.2" \
    --deposit 500000000000000000000inj $TX_OPTS \
    --node "tcp://host.docker.internal:26657" \
    --no-validate
}

vote() {
    PROPOSAL_ID=$1
    echo $PROPOSAL_ID
    $ECHO_ONLY $(dirname $0)/injectived-cli-v1.15.0.sh tx \
        --node "tcp://host.docker.internal:26657" \
        gov vote $PROPOSAL_ID yes $TX_OPTS
}

echo "Posting proposal"

post_proposal

sleep 3

echo "Fetching proposal id"

fetch_proposal_id

echo "Voting for proposal"

vote $proposal

echo "Upgrade will apply at height $HALT_HEIGHT"
