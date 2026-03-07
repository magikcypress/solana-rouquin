#!/bin/bash
# Create ROUQ token on Solana Devnet (Token-2022 with on-chain metadata)
#
# Prerequisites: solana CLI installed, wallet funded with ~0.1 SOL devnet
#
# Usage:
#   1. Get devnet SOL: visit https://faucet.solana.com
#      Wallet: 5hRvhwA74m8dnWg7BXoMRdcCRCEP3ATWnR9uhcmTeSu8
#   2. Run: bash create_token.sh
#
set -e

export PATH="$HOME/.local/share/solana/install/active_release/bin:$PATH"
KEYPAIR="$HOME/.config/solana/rouquin-devnet.json"

echo "=== ROUQ Token Creator (Solana Devnet) ==="
echo ""

# Verify config
solana config set --url devnet --keypair "$KEYPAIR" > /dev/null 2>&1
PUBKEY=$(solana-keygen pubkey "$KEYPAIR")
echo "Wallet: $PUBKEY"

# Check balance
BALANCE=$(solana balance --keypair "$KEYPAIR" 2>/dev/null | awk '{print $1}')
echo "Balance: $BALANCE SOL"

if (( $(echo "$BALANCE < 0.05" | bc -l) )); then
    echo ""
    echo "ERROR: Insufficient balance. Need at least 0.05 SOL."
    echo "Get devnet SOL at: https://faucet.solana.com"
    echo "Wallet address: $PUBKEY"
    exit 1
fi

echo ""
echo "--- Step 1: Create Token Mint (Token-2022 with metadata extension) ---"
MINT_OUTPUT=$(spl-token create-token --decimals 9 --program-2022 --enable-metadata --keypair "$KEYPAIR" 2>&1)
echo "$MINT_OUTPUT"
MINT_ADDRESS=$(echo "$MINT_OUTPUT" | grep -oE '[A-HJ-NP-Za-km-z1-9]{32,44}' | head -1)
echo "Token Mint: $MINT_ADDRESS"

echo ""
echo "--- Step 2: Initialize Metadata (Name: Rouquin, Symbol: ROUQ) ---"
spl-token initialize-metadata "$MINT_ADDRESS" "Rouquin" "ROUQ" "" --keypair "$KEYPAIR" 2>&1
echo ""

echo "--- Step 3: Create Token Account ---"
ACCOUNT_OUTPUT=$(spl-token create-account "$MINT_ADDRESS" --keypair "$KEYPAIR" --program-2022 2>&1)
echo "$ACCOUNT_OUTPUT"
TOKEN_ACCOUNT=$(echo "$ACCOUNT_OUTPUT" | grep -oE '[A-HJ-NP-Za-km-z1-9]{32,44}' | head -1)
echo "Token Account: $TOKEN_ACCOUNT"

echo ""
echo "--- Step 4: Mint 1,000,000 ROUQ ---"
spl-token mint "$MINT_ADDRESS" 1000000 --keypair "$KEYPAIR" 2>&1
echo ""

echo "=== DONE ==="
echo ""
echo "Token Details:"
echo "  Name:     Rouquin"
echo "  Symbol:   ROUQ"
echo "  Mint:     $MINT_ADDRESS"
echo "  Account:  $TOKEN_ACCOUNT"
echo "  Supply:   1,000,000 ROUQ"
echo "  Decimals: 9"
echo "  Program:  Token-2022"
echo "  Network:  Devnet"
echo ""
echo "View on explorer:"
echo "  https://explorer.solana.com/address/${MINT_ADDRESS}?cluster=devnet"
echo ""
echo "Commands:"
echo "  spl-token balance $MINT_ADDRESS"
echo "  spl-token display $MINT_ADDRESS"
echo "  spl-token transfer $MINT_ADDRESS <amount> <recipient> --fund-recipient"
echo ""

# Save token info
cat > token_info.json << JSONEOF
{
  "name": "Rouquin",
  "symbol": "ROUQ",
  "decimals": 9,
  "supply": 1000000,
  "mint": "$MINT_ADDRESS",
  "tokenAccount": "$TOKEN_ACCOUNT",
  "authority": "$PUBKEY",
  "program": "Token-2022",
  "network": "devnet",
  "created": "$(date -u +%Y-%m-%dT%H:%M:%SZ)"
}
JSONEOF
echo "Token info saved to token_info.json"
