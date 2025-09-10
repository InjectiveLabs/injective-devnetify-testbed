# Testnet/Mainnet Devnetify Testbed

Allows to take `v1.15.0` state snapshot, devnetify to run it locally with a single validator, and upgrade it with new binary and `v1.16.0` upgrade handler. This allows to test upgrade handler locally for both testnet and mainnet live state.

This repo is a demo case for the devnetify process.

## Getting Started
 
 ```
 git clone org-44571224@github.com:InjectiveLabs/injective-devnetify-testbed.git
 cd injective-devnetify-testbed
 ```

 This repository uses Git LFS to store the genesis file and node keys. After cloning, make sure to fetch all required LFS files using git lfs pull.

 ```
 git lfs install
 git lfs pull
 ``` 

## Steps to re-build the testnet from scratch

1. Download the latest [testnet state snapshot](https://polkachu.com/testnets/injective/snapshots) from Polkachu
    - `data` -> `injective-888/data`
    - `wasm` -> `injective-888/wasm`
2. Run `./injective-888/cli/devnetify-v1.15.0.sh`, wait for it to finish.
3. Run `./injective-888/cli/injectived-v1.15.0.sh` in separate tab.
4. Run `./injective-888/cli/apply-upgrade-v1.16.0.sh` (voting time is `10s` as per `custom_overrides.yaml`)
5. Verify it's done and wait until block is reached, stop the node.
6. Ensure that a local `injectived` binary has `v1.16.0-beta.2` upgrade handler.
7. Run local `injectived` with `./injective-888/cli/injectived-local.sh` and validate the upgrade.

## Steps to re-build the mainnet from scratch

1. Download the latest [mainnet state snapshot](https://polkachu.com/tendermint_snapshots/injective) from Polkachu
    - `data` -> `injective-1/data`
    - `wasm` -> `injective-1/wasm`
2. Run `./injective-1/cli/devnetify-v1.16.2.sh`, wait for it to finish.
3. Run `./injective-1/cli/injectived-v1.16.2.sh` in separate tab.
4. Run `./injective-1/cli/apply-upgrade-v1.16.3.sh` (voting time is `10s` as per `custom_overrides.yaml`)
5. Verify it's done and wait until block is reached, stop the node.
6. Ensure that a local `injectived` binary has `v1.16.3` upgrade handler.
7. Run local `injectived` with `./injective-1/cli/injectived-local.sh` and validate the upgrade.

### Useful endpoints

Use this to debug any step of devnetify process.

Last proposal

```http
http://localhost:10337/cosmos/gov/v1beta1/proposals?pagination.limit=1&pagination.reverse=true
```

Voting params

```http
http://localhost:10337/cosmos/gov/v1/params/voting
```

Validators set

```http
http://localhost:10337/cosmos/staking/v1beta1/validators
```

### Makefile

There is a handy Makefile to automate the process.

Default environment values:

```bash
CHAIN_ID=888 # set the chain id
VERSION_FROM=v1.15.0 # set the version from
VERSION_TO=v1.16.0 # set the version to
```

Targets:

```bash
make devnetify # devnetify the state
make apply-upgrade # apply upgrade
make injectived # run injectived node with docker image
make injectived-local # run injectived node with local binary
make injectived-cli # run injectived client with docker image
make injectived-cli-local # run injectived client with local binary
make clean # clean up the data and wasm directories
make unpack # unpack the snapshot from the tar.lz4 file
```

There is also a `unpack` target to unpack the snapshot from any `*.tar.lz4` file. Just download the snapshot from Polkachu to the target chain dir and run `make unpack`. Use `CHAIN_ID` to set the valid chain dir prefix, e.g. `CHAIN_ID=1 make unpack`.
