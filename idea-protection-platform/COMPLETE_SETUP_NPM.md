# 🚀 Complete Setup Guide - NPM Version

## Step 1: Install Project Dependencies

Navigate to your project folder and install dependencies:

```bash
# Navigate to project directory
cd idea-protection-platform

# Install all dependencies using npm
npm install

# Verify installation
npm list --depth=0
```

**Expected output:** Should show all dependencies installed without errors.

## Step 2: Set Up Pinata IPFS Account

### 2.1 Create Pinata Account
1. Go to [https://pinata.cloud/](https://pinata.cloud/)
2. Click "Start Building" or "Sign Up"
3. Create account with email/password
4. Verify your email address

### 2.2 Get API Credentials
1. Log into Pinata dashboard
2. Go to "API Keys" in the left sidebar
3. Click "New Key" button
4. Select "Admin" permissions
5. Give it a name (e.g., "Idea Protection Platform")
6. Click "Create Key"
7. **IMPORTANT:** Copy these three values immediately:
   - **JWT Token** (long string starting with `eyJ...`)
   - **API Key** (shorter string)
   - **API Secret** (another short string)

## Step 3: Install and Configure MetaMask

### 3.1 Install MetaMask
1. Go to [https://metamask.io/](https://metamask.io/)
2. Click "Download" and install browser extension
3. Create new wallet or import existing one
4. **Save your seed phrase securely!**

### 3.2 Add Sepolia Testnet
1. Open MetaMask
2. Click network dropdown (usually shows "Ethereum Mainnet")
3. Click "Add Network" or "Add Network Manually"
4. Enter these details:

```
Network Name: Sepolia Testnet
New RPC URL: https://rpc.sepolia.org
Chain ID: 11155111
Currency Symbol: ETH
Block Explorer URL: https://sepolia.etherscan.io
```

### 3.3 Get Test ETH
1. Copy your MetaMask wallet address
2. Go to [https://sepoliafaucet.com/](https://sepoliafaucet.com/)
3. Paste your address and request test ETH
4. Wait for transaction confirmation (1-2 minutes)
5. You should see test ETH in your MetaMask

## Step 4: Deploy Smart Contract

### Option A: Using Remix IDE (Recommended)

1. Go to [https://remix.ethereum.org/](https://remix.ethereum.org/)
2. Create new file: `IdeaProtection.sol`
3. Copy contract code from your project's `/contracts/IdeaProtection.sol`
4. Go to "Solidity Compiler" tab
5. Select compiler version `0.8.19` or higher
6. Click "Compile IdeaProtection.sol"
7. Go to "Deploy & Run Transactions" tab
8. Set Environment to "Injected Provider - MetaMask"
9. Ensure MetaMask shows "Sepolia" network
10. Select contract "IdeaProtection"
11. Click "Deploy"
12. Confirm transaction in MetaMask
13. **Copy the deployed contract address** (starts with `0x...`)

## Step 5: Configure Your Project

### 5.1 Update Configuration File
Open `/src/utils/constants.js` and replace the placeholder values:

```javascript
// Replace these with your actual credentials
export const PINATA_CONFIG = {
  JWT: 'your_pinata_jwt_token_here',          // Paste your JWT token
  API_KEY: 'your_pinata_api_key_here',        // Paste your API key  
  SECRET: 'your_pinata_secret_here',          // Paste your secret
  GATEWAY_URL: 'https://gateway.pinata.cloud/ipfs/'
}

// Replace with your deployed contract address
export const IDEA_PROTECTION_CONTRACT_ADDRESS = 'your_contract_address_here'
```

### 5.2 Create Environment File (Recommended for Security)
Create `.env.local` in your project root:

```bash
# Create environment file
touch .env.local
```

Add your credentials to `.env.local`:

```env
VITE_PINATA_JWT=your_jwt_token_here
VITE_PINATA_API_KEY=your_api_key_here
VITE_PINATA_SECRET=your_secret_here
VITE_CONTRACT_ADDRESS=your_contract_address_here
```

Then update `/src/utils/constants.js` to use environment variables:

```javascript
export const PINATA_CONFIG = {
  JWT: import.meta.env.VITE_PINATA_JWT || 'your_fallback_jwt',
  API_KEY: import.meta.env.VITE_PINATA_API_KEY || 'your_fallback_key',
  SECRET: import.meta.env.VITE_PINATA_SECRET || 'your_fallback_secret',
  GATEWAY_URL: 'https://gateway.pinata.cloud/ipfs/'
}

export const IDEA_PROTECTION_CONTRACT_ADDRESS = import.meta.env.VITE_CONTRACT_ADDRESS || 'your_fallback_address'
```

## Step 6: Test Your Setup

### 6.1 Start Development Server
```bash
# Start the development server
npm run dev
```

You should see:
```
  VITE v6.3.5  ready in XXX ms

  ➜  Local:   http://localhost:5173/
  ➜  Network: use --host to expose
```

### 6.2 Open Application
1. Open browser and go to `http://localhost:5173/`
2. You should see the Idea Vault welcome page
3. Click "Connect Wallet" button
4. MetaMask should prompt for connection
5. Approve the connection

### 6.3 Verify Everything Works
1. **Wallet Connection**: Should show your address in header
2. **Network**: Should automatically switch to Sepolia
3. **Navigation**: Try clicking Dashboard, Submit Idea, Marketplace
4. **No Console Errors**: Check browser dev tools for errors

## Step 7: Production Build (Optional)

To build for production:

```bash
# Create production build
npm run build

# Preview production build
npm run preview
```

## 🔧 NPM Scripts Available

```bash
npm run dev          # Start development server
npm run build        # Build for production  
npm run preview      # Preview production build
```

## ⚠️ Troubleshooting

### Issue: "Module not found" errors
```bash
# Clear npm cache and reinstall
npm cache clean --force
rm -rf node_modules package-lock.json
npm install
```

### Issue: "MetaMask not detected"
- Install MetaMask browser extension
- Refresh the page
- Check if MetaMask is enabled

### Issue: "Wrong network" 
- Switch MetaMask to Sepolia testnet
- Check network configuration is correct

### Issue: "Transaction failed"
- Ensure you have test ETH in your wallet
- Check contract address is correct
- Try increasing gas limit

### Issue: "IPFS upload fails"
- Verify Pinata credentials are correct
- Check file size (max 100MB)
- Test Pinata connection in browser

## ✅ Final Verification Checklist

- [ ] Node.js and npm installed
- [ ] All dependencies installed (`npm install` successful)
- [ ] MetaMask extension installed and configured
- [ ] Sepolia testnet added to MetaMask
- [ ] Test ETH received from faucet
- [ ] Pinata account created with API credentials
- [ ] Smart contract deployed to Sepolia
- [ ] Configuration file updated with all credentials
- [ ] Development server starts without errors (`npm run dev`)
- [ ] Wallet connects successfully
- [ ] No console errors in browser

**Your platform should now be fully functional!**

## 🎯 Next Steps

Once everything is working:
1. Try submitting a test idea
2. Upload some files to test IPFS
3. Browse the marketplace
4. Test wallet disconnect/reconnect

**Need help with any step?** Let me know which part you're stuck on!