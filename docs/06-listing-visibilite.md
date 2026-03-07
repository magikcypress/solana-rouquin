# 06 — Listing et visibilite : ou apparaitre

## Comment les gens decouvrent les meme coins

```
1. DexScreener / Birdeye → "New pairs" → trouvent le token
2. Twitter → quelqu'un en parle → cliquent le CA
3. Jupiter → cherchent le token → tradent
4. CoinGecko / CoinMarketCap → listing officiel → credibilite
```

L'objectif est d'etre visible sur TOUTES ces plateformes.

## Etape 1 : Apparition automatique (des la pool creee)

### Jupiter (agregateur #1 sur Solana)
- **Automatique** des qu'une pool Raydium/Orca existe
- Les gens peuvent swap SOL → ROUQ via jupiter.ag
- Pour que le logo et le nom apparaissent : soumettre sur la **Jupiter Token List**

```
https://github.com/jup-ag/token-list
→ Pull request pour ajouter ROUQ avec logo, nom, symbole
```

### DexScreener
- **Automatique** des qu'il y a des trades
- Affiche le chart, le volume, les holders
- Pour ajouter le logo/description : https://dexscreener.com/token-profile
- **Cout** : gratuit (basic) ou $300+ (verified badge)

### Birdeye
- **Automatique** des qu'une pool existe
- https://birdeye.so
- Similaire a DexScreener mais plus oriente Solana

## Etape 2 : Enrichir les profils (J+1 a J+7)

### DexScreener Token Profile
1. Aller sur https://dexscreener.com
2. Chercher le token par adresse
3. "Update token info" → soumettre logo, description, liens sociaux
4. Prend 24-48h pour etre valide

### Birdeye Token Profile
1. Aller sur https://birdeye.so
2. Chercher le token
3. "Claim token" → lier les reseaux sociaux
4. Ajouter logo, description

### Solscan
- https://solscan.io
- Le token apparait automatiquement
- Utile pour verifier les holders et transactions

## Etape 3 : Jupiter Verified Token List (J+7 a J+14)

Etre sur la liste verifiee de Jupiter = le token apparait avec son logo et nom au lieu d'une adresse brute.

**Criteres :**
- Pool de liquidite active
- Minimum de volume
- Pas de comportement suspect (pas de honeypot, etc.)

**Procedure :**
1. Fork https://github.com/jup-ag/token-list
2. Ajouter le token dans `validated-tokens.csv`
3. Creer une Pull Request avec :
   - Adresse du mint
   - Nom, symbole
   - Logo (URL permanente)
   - Decimals
   - Liens sociaux
4. Attendre la review (quelques jours)

## Etape 4 : CoinGecko / CoinMarketCap (J+14 a J+30)

C'est le "graal" pour la credibilite. Un token liste sur CoinGecko parait serieux.

### CoinGecko
- https://www.coingecko.com/fr/demander_un_listing
- **Criteres** :
  - Pool de liquidite active
  - Volume minimum ($10k+/jour aide)
  - Site web fonctionnel
  - Reseaux sociaux actifs
  - Pas de red flags
- **Delai** : 2-4 semaines

### CoinMarketCap
- https://coinmarketcap.com/currencies/listing/
- Criteres similaires a CoinGecko
- Souvent plus lent (4-8 semaines)

## Checklist visibilite

| Plateforme | Quand | Cout | Action |
|-----------|-------|------|--------|
| Jupiter (swap) | Auto (pool) | Gratuit | Rien a faire |
| DexScreener | Auto (trades) | Gratuit | Ajouter profil token |
| Birdeye | Auto (pool) | Gratuit | Claim token |
| Solscan | Auto | Gratuit | Rien a faire |
| Jupiter (verified list) | J+7 | Gratuit | Pull request GitHub |
| CoinGecko | J+14 | Gratuit | Formulaire de listing |
| CoinMarketCap | J+14 | Gratuit | Formulaire de listing |
| DexTools | J+7 | Gratuit | Formulaire |

## Paid promotion (optionnel)

| Service | Cout | Effet |
|---------|------|-------|
| DexScreener Boost | $300+ | Badge verifie, visibilite accrue |
| DexScreener Trending | $500-2000 | Apparaitre dans "Trending" |
| Twitter Ads | Variable | Cibler les crypto-enthousiastes |
| Telegram Ads | Variable | Promouvoir le groupe |

Pour un projet early stage, le gratuit suffit. Le paid promotion vient quand il y a deja une communaute et du volume.
