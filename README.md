# base-chainlink-automation

> Chainlink Automation (Keepers) for Base L2

Automate smart contract tasks on Base using Chainlink Automation. Examples include vault harvesting, position rebalancing, price-triggered actions, and scheduled token distributions.

## Features
- ⚙️ Time-based automation (cron-like scheduling)
- 📊 Condition-based triggers (price threshold, TVL, health factor)
- 🔄 Vault auto-compound with Chainlink Keepers
- 💊 DeFi health factor monitor and auto-repay
- 🛡️ Circuit breaker automation

## Supported Upkeep Types
| Type | Trigger | Example |
|------|---------|---------|
| Time-based | Every N seconds | Harvest vault every 24h |
| Log-trigger | On-chain event | Rebalance on price change |
| Custom logic | `checkUpkeep` returns true | Auto-repay when HF < 1.2 |

## Installation
```bash
git clone https://github.com/fabt31/base-chainlink-automation
forge install && forge build
```

## Register Upkeep
1. Deploy your `AutomationCompatible` contract
2. Go to [automation.chain.link](https://automation.chain.link)
3. Register with LINK funding
4. Your contract runs automatically on Base!

## Chainlink on Base
- LINK Token: `0x88Fb150BDc53A65fe94Dea0c9BA0a6dAf8C6e196`
- Automation Registry: `0xE226D5aCae908252CcA3F6CEFa577527650a9e1f`

## License
MIT