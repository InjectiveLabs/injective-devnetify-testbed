# Mainnet Devnetify Testbed (Single Validator, no voting, no binary swaps)

For legacy setup, with voting required and binary swaps, see [../singleval-vote](../singleval-vote)

Allows to take a network state snapshot, devnetify to run it locally with multi validators (4), and perform an upgrade handler. This allows to test upgrade handler locally for both testnet and mainnet live state.

## Steps to re-build the mainnet from scratch

NOTE:

Docker images always have a version tag, you can build image locally and make a special version tag.
Meanwhile, locally avaialable binaries (injectived), are not tagged, it uses whatever binary is available.

STEPS:

1. Re-generate target validators dirs and keys using `make gen` if target version changes. Uses [chain-stresser](https://github.com/InjectiveLabs/chain-stresser) binary.
2. Download the latest [mainnet state snapshot](https://polkachu.com/tendermint_snapshots/injective) from Polkachu
    - `data` -> `injective-1/validators/0/data`
    - `wasm` -> `injective-1/validators/0/wasm`
3. Run `./injective-1/cli/devnetify-local.sh`, wait for it to finish. Tip: set `UPGRADE_HANDLER_VERSION` to trigger an upgrade handler for store migrations.
4. At this moment you have a single-validator state with 1 validator.
5. Run network locally via `./injective-1/cli/injectived-local.sh`.
6. Access the node using CLI via local binary `./injective-1/cli/injectived-cli-local.sh`

## Useful endpoints

Use this to debug any step of devnetify process. All endpoints are pointing to the first node inside compose.

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

## Makefile

There is a handy Makefile to automate the process.

Default environment values:

```bash
CHAIN_ID=1 # set the chain id
VERSION_TO=v1.16.4 # set the version to
DOCKER_IMAGE?=injectivelabs/injective-core:$(VERSION_TO)
```

Targets:

```bash
make devnetify-local # devnetify the state using local bin
make devnetify # devnetify the state using tagged docker image
make injectived-local # run the node using local binary
make injectived # run the node using tagged docker image
make clean # clean up the data and wasm directories
make unpack # unpack the snapshot from the tar.lz4 file
```

There is also a `unpack` target to unpack the snapshot from any `*.tar.lz4` file. Just download the snapshot from Polkachu to the target chain dir and run `make unpack`. Use `CHAIN_ID` to set the valid chain dir prefix, e.g. `CHAIN_ID=1 make unpack`.
