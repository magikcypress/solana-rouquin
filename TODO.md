# TODO — Rouquin $ROUQ

## Semaine 0 — Fondations (FAIT)

- [x] Token ROUQ cree sur Devnet (Token-2022, 1M supply, 9 decimals)
- [x] Metadata on-chain (name, symbol, image)
- [x] Site web landing page (website/index.html)
- [x] Repo GitHub + README + LICENSE
- [x] Documentation complete (8 guides dans docs/)

## 8 mars 2026 — Socials et deploiement

- [x] Deployer le site sur Vercel (rouquin.site)
- [x] Configurer DNS : migration Namecheap → Vercel DNS (ns1/ns2.vercel-dns.com)
- [x] Creer le compte Twitter @RouquinSol
- [x] Configurer l'API Twitter (OAuth 1.0a, plan Pay Per Use)
- [x] Creer le bot Telegram @RouquinSolBot
- [x] Script `tools/post.js` : publication simultanee Twitter + Telegram
- [x] Premier tweet poste
- [x] Ajouter liens sociaux sur le site (Twitter, Telegram, Explorer)
- [x] Creer le serveur Discord
- [x] Ajouter Discord sur le site (4 cartes : Twitter, Telegram, Discord, Explorer)
- [x] Cacher les boutons "Buy $ROUQ" (token pas encore sur DEX)
- [x] Creer le skill Claude Code `/RouquinSol`

---

## Semaine 1 — Socials et preparation mainnet

### Reseaux sociaux

- [ ] Passer le compte Twitter @RouquinSol en **public**
- [ ] Epingler un tweet de presentation avec le CA
- [ ] Bio Twitter : "Malin comme un Rouquin $ROUQ | Premier meme coin FR sur Solana | Community-driven"
- [ ] Banner Twitter : version large du logo avec ticker
- [ ] Creer le groupe/channel Telegram public (t.me/RouquinSOL)
- [ ] Migrer le bot Telegram du DM perso vers le channel public
- [ ] Configurer bot anti-spam Telegram (Combot ou Rose)
- [ ] Configurer le Discord : channels, roles, bot moderation, message bienvenue
- [ ] Creer un lien Discord **permanent** (sans expiration)

### Contenu

- [ ] Creer 10 memes ROUQ (templates + variations)
- [ ] Ecrire un thread Twitter de presentation du projet
- [ ] Poster 2-3 memes par jour
- [ ] Rejoindre les communautes Solana FR (Comusol, etc.)
- [ ] Integrer `post.js` dans **n8n** pour automatiser les publications

### Preparation mainnet

- [ ] Generer wallet mainnet (`solana-keygen new --outfile rouquin-mainnet.json`)
- [ ] Acheter 5-10 SOL
- [ ] Uploader metadata JSON + image sur **IPFS** (nft.storage ou Pinata)
- [ ] Tester la creation token en local

---

## Semaine 2 — Lancement mainnet

### Token mainnet

- [ ] Configurer Solana CLI sur mainnet-beta
- [ ] Creer le token mainnet (Token-2022, enable-metadata)
- [ ] Initialiser metadata avec URL IPFS
- [ ] Minter 1,000,000 ROUQ
- [ ] Desactiver la **mint authority** (irreversible)
- [ ] Desactiver la **freeze authority** (irreversible)

### Distribution initiale

- [ ] Creer les wallets de distribution :
  - [ ] Wallet Pool : 300,000 ROUQ (30%)
  - [ ] Wallet Airdrop : 400,000 ROUQ (40%)
  - [ ] Wallet Team : 100,000 ROUQ (10%) — lock 6 mois
  - [ ] Wallet Marketing : 100,000 ROUQ (10%)
  - [ ] Wallet Burn : 100,000 ROUQ (10%)
- [ ] Transferer les tokens vers chaque wallet
- [ ] Publier toutes les adresses des wallets (transparence)

### Pool de liquidite

- [ ] Creer la pool ROUQ/SOL sur **Raydium**
- [ ] Deposer 300,000 ROUQ + 2-5 SOL
- [ ] **Lock les LP tokens** (6-12 mois via Streamflow ou Raydium Lock)
- [ ] Verifier le score sur **RugCheck** (objectif : "Good")

### Lancement

- [ ] Mettre a jour le site avec la nouvelle adresse mainnet
- [ ] Reactiver les boutons "Buy $ROUQ" avec lien Jupiter
- [ ] Tweet de lancement officiel
- [ ] Poster sur Telegram + Discord
- [ ] Poster sur Reddit (r/solana, r/CryptoMoonShots, r/SatoshiStreetBets)
- [ ] Redeployer le site sur Vercel

---

## Semaine 3 — Airdrop et listing

### Airdrop OG (premiers 100-500 holders)

- [ ] Annoncer l'airdrop sur Twitter + Telegram
- [ ] Creer un formulaire (Google Form ou bot Telegram) pour collecter les wallets
- [ ] Verifier les wallets (retirer bots/doublons)
- [ ] Envoyer les airdrops via script bulk (500 ROUQ x 100 wallets = 50,000 ROUQ)
- [ ] Poster les preuves (liens transactions explorer)

### Listing et visibilite

- [ ] Soumettre le profil token sur **DexScreener** (logo, description, liens)
- [ ] Claim le token sur **Birdeye** (ajouter logo, socials)
- [ ] Pull request sur **Jupiter Token List** (verified token)
- [ ] Soumettre listing **CoinGecko**
- [ ] Soumettre listing **CoinMarketCap**

### Concours de memes

- [ ] Lancer le concours **#RouquinMemes** (5 jours)
- [ ] Vote communaute (reactions Telegram ou poll Twitter)
- [ ] Distribuer les prix : 1er 10,000 ROUQ, 2-5eme 5,000 ROUQ, top 50 1,000 ROUQ

---

## Semaine 4+ — Expansion

### Communaute

- [ ] Objectif : 500 followers Twitter, 200 membres Telegram
- [ ] Holder airdrop : snapshot J+30, bonus 50% pour ceux qui ont garde leurs ROUQ
- [ ] Collaborations avec micro-influenceurs FR (1k-10k followers)

### Developpement

- [ ] NFT collection "Rouquin Gang" (1,000 renards)
- [ ] Staking ROUQ → recompenses/NFTs
- [ ] Premier burn communautaire (vote DAO)
- [ ] Mini-jeu play-to-earn

### Listing avance

- [ ] CEX listing (MEXC, Gate.io)
- [ ] DexScreener verified badge ($300)

### Divers

- [ ] Merch officiel (hoodies, stickers)
- [ ] 1% des fees → protection des renards 🦊

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

## Budget estime

| Poste | SOL | $ estime |
|-------|-----|----------|
| Token creation (mainnet) | 0.05 | ~$7 |
| Pool de liquidite | 3-5 | ~$400-650 |
| Frais airdrops (500 wallets) | 1 | ~$130 |
| Frais transactions divers | 0.5 | ~$65 |
| Twitter API credits | — | $5 |
| DexScreener verified (optionnel) | — | $300 |
| **Total minimum** | **~5 SOL** | **~$650** |
| **Total recommande** | **~10 SOL** | **~$1,300** |
