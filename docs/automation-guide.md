# Chainlink Automation on Base

## Step 1: Deploy your AutomationCompatible contract
```bash
forge script script/Deploy.s.sol --rpc-url $BASE_RPC_URL --broadcast
```

## Step 2: Fund with LINK
Get LINK on Base from: https://faucets.chain.link/base

## Step 3: Register Upkeep
Visit https://automation.chain.link and connect to Base (chain ID 8453).

## Step 4: Monitor
Your contract will be called automatically when `checkUpkeep()` returns true.
