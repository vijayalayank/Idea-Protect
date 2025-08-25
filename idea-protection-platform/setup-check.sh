#!/bin/bash

# Idea Protection Platform - Setup Verification Script

echo "🚀 Idea Protection Platform Setup Verification"
echo "=============================================="
echo ""

# Check Node.js version
echo "📋 Checking Node.js version..."
if command -v node &> /dev/null; then
    NODE_VERSION=$(node --version)
    echo "✅ Node.js found: $NODE_VERSION"
    
    # Extract major version number
    MAJOR_VERSION=$(echo $NODE_VERSION | sed 's/v//' | cut -d. -f1)
    if [ "$MAJOR_VERSION" -ge 18 ]; then
        echo "✅ Node.js version is compatible (>= 18)"
    else
        echo "❌ Node.js version too old. Please upgrade to version 18 or higher"
        exit 1
    fi
else
    echo "❌ Node.js not found. Please install Node.js 18+ from https://nodejs.org"
    exit 1
fi

echo ""

# Check npm version
echo "📋 Checking npm version..."
if command -v npm &> /dev/null; then
    NPM_VERSION=$(npm --version)
    echo "✅ npm found: v$NPM_VERSION"
else
    echo "❌ npm not found. Please install npm"
    exit 1
fi

echo ""

# Check if package.json exists
echo "📋 Checking project files..."
if [ -f "package.json" ]; then
    echo "✅ package.json found"
else
    echo "❌ package.json not found. Are you in the project directory?"
    exit 1
fi

if [ -f "src/App.jsx" ]; then
    echo "✅ React app files found"
else
    echo "❌ React app files not found"
    exit 1
fi

echo ""

# Check if node_modules exists
echo "📋 Checking dependencies..."
if [ -d "node_modules" ]; then
    echo "✅ Dependencies already installed"
else
    echo "📦 Installing dependencies..."
    npm install
    
    if [ $? -eq 0 ]; then
        echo "✅ Dependencies installed successfully"
    else
        echo "❌ Failed to install dependencies"
        exit 1
    fi
fi

echo ""

# Check configuration file
echo "📋 Checking configuration..."
if [ -f "src/utils/constants.js" ]; then
    echo "✅ Configuration file found"
    
    # Check if Pinata config is set
    if grep -q "YOUR_PINATA_JWT_TOKEN" src/utils/constants.js; then
        echo "⚠️  Pinata credentials not configured yet"
        echo "   👉 Update src/utils/constants.js with your Pinata API credentials"
    else
        echo "✅ Pinata credentials appear to be configured"
    fi
    
    # Check if contract address is set
    if grep -q "0x0000000000000000000000000000000000000000" src/utils/constants.js; then
        echo "⚠️  Smart contract not deployed yet"
        echo "   👉 Deploy smart contract and update address in constants.js"
    else
        echo "✅ Smart contract address appears to be configured"
    fi
else
    echo "❌ Configuration file not found"
    exit 1
fi

echo ""

# Check if we can start the dev server
echo "📋 Testing development server..."
echo "Starting server for 5 seconds to test..."

# Start server in background and get PID
npm run dev &
SERVER_PID=$!

# Wait a bit for server to start
sleep 5

# Check if server is still running
if kill -0 $SERVER_PID 2>/dev/null; then
    echo "✅ Development server started successfully"
    
    # Try to check if server responds
    if command -v curl &> /dev/null; then
        if curl -s http://localhost:5173 > /dev/null; then
            echo "✅ Server is responding on http://localhost:5173"
        else
            echo "⚠️  Server started but not responding yet"
        fi
    fi
    
    # Kill the server
    kill $SERVER_PID 2>/dev/null
    wait $SERVER_PID 2>/dev/null
    echo "🛑 Test server stopped"
else
    echo "❌ Development server failed to start"
    echo "   Check the error messages above for issues"
fi

echo ""
echo "🎯 Setup Status Summary:"
echo "========================"

# Summary checks
NODE_OK=true
DEPS_OK=true
CONFIG_NEEDED=false

if [ ! -d "node_modules" ]; then
    DEPS_OK=false
fi

if grep -q "YOUR_PINATA_JWT_TOKEN" src/utils/constants.js 2>/dev/null || grep -q "0x0000000000000000000000000000000000000000" src/utils/constants.js 2>/dev/null; then
    CONFIG_NEEDED=true
fi

if [ "$NODE_OK" = true ] && [ "$DEPS_OK" = true ]; then
    echo "✅ Technical setup complete"
else
    echo "❌ Technical setup incomplete"
fi

if [ "$CONFIG_NEEDED" = true ]; then
    echo "⚠️  External services need configuration"
    echo ""
    echo "📝 Next Steps:"
    echo "1. Create Pinata account at https://pinata.cloud"
    echo "2. Deploy smart contract using Remix IDE"
    echo "3. Update src/utils/constants.js with your credentials"
    echo "4. Install MetaMask browser extension"
    echo "5. Get test ETH from Sepolia faucet"
    echo ""
    echo "📖 See COMPLETE_SETUP_NPM.md for detailed instructions"
else
    echo "✅ Configuration appears complete"
    echo ""
    echo "🚀 Ready to run:"
    echo "   npm run dev"
fi

echo ""
echo "🔗 Useful Links:"
echo "- Pinata IPFS: https://pinata.cloud"
echo "- Remix IDE: https://remix.ethereum.org"
echo "- MetaMask: https://metamask.io"
echo "- Sepolia Faucet: https://sepoliafaucet.com"