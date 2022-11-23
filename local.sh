#!/bin/bash

KEY="mykey"
CHAINID="cist_9000-1"
MONIKER="localtestnet"
KEYRING="test"
KEYALGO="eth_secp256k1"
LOGLEVEL="info"
# to trace evm
TRACE="--trace"
# TRACE=""


# validate dependencies are installed
command -v jq > /dev/null 2>&1 || { echo >&2 "jq not installed. More info: https://stedolan.github.io/jq/download/"; exit 1; }

# remove existing daemon and client
rm -rf ~/.cist*

make install

cistd config keyring-backend $KEYRING
cistd config chain-id $CHAINID



# if $KEY exists it should be deleted
cistd keys add $KEY --keyring-backend $KEYRING --algo $KEYALGO

# Set moniker and chain-id for Ethermint (Moniker can be anything, chain-id must be an integer)
cistd init $MONIKER --chain-id $CHAINID

# Change parameter token denominations to ahihi
cat $HOME/.cist/config/genesis.json | jq '.app_state["staking"]["params"]["bond_denom"]="ahihi"' > $HOME/.cist/config/tmp_genesis.json && mv $HOME/.cist/config/tmp_genesis.json $HOME/.cist/config/genesis.json
cat $HOME/.cist/config/genesis.json | jq '.app_state["crisis"]["constant_fee"]["denom"]="ahihi"' > $HOME/.cist/config/tmp_genesis.json && mv $HOME/.cist/config/tmp_genesis.json $HOME/.cist/config/genesis.json
cat $HOME/.cist/config/genesis.json | jq '.app_state["gov"]["deposit_params"]["min_deposit"][0]["denom"]="ahihi"' > $HOME/.cist/config/tmp_genesis.json && mv $HOME/.cist/config/tmp_genesis.json $HOME/.cist/config/genesis.json
cat $HOME/.cist/config/genesis.json | jq '.app_state["mint"]["params"]["mint_denom"]="ahihi"' > $HOME/.cist/config/tmp_genesis.json && mv $HOME/.cist/config/tmp_genesis.json $HOME/.cist/config/genesis.json
cat $HOME/.cist/config/genesis.json | jq '.app_state["evm"]["params"]["evm_denom"]="ahihi"' > $HOME/.cist/config/tmp_genesis.json && mv $HOME/.cist/config/tmp_genesis.json $HOME/.cist/config/genesis.json



# increase block time (?)
cat $HOME/.cist/config/genesis.json | jq '.consensus_params["block"]["time_iota_ms"]="1000"' > $HOME/.cist/config/tmp_genesis.json && mv $HOME/.cist/config/tmp_genesis.json $HOME/.demo-onechain/config/genesis.json

# Set gas limit in genesis
cat $HOME/.cist/config/genesis.json | jq '.consensus_params["block"]["max_gas"]="10000000"' > $HOME/.cist/config/tmp_genesis.json && mv $HOME/.cist/config/tmp_genesis.json $HOME/.demo-onechain/config/genesis.json

# disable produce empty block
if [[ "$OSTYPE" == "darwin"* ]]; then
    sed -i '' 's/create_empty_blocks = true/create_empty_blocks = false/g' $HOME/.cist/config/config.toml
  else
    sed -i 's/create_empty_blocks = true/create_empty_blocks = false/g' $HOME/.cist/config/config.toml
fi

if [[ $1 == "pending" ]]; then
  if [[ "$OSTYPE" == "darwin"* ]]; then
      sed -i '' 's/create_empty_blocks_interval = "0s"/create_empty_blocks_interval = "30s"/g' $HOME/.cist/config/config.toml
      sed -i '' 's/timeout_propose = "3s"/timeout_propose = "30s"/g' $HOME/.cist/config/config.toml
      sed -i '' 's/timeout_propose_delta = "500ms"/timeout_propose_delta = "5s"/g' $HOME/.cist/config/config.toml
      sed -i '' 's/timeout_prevote = "1s"/timeout_prevote = "10s"/g' $HOME/.cist/config/config.toml
      sed -i '' 's/timeout_prevote_delta = "500ms"/timeout_prevote_delta = "5s"/g' $HOME/.cist/config/config.toml
      sed -i '' 's/timeout_precommit = "1s"/timeout_precommit = "10s"/g' $HOME/.cist/config/config.toml
      sed -i '' 's/timeout_precommit_delta = "500ms"/timeout_precommit_delta = "5s"/g' $HOME/.cist/config/config.toml
      sed -i '' 's/timeout_commit = "5s"/timeout_commit = "150s"/g' $HOME/.cist/config/config.toml
      sed -i '' 's/timeout_broadcast_tx_commit = "10s"/timeout_broadcast_tx_commit = "150s"/g' $HOME/.cist/config/config.toml
  else
      sed -i 's/create_empty_blocks_interval = "0s"/create_empty_blocks_interval = "30s"/g' $HOME/.cist/config/config.toml
      sed -i 's/timeout_propose = "3s"/timeout_propose = "30s"/g' $HOME/.cist/config/config.toml
      sed -i 's/timeout_propose_delta = "500ms"/timeout_propose_delta = "5s"/g' $HOME/.cist/config/config.toml
      sed -i 's/timeout_prevote = "1s"/timeout_prevote = "10s"/g' $HOME/.cist/config/config.toml
      sed -i 's/timeout_prevote_delta = "500ms"/timeout_prevote_delta = "5s"/g' $HOME/.cist/config/config.toml
      sed -i 's/timeout_precommit = "1s"/timeout_precommit = "10s"/g' $HOME/.cist/config/config.toml
      sed -i 's/timeout_precommit_delta = "500ms"/timeout_precommit_delta = "5s"/g' $HOME/.cist/config/config.toml
      sed -i 's/timeout_commit = "5s"/timeout_commit = "150s"/g' $HOME/.cist/config/config.toml
      sed -i 's/timeout_broadcast_tx_commit = "10s"/timeout_broadcast_tx_commit = "150s"/g' $HOME/.cist/config/config.toml
  fi
fi

# Allocate genesis accounts (cosmos formatted addresses)
cistd add-genesis-account $KEY 100000000000000000000000000ahihi --keyring-backend $KEYRING

# Sign genesis transaction
cistd gentx $KEY 1000000000000000000000ahihi --keyring-backend $KEYRING --chain-id $CHAINID

# Collect genesis tx
cistd collect-gentxs

# Run this to ensure everything worked and that the genesis file is setup correctly
cistd validate-genesis

if [[ $1 == "pending" ]]; then
  echo "pending mode is on, please wait for the first block committed."
fi

# Start the node (remove the --pruning=nothing flag if historical queries are not needed)
cistd start --pruning=nothing --evm.tracer=json $TRACE --log_level $LOGLEVEL --minimum-gas-prices=0.0001ahihi --json-rpc.api eth,txpool,personal,net,debug,web3,miner --api.enable