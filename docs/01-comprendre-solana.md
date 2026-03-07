# 01 — Comprendre Solana et ce qu'on a fait

## Solana en 30 secondes

Solana est une blockchain rapide (~400ms par bloc) et pas chere (~$0.00025 par transaction).
C'est la blockchain preferee pour les meme coins parce que :
- Les transactions coutent quasi rien (vs $5-50 sur Ethereum)
- C'est rapide (vs 15 sec sur Ethereum)
- L'ecosysteme DeFi est mature (Jupiter, Raydium, Orca)

## SPL Token vs Token-2022

Solana a 2 programmes pour creer des tokens :

| | SPL Token (ancien) | Token-2022 (nouveau) |
|---|---|---|
| Programme | `TokenkegQfeZyiNwAJbNbGKPFXCWuBvf9Ss623VQ5DA` | `TokenzQdBNbLqP5VEhdkAS6EPFLC1PHnBqCXEpPxuEb` |
| Metadata | Necessite Metaplex (programme externe) | Integree directement (extension) |
| Cout metadata | ~0.01 SOL (compte Metaplex separee) | Inclus dans le mint |
| Features | Basique | Transfer fees, confidential transfers, etc. |
| Compatibilite | 100% des DEX | ~95% (Jupiter, Raydium OK) |

**On a choisi Token-2022** parce que la metadata est directement sur le token (plus simple, moins cher).

## Ce qu'on a fait concretement

### 1. Cree un wallet devnet
```
Adresse : 5hRvhwA74m8dnWg7BXoMRdcCRCEP3ATWnR9uhcmTeSu8
Keypair : ~/.config/solana/rouquin-devnet.json
```
Ce wallet est l'**authority** (proprietaire) du token. Il peut minter, modifier les metadata, etc.

### 2. Cree le token mint
```
Mint : 4Ce6xE1B8AhQCjij4TMwzUBvQ3NBu1N9iQ3oXib3TZw6
```
Le **mint** est l'adresse du token sur la blockchain. C'est son identite unique.
Equivalent du "contract address" sur Ethereum.

### 3. Initialise les metadata on-chain
- Name: "Rouquin"
- Symbol: "ROUQ"
- URI: (pointe vers metadata.json sur GitHub)

### 4. Cree un token account
```
Token Account : 2QR2AVZqQjmBLUJCpvmLaTs9Vanq5mKFPZ9avscacTxu
```
Sur Solana, chaque wallet qui detient un token a besoin d'un **token account** specifique.
C'est comme un sous-compte dedie a ce token dans ton wallet.

### 5. Minte 1,000,000 ROUQ
Les tokens ont ete crees et envoyes dans le token account.
Avec 9 decimales, 1 ROUQ = 1,000,000,000 unites atomiques (comme les lamports pour SOL).

## Schema : qui possede quoi

```
Wallet (Authority)
  5hRvhwA74m8dnWg7BXoMRdcCRCEP3ATWnR9uhcmTeSu8
  |
  |-- possede --> Token Account
  |               2QR2AVZqQjmBLUJCpvmLaTs9Vanq5mKFPZ9avscacTxu
  |               Balance: 1,000,000 ROUQ
  |
  |-- authority de --> Token Mint
                       4Ce6xE1B8AhQCjij4TMwzUBvQ3NBu1N9iQ3oXib3TZw6
                       Supply: 1,000,000
                       Decimals: 9
                       Program: Token-2022
```

## Commandes utiles pour verifier

```bash
# Voir les infos du token
spl-token display 4Ce6xE1B8AhQCjij4TMwzUBvQ3NBu1N9iQ3oXib3TZw6

# Voir ton solde ROUQ
spl-token balance 4Ce6xE1B8AhQCjij4TMwzUBvQ3NBu1N9iQ3oXib3TZw6

# Voir sur l'explorer
# https://explorer.solana.com/address/4Ce6xE1B8AhQCjij4TMwzUBvQ3NBu1N9iQ3oXib3TZw6?cluster=devnet
```

## Glossaire rapide

| Terme | Definition |
|-------|-----------|
| **Mint** | L'adresse du token (son identite). Equivalent du contract address EVM. |
| **Token Account** | Sous-compte dans un wallet pour detenir un token specifique. |
| **Authority** | Le wallet qui controle le token (peut minter, modifier metadata). |
| **Lamports** | Plus petite unite de SOL (1 SOL = 1 milliard de lamports). |
| **SPL** | Solana Program Library — les standards de tokens Solana. |
| **Devnet** | Reseau de test (SOL gratuit, pas de valeur reelle). |
| **Mainnet-beta** | Le vrai reseau Solana (vrais SOL, vrai argent). |
