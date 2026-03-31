#!/usr/bin/env bash
set -e

COINS="bitcoin,ethereum,solana,binancecoin,ripple"
SYMBOLS="BTC,ETH,SOL,BNB,XRP"
CSV_FILE="prices.csv"
DATE=$(date '+%Y-%m-%d %H:%M:%S')

# Fetch prices from CoinGecko
RESPONSE=$(curl -sf "https://api.coingecko.com/api/v3/simple/price?ids=$COINS&vs_currencies=usd")

if [ -z "$RESPONSE" ]; then
  echo "Error: failed to fetch prices from CoinGecko." >&2
  exit 1
fi

# Parse prices in order
PRICES=$(python3 -c "
import json, sys
data = json.loads('$RESPONSE'.replace(\"'\", '\"'))
ids = '$COINS'.split(',')
print(','.join(str(data[i]['usd']) for i in ids))
")

# Write header if file doesn't exist
if [ ! -f "$CSV_FILE" ]; then
  echo "date,$SYMBOLS" > "$CSV_FILE"
fi

# Append row
echo "$DATE,$PRICES" >> "$CSV_FILE"
echo "Appended prices to $CSV_FILE: $PRICES"
