# 08 — Plan d'action semaine par semaine

## Vue d'ensemble

```
Semaine 0  [FAIT]  Token cree, site web, repo GitHub
Semaine 1          Socials + communaute + preparation mainnet
Semaine 2          Migration mainnet + pool + lancement
Semaine 3          Airdrop + listing + croissance
Semaine 4+         Expansion, contenu, partenariats
```

---

## Semaine 0 — Fondations (FAIT)

- [x] Token ROUQ cree sur Devnet (Token-2022)
- [x] Metadata on-chain (name, symbol)
- [x] Metadata JSON (image, description)
- [x] 1,000,000 ROUQ mintes
- [x] Site web landing page
- [x] Repo GitHub + README + LICENSE

---

## Semaine 1 — Socials et preparation

### Jour 1-2 : Creer les comptes

| Tache | Temps estime |
|-------|-------------|
| Creer Twitter @RouquinSol | 30 min |
| Bio, banner, photo de profil, lien site | 30 min |
| Creer groupe Telegram t.me/RouquinSOL | 30 min |
| Configurer bot anti-spam Telegram | 30 min |
| Premier tweet teaser | 15 min |

**Premier tweet suggestione :**
```
Something foxy is coming to Solana.

Le renard ne court pas. Il attend.

$ROUQ

rouquin.me (ou lien GitHub Pages)
```

### Jour 3-4 : Contenu initial

| Tache | Temps estime |
|-------|-------------|
| Creer 10 memes ROUQ (templates + variations) | 2h |
| Ecrire le thread Twitter de presentation | 1h |
| Poster 2-3 memes par jour | 15 min/jour |
| Rejoindre les communautes Solana FR | 1h |

### Jour 5-7 : Preparation mainnet

| Tache | Temps estime |
|-------|-------------|
| Generer wallet mainnet | 10 min |
| Acheter 5-10 SOL | 30 min |
| Uploader metadata JSON + image sur IPFS | 30 min |
| Tester la creation token en local | 1h |

#### IPFS pour les metadata (permanent)

GitHub c'est bien pour le dev, mais pour mainnet les metadata doivent etre permanentes :

```bash
# Option 1 : nft.storage (gratuit)
# Aller sur https://nft.storage
# Uploader rouquin.jpg → obtenir un CID
# Uploader metadata.json (avec le CID de l'image) → obtenir un CID

# Option 2 : Pinata (gratuit jusqu'a 500 Mo)
# https://pinata.cloud
```

L'URL IPFS ressemble a : `https://ipfs.io/ipfs/QmXyz.../metadata.json`
Elle est permanente et decentralisee.

---

## Semaine 2 — Lancement mainnet

### Jour 1 : Creation du token mainnet

```bash
# 1. Configurer mainnet
solana config set --url mainnet-beta --keypair ~/.config/solana/rouquin-mainnet.json

# 2. Creer le token
spl-token create-token --decimals 9 --program-2022 --enable-metadata

# 3. Metadata
spl-token initialize-metadata <MINT> "Rouquin" "ROUQ" "<IPFS_URL>"

# 4. Token account + mint
spl-token create-account <MINT> --program-2022
spl-token mint <MINT> 1000000

# 5. Desactiver mint authority
spl-token authorize <MINT> mint --disable

# 6. Desactiver freeze authority
spl-token authorize <MINT> freeze --disable
```

### Jour 2 : Distribution initiale

Creer les wallets de distribution :
```bash
# Wallet pour chaque allocation
solana-keygen new --outfile wallets/pool.json
solana-keygen new --outfile wallets/airdrop.json
solana-keygen new --outfile wallets/team.json
solana-keygen new --outfile wallets/marketing.json
solana-keygen new --outfile wallets/burn.json

# Transferer les tokens
spl-token transfer <MINT> 300000 <POOL_WALLET> --fund-recipient
spl-token transfer <MINT> 400000 <AIRDROP_WALLET> --fund-recipient
spl-token transfer <MINT> 100000 <TEAM_WALLET> --fund-recipient
spl-token transfer <MINT> 100000 <MARKETING_WALLET> --fund-recipient
spl-token transfer <MINT> 100000 <BURN_WALLET> --fund-recipient
```

### Jour 3 : Pool de liquidite

