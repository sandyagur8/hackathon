# Base Blockchain Hardhat Project

A comprehensive Hardhat development environment for building and deploying smart contracts on Base blockchain.

## Features

- 🚀 **Base Blockchain Ready**: Pre-configured for Base mainnet and testnet
- 🔧 **Modern Tooling**: Hardhat with TypeScript and Viem
- 📦 **OpenZeppelin Contracts**: Industry-standard smart contract libraries
- 🧪 **Comprehensive Testing**: Full test suite with gas reporting
- 🔍 **Contract Verification**: Easy verification on Basescan
- 📝 **Environment Management**: Secure configuration with dotenv

## Quick Start

### Prerequisites

- Node.js v20+ (use `nvm use 20`)
- npm or yarn

### Installation

1. Clone the repository
2. Install dependencies:
   ```bash
   npm install
   ```

3. Set up environment variables:
   ```bash
   cp .env.example .env
   # Edit .env with your configuration
   ```

### Environment Configuration

Create a `.env` file with the following variables:

```env
# Private key for deployment (without 0x prefix)
PRIVATE_KEY=your_private_key_here

# Base Mainnet RPC URL (optional - defaults to public RPC)
BASE_MAINNET_RPC_URL=https://mainnet.base.org

# Base Testnet RPC URL (optional - defaults to public RPC)
BASE_TESTNET_RPC_URL=https://sepolia.base.org

# Basescan API Key for contract verification
BASESCAN_API_KEY=your_basescan_api_key_here

# Enable gas reporting (set to true to enable)
REPORT_GAS=false
```

## Available Scripts

### Development
- `npm run compile` - Compile smart contracts
- `npm run test` - Run tests
- `npm run test:gas` - Run tests with gas reporting
- `npm run node` - Start local Hardhat node
- `npm run clean` - Clean build artifacts

### Deployment
- `npm run deploy:local` - Deploy to local network
- `npm run deploy:base-testnet` - Deploy to Base testnet
- `npm run deploy:base-mainnet` - Deploy to Base mainnet

### Verification
- `npm run verify:base-testnet` - Verify contract on Base testnet
- `npm run verify:base-mainnet` - Verify contract on Base mainnet

## Networks

### Base Mainnet
- **Chain ID**: 8453
- **RPC URL**: https://mainnet.base.org
- **Explorer**: https://basescan.org

### Base Testnet (Sepolia)
- **Chain ID**: 84532
- **RPC URL**: https://sepolia.base.org
- **Explorer**: https://sepolia.basescan.org

## Smart Contracts

### BaseToken
A feature-rich ERC20 token contract with:
- Standard ERC20 functionality
- Burnable tokens
- Permit functionality for gasless approvals
- Ownable admin functions
- Initial supply of 1 million tokens

## Testing

Run the test suite:
```bash
npm test
```

Run tests with gas reporting:
```bash
npm run test:gas
```

## Deployment

### Local Development
```bash
npm run node  # In one terminal
npm run deploy:local  # In another terminal
```

### Base Testnet
```bash
npm run deploy:base-testnet
```

### Base Mainnet
```bash
npm run deploy:base-mainnet
```

## Contract Verification

After deployment, verify your contract on Basescan:

```bash
# For testnet
npx hardhat verify --network baseTestnet DEPLOYED_CONTRACT_ADDRESS "Constructor Arg 1" "Constructor Arg 2"

# For mainnet
npx hardhat verify --network baseMainnet DEPLOYED_CONTRACT_ADDRESS "Constructor Arg 1" "Constructor Arg 2"
```

## Getting Base ETH

### Testnet (Sepolia)
- [Base Sepolia Faucet](https://www.coinbase.com/faucets/base-ethereum-sepolia-faucet)
- [Chainlink Faucet](https://faucets.chain.link/base-sepolia)

### Mainnet
- Bridge ETH from Ethereum mainnet using the [Base Bridge](https://bridge.base.org)

## Resources

- [Base Documentation](https://docs.base.org/)
- [Hardhat Documentation](https://hardhat.org/docs)
- [OpenZeppelin Contracts](https://docs.openzeppelin.com/contracts/)
- [Basescan](https://basescan.org/)

## License

MIT
