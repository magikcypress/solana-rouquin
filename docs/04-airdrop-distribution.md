# 04 — Airdrop et distribution des tokens

## Pourquoi faire un airdrop ?

Un token sans holders, c'est un token mort. L'airdrop sert a :
1. **Creer une communaute initiale** de holders interesses
2. **Generer du buzz** (les gens parlent de ce qu'ils recoivent gratuitement)
3. **Distribuer le token** pour eviter la concentration (1 wallet = 100% du supply, ca fait peur)
4. **Creer du volume** — les recipients vont trader, ce qui attire d'autres traders

## Types d'airdrops

### 1. Airdrop classique (envoyer des tokens)

Tu envoies des ROUQ directement dans les wallets des gens.

```bash
# Envoyer 1000 ROUQ a un wallet
spl-token transfer 4Ce6xE1B8AhQCjij4TMwzUBvQ3NBu1N9iQ3oXib3TZw6 1000 <WALLET_ADDRESS> --fund-recipient
```

`--fund-recipient` est important : ca cree le token account du destinataire si il n'en a pas (coute ~0.002 SOL par recipient).

**Cout** : ~0.002 SOL par destinataire ($0.26)
**Pour 500 destinataires** : ~1 SOL ($130)

### 2. Claim airdrop (les gens viennent chercher)

Plus avance. Tu deploies un smart contract (ou utilises un service) ou les gens connectent leur wallet et "claim" leurs tokens.

Services existants :
- **Streamflow** — vesting + airdrops
- **Gumdrop** (Metaplex) — merkle tree airdrops
- **Disperser.xyz** — bulk transfers

Avantage : tu ne paies que pour ceux qui claim vraiment.

### 3. Social airdrop (engagement requis)

Les gens doivent faire quelque chose pour recevoir des tokens :
- Follow Twitter + RT + tag 3 amis
- Rejoindre le Telegram
- Creer un meme $ROUQ

C'est la methode la plus efficace pour creer du buzz.

## Plan de distribution concret

### Phase 1 : OG Airdrop (premiers 100 holders)

| Critere | Allocation |
|---------|-----------|
| Premiers 100 wallets a rejoindre Telegram | 500 ROUQ chacun |
| **Total** | **50,000 ROUQ (5% du supply)** |

Comment :
1. Creer un Google Form ou un bot Telegram
2. Les gens soumettent leur adresse wallet Solana
3. Tu verifies et envoies manuellement (ou via script)

Script d'envoi en masse :
```bash
#!/bin/bash
# bulk_airdrop.sh
MINT="4Ce6xE1B8AhQCjij4TMwzUBvQ3NBu1N9iQ3oXib3TZw6"
AMOUNT=500

while IFS= read -r wallet; do
    echo "Sending $AMOUNT ROUQ to $wallet..."
    spl-token transfer "$MINT" "$AMOUNT" "$wallet" --fund-recipient
    sleep 1  # Rate limiting
done < wallets.txt
```

### Phase 2 : Meme Contest Airdrop

| Critere | Allocation |
|---------|-----------|
| Meilleur meme (vote communaute) 1er | 10,000 ROUQ |
| 2eme-5eme | 5,000 ROUQ chacun |
| Participants (top 50) | 1,000 ROUQ chacun |
| **Total** | **~80,000 ROUQ** |

### Phase 3 : Holder Airdrop

Recompenser les gens qui gardent leurs ROUQ (pas de vente immediate).

Snapshot a J+30 : ceux qui ont encore leurs ROUQ recoivent un bonus de 50%.
Si tu avais 500 ROUQ de l'airdrop OG et que tu les as gardes → tu recois 250 ROUQ de plus.

## Comment trouver des wallets cibles

### Methode 1 : Communaute organique
- Twitter : poster avec #ROUQ, #SolanaMeme
- Telegram : creer le groupe, inviter
- Reddit : r/solana, r/CryptoMoonShots

### Methode 2 : Cibler les holders de meme coins similaires
Des outils comme **Birdeye** ou **Helius** permettent de voir les holders d'autres tokens.
Tu peux cibler les holders de BONK, WIF, POPCAT, etc.

```
Helius API : https://docs.helius.dev
→ getTokenAccounts pour lister les holders d'un token
```

### Methode 3 : Galxe / Zealy (quests)
Plateformes de quests ou les gens font des taches pour gagner des tokens :
- Suivre le Twitter
- Rejoindre le Telegram
- Partager un post
- Creer du contenu

## Budget airdrop

| Phase | ROUQ | SOL (frais) | $ estime |
|-------|------|-------------|----------|
| OG (100 wallets) | 50,000 | ~0.2 SOL | ~$26 |
| Meme Contest | 80,000 | ~0.1 SOL | ~$13 |
| Holder bonus | 25,000 | ~0.1 SOL | ~$13 |
| Reserve future | 245,000 | — | — |
| **Total alloue** | **400,000** | **~0.4 SOL** | **~$52** |

Les frais sont minimes sur Solana. Le vrai cout c'est ton temps.

## Erreurs a eviter

1. **Airdrop sans communaute** — Si tu airdrops a des randoms, ils vont vendre immediatement
2. **Trop de tokens par personne** — Mieux vaut 500 personnes avec 500 ROUQ que 5 personnes avec 50,000
3. **Pas de lock pour la team** — Les tokens team doivent etre lock 6 mois minimum
4. **Airdrop avant la pool** — Les gens ne peuvent rien faire des tokens sans liquidite. Airdrop APRES la pool.