1. Importer le wallet pool dans Phantom
2. Aller sur https://raydium.io/liquidity/create-pool/
3. Creer la pool ROUQ/SOL
4. Deposer 300,000 ROUQ + 2-5 SOL
5. **Lock les LP tokens** (6-12 mois)

### Jour 4 : Annonce officielle

**Tweet de lancement :**
```
$ROUQ is LIVE on Solana.

Le Rouquin est dans la place.

Swap on Jupiter: [lien]
Chart: [DexScreener link]
CA: [adresse]

Airdrop for early supporters coming soon.

RT + Follow = first in line.
```

**Actions :**
- Mettre a jour le site web avec la nouvelle adresse mainnet
- Poster dans le Telegram
- Poster sur Reddit
- Soumettre le profil token sur DexScreener + Birdeye

### Jour 5-7 : Premiers trades et visibilite

- Surveiller les premiers trades sur DexScreener
- Repondre aux questions dans le Telegram
- Poster le chart a chaque milestone ($1k, $5k, $10k market cap)
- Commencer les demandes de listing Jupiter verified

---

## Semaine 3 — Airdrop et croissance

### Airdrop OG

| Jour | Action |
|------|--------|
| J1 | Annoncer l'airdrop sur Twitter + Telegram |
| J2-J4 | Collecter les wallets (Google Form ou bot) |
| J5 | Verifier les wallets, retirer les bots/doublons |
| J6 | Envoyer les airdrops (script bulk) |
| J7 | Poster les preuves (transactions explorer) |

### Listing

| Jour | Action |
|------|--------|
| J1 | Soumettre Jupiter verified token list (PR GitHub) |
| J3 | Soumettre CoinGecko listing |
| J5 | Soumettre CoinMarketCap listing |
| J7 | Verifier les profils DexScreener/Birdeye |

### Concours de memes

Lancer le concours #RouquinMemes :
1. Annoncer sur Twitter + Telegram
2. Duree : 5 jours
3. Vote par la communaute (reactions Telegram ou poll Twitter)
4. Distribuer les prix en ROUQ

---

## Semaine 4+ — Expansion

| Semaine | Focus | Actions |
|---------|-------|---------|
| S4 | Communaute | Atteindre 500 followers Twitter, 200 Telegram |
| S5 | Contenu | Collaborations avec micro-influenceurs FR |
| S6 | NFTs | Preparer la collection "Rouquin Gang" |
| S7 | Staking | Implementer le staking ROUQ → recompenses |
| S8 | CEX | Contacter les petits CEX (MEXC, Gate.io) |

---

## Metriques de succes

| Milestone | Objectif | Quand |
|-----------|---------|-------|
| Premier trade | Quelqu'un achete du ROUQ | Semaine 2 |
| 50 holders | Distribution initiale | Semaine 3 |
| $1k market cap | Premiers trades | Semaine 2-3 |
| 100 holders | Post-airdrop | Semaine 4 |
| 500 Twitter followers | Contenu regulier | Semaine 4-6 |
| Jupiter verified | Listing approuve | Semaine 3-4 |
| CoinGecko listing | Credibilite | Semaine 6-8 |
| $10k market cap | Croissance organique | Semaine 6-10 |

---

## Temps a investir par semaine

| Phase | Temps/semaine | Activites |
|-------|--------------|-----------|
| Semaine 1 | 8-10h | Setup socials, contenu, prep mainnet |
| Semaine 2 | 10-15h | Lancement, pool, annonces, monitoring |
| Semaine 3 | 8-10h | Airdrop, listing, concours |
| Semaine 4+ | 5-8h | Contenu quotidien, communaute, expansion |

Un meme coin, c'est comme un jardin : il faut l'arroser regulierement pour qu'il pousse.

---

## Budget total estime

| Poste | SOL | $ estime |
|-------|-----|----------|
| Token creation (mainnet) | 0.05 | $7 |
| Pool de liquidite | 3-5 | $400-650 |
| Frais airdrops (500 wallets) | 1 | $130 |
| Frais transactions divers | 0.5 | $65 |
| DexScreener verified (optionnel) | — | $300 |
| **Total minimum** | **~5 SOL** | **~$650** |
| **Total recommande** | **~10 SOL** | **~$1,300** |

Les plus gros couts sont la liquidite et le temps. Tout le reste est quasi gratuit sur Solana.
