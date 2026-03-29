# Python Pipeline Overview

This folder contains the Python scripts used to extract, clean, transform, and analyse DeFi and Bitcoin market data.

## Script Order

### `01_extract_chain_tvl.py`

Downloads Ethereum historical TVL data from DeFiLlama.

### `02_extract_multi_chain_tvl.py`

Downloads historical TVL data for major DeFi chains including Ethereum, Arbitrum, Base, Solana, and BSC.

### `03_extract_protocols.py`

Downloads protocol-level DeFi data from DeFiLlama.

### `04_clean_protocols.py`

Cleans protocol data by standardising columns, converting numeric fields, removing invalid records, and creating TVL size buckets.

### `05_analyse_protocol_flows.py`

Identifies the largest protocols by TVL and highlights the strongest 7-day inflows and outflows.

### `06_engineer_chain_features.py`

Calculates 1-day and 7-day TVL change metrics by chain.

### `07_extract_top_protocol_history.py`

Downloads historical TVL data for the top DeFi protocols.

### `08_extract_btc_price.py`

Downloads historical Bitcoin price data for correlation analysis.

## Workflow

The Python pipeline follows four stages:

1. Extract raw data from APIs
2. Clean and standardise the datasets
3. Engineer analytical features
4. Export outputs for dashboarding and further analysis

This structure was designed to mirror a real-world analytics workflow, making the project easier to audit, maintain, and extend.
