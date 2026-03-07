# 07 — Securite, confiance et aspects legaux

## Les red flags que les traders verifient

Quand quelqu'un decouvre un nouveau meme coin, il verifie (via RugCheck, Birdeye, etc.) :

| Check | Red flag | Ce qu'on fait |
|-------|----------|--------------|
| Mint authority | Active = peut minter plus de tokens | A desactiver apres mint |
| Freeze authority | Active = peut geler les wallets | A desactiver |
| Top holders | 1 wallet > 50% = rug risk | Distribuer via airdrop + pool |
| LP lock | Pas lock = peut retirer la liquidite | Lock ou burn les LP tokens |
| Contract verified | Code pas verifiable | Token-2022 standard (pas de custom code) |

## Actions de securite a faire

### 1. Desactiver la Mint Authority (IMPORTANT)

Ca empeche de creer plus de tokens que le supply initial. Signal de confiance #1.

```bash
# Desactiver la mint authority (IRREVERSIBLE)
spl-token authorize <MINT_ADDRESS> mint --disable
```

**Quand** : Apres avoir minte les 1,000,000 ROUQ et distribue comme prevu.
**Attention** : Une fois desactivee, c'est DEFINITIF. Tu ne pourras plus jamais minter de ROUQ.

### 2. Desactiver la Freeze Authority

Ca empeche de geler les wallets des holders (comportement de scam).

```bash
# Desactiver la freeze authority (IRREVERSIBLE)
spl-token authorize <MINT_ADDRESS> freeze --disable
```

### 3. Lock ou burn la liquidite

Voir le chapitre [03-liquidite.md](03-liquidite.md).
Minimum : lock 6 mois. Ideal : burn les LP tokens.

### 4. Multi-sig (optionnel, avance)

Au lieu d'un seul wallet qui controle tout, utiliser un multi-sig (Squads Protocol sur Solana) qui necessite 2/3 signatures pour agir.

https://squads.so

## RugCheck : l'outil que tout le monde utilise

https://rugcheck.xyz

Cet outil analyse automatiquement un token et donne un score de risque.

**Ce qu'il verifie :**
- Mint authority active/desactivee
- Freeze authority
- Distribution des tokens (concentration)
- Liquidite lockee ou non
- Top holders

**Objectif** : avoir un score "Good" sur RugCheck. Ca rassure les acheteurs.

## Transparence = confiance

### Ce qu'il faut rendre public

1. **Contract address** (deja fait via le site)
2. **Distribution des tokens** — montrer ou vont les 1M de ROUQ
3. **Identite de la team** — anonyme = moins de confiance, mais courant pour les meme coins
4. **Lock proof** — lien vers la transaction de lock des LP tokens
5. **Roadmap** — ce qu'on fait et quand (deja sur le site)

### Wallet de transparence

Creer des wallets separes pour chaque allocation :
```
Wallet Pool       → 300,000 ROUQ (30%)
Wallet Airdrop    → 400,000 ROUQ (40%)
Wallet Team       → 100,000 ROUQ (10%) [LOCK 6 MOIS]
Wallet Marketing  → 100,000 ROUQ (10%)
Wallet Burn       → 100,000 ROUQ (10%)
```

Publier toutes les adresses. N'importe qui peut verifier sur l'explorer.

## Aspects legaux

### Disclaimer (deja sur le site)

> $ROUQ is a meme coin with no intrinsic value or expectation of financial return.
> Not financial advice, just foxy vibes.

Ce disclaimer est important. Il dit clairement :
- Pas de promesse de rendement
- C'est un meme, pas un investissement
- DYOR (Do Your Own Research)

### Ce qui est legal

- Creer un token : legal partout (c'est du code)
- Creer une pool de liquidite : legal (c'est de la DeFi)
- Faire un airdrop : legal (c'est un cadeau)
- Faire de la promotion : legal tant que pas de promesse de rendement

### Ce qui peut poser probleme

- **Promesse de rendement** : "Achetez $ROUQ, ca va x100" → interdit dans la plupart des pays
- **ICO / vente de tokens** : vendre des tokens contre de l'argent peut etre considere comme une emission de titre financier
- **Manipulation de marche** : wash trading, pump & dump coordonne → illegal

### Recommandations

1. **Ne jamais promettre de rendement** — "to the moon" en meme c'est OK, "vous allez gagner de l'argent" c'est pas OK
2. **Pas de vente privee** — distribuer gratuitement (airdrop) ou via pool (marche libre)
3. **Disclaimer partout** — site, Twitter bio, Telegram pinned
4. **Residence fiscale** — en France, les gains crypto sont imposes (flat tax 30%). Declarer si tu fais des benefices.

## Pieges courants a eviter

| Piege | Pourquoi c'est dangereux | Solution |
|-------|-------------------------|----------|
| Laisser mint authority active | Les gens pensent que tu vas diluer | Desactiver apres mint |
| Pas de lock LP | Rug pull possible | Lock 6-12 mois minimum |
| Trop de tokens dans 1 wallet | Looks like a rug | Distribuer dans plusieurs wallets |
| Copier le code d'un scam | Fonctions cachees (honeypot) | Token-2022 standard, pas de custom code |
| Payer pour du "marketing" a des inconnus | Arnaque courante | Verifier les references, commencer petit |
| Envoyer les clefs privees | Perte totale | Ne JAMAIS partager le keypair |
