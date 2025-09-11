#!/bin/bash

set -e

ECHO_ONLY=
TX_OPTS="--keyring-backend=test --from=account0 --chain-id=injective-888 --gas-prices 500000000inj --gas=auto --gas-adjustment=1.5 --broadcast-mode=sync --yes"

fetch_proposal_id() {
    current_proposal_id=$(curl 'http://localhost:10337/cosmos/gov/v1beta1/proposals?proposal_status=0&pagination.limit=1&pagination.reverse=true' | jq -r '.proposals[].proposal_id')
    proposal=$((current_proposal_id))
}

post_proposal() {
    $ECHO_ONLY $(dirname $0)/injectived-cli-local.sh tx gov submit-proposal \
    proposals/evm_proposal.json \
    $TX_OPTS \
    --node "tcp://localhost:26657"
}

vote() {
    PROPOSAL_ID=$1
    echo $PROPOSAL_ID
    $ECHO_ONLY $(dirname $0)/injectived-cli-local.sh tx \
        --node "tcp://localhost:26657" \
        gov vote $PROPOSAL_ID yes $TX_OPTS
}

echo "Posting proposal"

post_proposal

sleep 3

echo "Fetching proposal id"

fetch_proposal_id

echo "Voting for proposal"

vote $proposal

echo "Check params, yo"
