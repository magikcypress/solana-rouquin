# Rouquin (ROUQ)

<p align="center">
  <img src="assets/rouquin.jpg" alt="Rouquin Logo" width="300">
</p>

Token SPL sur la blockchain Solana (Devnet).

## Token Info

| Champ | Valeur |
|-------|--------|
| **Name** | Rouquin |
| **Symbol** | ROUQ |
| **Decimals** | 9 |
| **Supply** | 1,000,000 |
| **Program** | Token-2022 |
| **Network** | Devnet |
| **Mint** | `4Ce6xE1B8AhQCjij4TMwzUBvQ3NBu1N9iQ3oXib3TZw6` |

[Explorer Solana](https://explorer.solana.com/address/4Ce6xE1B8AhQCjij4TMwzUBvQ3NBu1N9iQ3oXib3TZw6?cluster=devnet)

## Stack

- **Solana CLI** (solana-cli + spl-token-cli)
- **Token-2022** (Token Extensions) avec metadata on-chain
- **Metadata** : JSON standard Metaplex

## Creation

```bash
# Installer Solana CLI
sh -c "$(curl -sSfL https://release.anza.xyz/stable/install)"

# Configurer devnet
solana config set --url devnet

# Obtenir du SOL de test
# -> https://faucet.solana.com

# Lancer la creation
bash create_token.sh
```

## Commandes utiles

```bash
# Voir les infos du token
spl-token display 4Ce6xE1B8AhQCjij4TMwzUBvQ3NBu1N9iQ3oXib3TZw6

# Voir le solde ROUQ
spl-token balance 4Ce6xE1B8AhQCjij4TMwzUBvQ3NBu1N9iQ3oXib3TZw6

# Envoyer des ROUQ
spl-token transfer 4Ce6xE1B8AhQCjij4TMwzUBvQ3NBu1N9iQ3oXib3TZw6 100 <adresse> --fund-recipient

# Mint plus de tokens
spl-token mint 4Ce6xE1B8AhQCjij4TMwzUBvQ3NBu1N9iQ3oXib3TZw6 <amount>
```

## Fichiers

```
solana-rouquin/
  assets/rouquin.jpg    # Logo du token
  metadata.json         # Metadata Metaplex (name, symbol, image)
  token_info.json       # Infos du token (mint, account, authority)
  create_token.sh       # Script de creation
```

## License

MIT
