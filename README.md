## Testnet/Mainnet Devnetify Testbed

Allows to take `v1.15.0` state snapshot, devnetify to run it locally with a single validator, and upgrade it with new binary and `v1.16.0` upgrade handler. This allows to test upgrade handler locally for both testnet and mainnet live state.

This repo is a demo case for the devnetify process.

### Steps to re-build the testnet from scratch

1. Download the latest [testnet state snapshot](https://polkachu.com/testnets/injective/snapshots) from Polkachu
    - `data` -> `injective-888/data`
    - `wasm` -> `injective-888/wasm`
2. Run `devnetify-testnet-v1.15.sh`, wait for it to finish.
3. Run `injectived-v1.15.sh` in separate tab.
4. Run `apply-upgrade-testnet-v1.16.sh` (voting time is `10s` as per `custom_overrides.yaml`)
5. Verify it's done and wait until block is reached.

### Steps to re-build the mainnet from scratch

1. Download the latest [mainnet state snapshot](https://polkachu.com/tendermint_snapshots/injective) from Polkachu
    - `data` -> `injective-1/data`
    - `wasm` -> `injective-1/wasm`
2. Run `devnetify-mainnet-v1.15.sh`, wait for it to finish.
3. Run `injectived-v1.15.sh` in separate tab.
4. Run `apply-upgrade-mainnet-v1.16.sh` (voting time is `10s` as per `custom_overrides.yaml`)
5. Verify it's done and wait until block is reached.

### Useful endpoints

Use this to debug any step of devnetify process.

Last proposal
```
http://localhost:10337/cosmos/gov/v1beta1/proposals?pagination.limit=1&pagination.reverse=true
```

Voting params
```
http://localhost:10337/cosmos/gov/v1/params/voting
```

Validators set
```
http://localhost:10337/cosmos/staking/v1beta1/validators
```
