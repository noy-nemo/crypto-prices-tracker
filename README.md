# crypto-tracker

A simple, lightweight cryptocurrency price tracker that runs entirely in the browser with no API keys or dependencies. Also available as an npm library.

## Getting Started

1. Clone the repository:

```bash
git clone https://github.com/noy-nemo/crypto-prices-tracker.git
```

2. Navigate into the directory and install:

```bash
cd crypto-prices-tracker
npm install
```

## Usage

**Export prices to CSV:**

```bash
npm run export-csv
```

**Use in the browser:**

Open `crypto-tracker.html` in any web browser — no build step required.

**Use as a library:**

Import the package directly into your project after installation.

## Features

- Live USD prices for BTC, ETH, SOL, BNB, and XRP
- Auto-refreshes every 60 seconds
- Shows last known prices if a fetch fails
- No API key required

## Data Source

Prices are fetched from the [CoinGecko public API](https://www.coingecko.com/en/api) (`/simple/price` endpoint).

## License

MIT
Last updated: 2026-04-06
