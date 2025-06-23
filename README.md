# 🚀 Campaign Management System

A comprehensive blockchain-based campaign management system built on BNB Chain (BSC) with IPFS integration for decentralized content storage.

## 📋 Table of Contents

- [Overview](#overview)
- [Architecture](#architecture)
- [Smart Contracts](#smart-contracts)
- [Features](#features)
- [Prerequisites](#prerequisites)
- [Installation](#installation)
- [Configuration](#configuration)
- [Deployment](#deployment)
- [Usage](#usage)
- [Scripts](#scripts)
- [Testing](#testing)
- [IPFS Integration](#ipfs-integration)
- [API Reference](#api-reference)
- [Troubleshooting](#troubleshooting)
- [Contributing](#contributing)
- [License](#license)

## 🎯 Overview

This project implements a decentralized campaign management system where users can:
- Create campaigns for content submission
- Submit content with AI model metadata
- Select winners and distribute rewards
- Store content on IPFS via Pinata
- Manage ERC20 token rewards

### Key Components:
- **Smart Contracts**: Campaign management and token distribution
- **IPFS Integration**: Decentralized content storage via Pinata
- **Blockchain**: BNB Chain (BSC) for transactions
- **TypeScript Scripts**: Independent interaction scripts
- **Comprehensive Testing**: Full test coverage

## 🏗️ Architecture

```
┌─────────────────┐    ┌─────────────────┐    ┌─────────────────┐
│   Frontend      │    │   Smart         │    │   IPFS/Pinata   │
│   (Future)      │◄──►│   Contracts     │◄──►│   Storage       │
└─────────────────┘    └─────────────────┘    └─────────────────┘
                              │
                              ▼
                       ┌─────────────────┐
                       │   BNB Chain     │
                       │   (BSC)         │
                       └─────────────────┘
```

## 📜 Smart Contracts

### 1. Campaign Contract (`contracts/campaign.sol`)

**Purpose**: Manages campaigns, submissions, and winner selection

**Key Features**:
- Campaign creation and management
- Submission handling (50 per block)
- Winner selection and reward distribution
- Points token integration

**Structs**:
```solidity
struct Submission {
    string submissionString; // IPFS CID
    string model;           // AI Model used
    uint256 llmTokensUsed;  // Token usage
    address submitter;      // Submitter address
}

struct CampaignStruct {
    Status status;          // Active/Inactive
    uint256[] submissionIds; // Submission references
    address winner;         // Selected winner
}
```

**Functions**:
- `createCampaign()` - Create new campaign
- `addSubmission(content[])` - Add 50 submissions
- `selectWinners(campaignId, submissionId, winner)` - Select winner
- `dispersePoints(campaignId)` - Distribute rewards
- `mintPoints(to, amount)` - Mint additional tokens

### 2. PointsToken Contract (`contracts/PointsToken.sol`)

**Purpose**: ERC20 token for campaign rewards

**Features**:
- Standard ERC20 functionality
- Mintable by contract owner
- Burnable tokens
- Permit functionality for gasless approvals

**Token Details**:
- **Name**: "Roast Points"
- **Symbol**: "pROAST"
- **Decimals**: 18
- **Initial Supply**: 1,000,000 tokens

### 3. BaseToken Contract (`contracts/BaseToken.sol`)

**Purpose**: Generic ERC20 token with advanced features

**Features**:
- ERC20 standard implementation
- Minting and burning capabilities
- Permit functionality
- Ownable access control

## ✨ Features

### Campaign Management
- ✅ Create multiple campaigns
- ✅ Submit content with metadata
- ✅ Track submission counts (max 1500 per campaign)
- ✅ Select winners
- ✅ Distribute token rewards

### Content Storage
- ✅ IPFS integration via Pinata
- ✅ Decentralized content storage
- ✅ Content addressing (CID)
- ✅ Metadata preservation

### Token System
- ✅ ERC20 reward tokens
- ✅ Automated reward distribution
- ✅ Minting capabilities
- ✅ Balance tracking

### Blockchain Integration
- ✅ BNB Chain (BSC) deployment
- ✅ Gas optimization
- ✅ Event emission
- ✅ Transaction verification

## 🔧 Prerequisites

### Required Software
- **Node.js** (v16 or higher)
- **npm** or **yarn**
- **Git**

### Blockchain Requirements
- **BNB Testnet** account
- **BNB tokens** for gas fees
- **Private key** for deployment

### IPFS Requirements
- **Pinata account** (free tier available)
- **API keys** for Pinata integration

## 📦 Installation

### 1. Clone Repository
```bash
git clone https://github.com/yourusername/campaign-system.git
cd campaign-system
```

### 2. Install Dependencies
```bash
npm install
```

### 3. Install Script Dependencies
```bash
cd scripts
npm install
cd ..
```

## ⚙️ Configuration

### 1. Environment Variables

Create a `.env` file in the root directory:

```env
# Blockchain Configuration
PRIVATE_KEY=your_private_key_here
BNB_TESTNET_RPC_URL=https://data-seed-prebsc-1-s1.binance.org:8545
BNB_MAINNET_RPC_URL=https://bsc-dataseed.binance.org

# Contract Addresses (after deployment)
CAMPAIGN_CONTRACT_ADDRESS=0xa8cfD45D9e2526A49Cf3600C9F7cc79Bf2D6F347
POINTS_TOKEN_CONTRACT_ADDRESS=0xF04F6222dD96f15466AEf22D7A9129dFeBb07F98

# Pinata Configuration
PINATA_API_KEY=your_pinata_api_key
PINATA_API_SECRET=your_pinata_api_secret
PINATA_JWT_SECRET=your_pinata_jwt_token

# API Keys (optional)
BASESCAN_API_KEY=your_basescan_api_key
BSCSCAN_API_KEY=your_bscscan_api_key
```

### 2. Network Configuration

The project supports multiple networks:

- **BNB Testnet** (Chain ID: 97)
- **BNB Mainnet** (Chain ID: 56)
- **Base Testnet** (Chain ID: 84532)
- **Base Mainnet** (Chain ID: 8453)

## 🚀 Deployment

### 1. Compile Contracts
```bash
npm run compile
```

### 2. Deploy to BNB Testnet
```bash
npm run deploy:campaign
```

### 3. Verify Contracts (Optional)
```bash
npm run verify:bnb-testnet
```

### Deployment Scripts
- `scripts/deployCampaign.ts` - Deploy campaign system
- `scripts/deploy.ts` - Deploy base token

## 📖 Usage

### Smart Contract Interaction

#### 1. Create Campaigns
```bash
ts-node scripts/createCampaigns.ts
```

#### 2. Add Submissions
```bash
ts-node scripts/addSubmissions.ts
```

#### 3. Select Winners
```bash
ts-node scripts/selectWinners.ts
```

#### 4. Mint Tokens
```bash
ts-node scripts/mintTokens.ts
```

### IPFS Content Upload

#### Upload to Pinata
```bash
cd pinata-upload
npm install
ts-node uploadToPinata.ts
```

## 📜 Scripts

### Independent TypeScript Scripts

All scripts are located in the `scripts/` directory and can run independently with `ts-node`.

#### 1. `createCampaigns.ts`
- Creates 10 campaigns
- Shows transaction hashes
- Displays campaign status

#### 2. `addSubmissions.ts`
- Adds 50 submissions per block
- Distributes across active campaigns
- Generates realistic dummy data

#### 3. `selectWinners.ts`
- Detects campaigns with submissions
- Selects winners automatically
- Cycles through predefined addresses

#### 4. `mintTokens.ts`
- Mints 10 million pROAST tokens
- Shows balance changes
- Verifies mint operation

### Hardhat Scripts

#### 1. `scripts/deployCampaign.ts`
- Deploys Campaign and PointsToken contracts
- Sets up initial configuration
- Provides deployment summary

#### 2. `scripts/deploy.ts`
- Deploys BaseToken contract
- Configures initial parameters

#### 3. `scripts/getStakedAmount.ts`
- Checks staked token balances
- Uses external contract integration

### Pinata Integration

#### `pinata-upload/uploadToPinata.ts`
- Uploads content to IPFS via Pinata
- Returns IPFS CID
- Handles various content types

## 🧪 Testing

### Run All Tests
```bash
npm test
```

### Run Specific Test Categories
```bash
# Campaign contract tests
npm test -- --grep "Campaign Contract"

# Gas reporting
npm run test:gas
```

### Test Coverage
```bash
npm run coverage
```

### Test Categories

#### 1. Deployment Tests
- Contract initialization
- Owner assignment
- Token configuration

#### 2. Campaign Management Tests
- Campaign creation (10 campaigns)
- Submission limits (1500 max)
- Winner selection
- Status management

#### 3. Token Tests
- ERC20 functionality
- Minting and burning
- Transfer operations
- Balance tracking

#### 4. Integration Tests
- Complete workflow testing
- Edge case handling
- Error scenarios

## 🌐 IPFS Integration

### Pinata Setup

1. **Create Account**: Sign up at [Pinata](https://pinata.cloud)
2. **Get API Keys**: Generate API key and secret
3. **Configure Environment**: Add keys to `.env` file

### Upload Process

```typescript
// Example upload
const content = "Hello, IPFS!";
const cid = await uploadToPinata(content);
console.log(`Content uploaded: ${cid}`);
```

### Content Types Supported
- Text files
- JSON data
- Metadata objects
- Binary files

## 📚 API Reference

### Campaign Contract

#### Events
```solidity
event CampaignCreated(uint256 indexed campaignId);
event SubmissionAdded(uint256 indexed contentID);
event WinnersSelected(uint256 indexed campaignId, uint256 winnerSubmissionId, address winner);
event PointsDispersed(uint256 indexed campaignId, address winner, uint256 points);
event PointsMinted(address indexed to, uint256 amount);
```

#### View Functions
```solidity
function campaignCounter() external view returns (uint256);
function submissionCounter() external view returns (uint256);
function totalSubmissions(uint256 campaignId) external view returns (uint256);
function pendingRewards(address winner) external view returns (uint256);
```

#### State-Changing Functions
```solidity
function createCampaign() external returns (uint256);
function addSubmission(content[] calldata _content) external returns(uint256[] memory);
function selectWinners(uint256 campaignId, uint256 winnerSubmissionId, address _winner) external;
function dispersePoints(uint256 campaignId) external;
function mintPoints(address to, uint256 amount) external;
```

### PointsToken Contract

#### Standard ERC20 Functions
```solidity
function name() external view returns (string);
function symbol() external view returns (string);
function decimals() external view returns (uint8);
function totalSupply() external view returns (uint256);
function balanceOf(address account) external view returns (uint256);
function transfer(address to, uint256 amount) external returns (bool);
function approve(address spender, uint256 amount) external returns (bool);
function transferFrom(address from, address to, uint256 amount) external returns (bool);
```

## 🔧 Troubleshooting

### Common Issues

#### 1. "PRIVATE_KEY not found"
- Ensure `.env` file exists
- Check private key format (no 0x prefix)
- Verify file permissions

#### 2. "Insufficient balance"
- Add BNB to your wallet for gas fees
- Check BNB Testnet faucet

#### 3. "Contract not deployed"
- Run deployment scripts first
- Verify contract addresses in `.env`

#### 4. "Campaign not active"
- Campaigns become inactive after winner selection
- Create new campaigns if needed

#### 5. "Max submissions reached"
- Each campaign limited to 1500 submissions
- Create new campaigns for more submissions

### Network Issues

#### BNB Testnet
- RPC URL: `https://data-seed-prebsc-1-s1.binance.org:8545`
- Chain ID: 97
- Faucet: [BNB Testnet Faucet](https://testnet.binance.org/faucet-smart)

#### Gas Optimization
- Use gas estimation before transactions
- Monitor gas prices
- Optimize contract calls

### Debug Commands

```bash
# Check network connection
npx hardhat console --network bnbTestnet

# Verify contract deployment
npx hardhat verify --network bnbTestnet CONTRACT_ADDRESS

# Check contract state
npx hardhat run scripts/checkStakedBalance.ts --network bnbTestnet
```

## 🤝 Contributing

### Development Setup

1. **Fork the repository**
2. **Create feature branch**
   ```bash
   git checkout -b feature/amazing-feature
   ```
3. **Make changes and test**
   ```bash
   npm test
   npm run compile
   ```
4. **Commit changes**
   ```bash
   git commit -m "Add amazing feature"
   ```
5. **Push to branch**
   ```bash
   git push origin feature/amazing-feature
   ```
6. **Create Pull Request**

### Code Standards

- **TypeScript**: Use strict mode
- **Solidity**: Follow OpenZeppelin standards
- **Testing**: Maintain >90% coverage
- **Documentation**: Update README for new features

### Testing Guidelines

- Write tests for all new functions
- Include edge cases
- Test error conditions
- Verify gas optimization

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🙏 Acknowledgments

- **OpenZeppelin**: Smart contract libraries
- **Hardhat**: Development framework
- **Pinata**: IPFS pinning service
- **BNB Chain**: Blockchain infrastructure
- **Ethers.js**: Ethereum library

## 📞 Support

### Resources
- [BNB Chain Documentation](https://docs.bnbchain.org/)
- [Pinata Documentation](https://docs.pinata.cloud/)
- [Hardhat Documentation](https://hardhat.org/docs)
- [OpenZeppelin Contracts](https://docs.openzeppelin.com/contracts/)

### Community
- **Discord**: [BNB Chain Community](https://discord.gg/bnbchain)
- **Telegram**: [BNB Chain Official](https://t.me/bnbchain)
- **GitHub Issues**: Report bugs and feature requests

---

**Built with ❤️ for the decentralized future**
