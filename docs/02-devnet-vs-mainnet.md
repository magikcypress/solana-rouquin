# 02 — Devnet vs Mainnet : comment migrer

## Ou on est aujourd'hui

Le token $ROUQ existe sur **Devnet** (reseau de test).
Ca veut dire :
- Les SOL sont gratuits (faucet)
- Le token n'a aucune valeur reelle
- Personne ne peut l'acheter/vendre pour de vrai
- C'est parfait pour tester

## Pourquoi on a commence sur Devnet

1. **Gratuit** — pas besoin de vrais SOL
2. **Sans risque** — si on fait une erreur, on recommence
3. **Meme outils** — les commandes sont identiques, juste `--url devnet` vs `--url mainnet-beta`

## Ce qui change sur Mainnet

| Aspect | Devnet | Mainnet |
|--------|--------|---------|
| SOL | Gratuit (faucet) | Payant (~$130/SOL en mars 2026) |
| Cout creation token | 0 (SOL gratuit) | ~0.05 SOL (~$6.50) |
| Cout pool liquidite | 0 | ~2-5 SOL pour la creation + liquidite initiale |
| Valeur du token | Aucune | Ce que le marche decide |
| Visible sur | Explorer (cluster=devnet) | Jupiter, Birdeye, DexScreener, etc. |

## Procedure de migration

### Etape 1 : Preparer le wallet mainnet

```bash
# Generer un NOUVEAU keypair pour mainnet (securite)
solana-keygen new --outfile ~/.config/solana/rouquin-mainnet.json

# Configurer sur mainnet
solana config set --url mainnet-beta --keypair ~/.config/solana/rouquin-mainnet.json

# Afficher l'adresse
solana-keygen pubkey ~/.config/solana/rouquin-mainnet.json
```

**IMPORTANT** : Sauvegarde le fichier keypair ET la seed phrase. Si tu perds ca, tu perds le controle du token.

### Etape 2 : Financer le wallet

Envoyer des SOL vers l'adresse du wallet mainnet.
Budget minimum : **2 SOL** (~$260)
- 0.05 SOL pour creer le token
- 1-2 SOL pour la pool de liquidite initiale
- Le reste pour les transactions futures

Sources de SOL :
- Acheter sur un exchange (Binance, Coinbase, Kraken)
- Transferer depuis un autre wallet

### Etape 3 : Recreer le token

```bash
# Meme script, mais sur mainnet
solana config set --url mainnet-beta

# Creer le token (meme commandes que create_token.sh)
spl-token create-token --decimals 9 --program-2022 --enable-metadata
spl-token initialize-metadata <MINT> "Rouquin" "ROUQ" "https://raw.githubusercontent.com/magikcypress/solana-rouquin/main/metadata.json"
spl-token create-account <MINT> --program-2022
spl-token mint <MINT> 1000000
```

**Note** : L'adresse du token sera DIFFERENTE de celle du devnet. C'est normal.

### Etape 4 : Mettre a jour les references

- Mettre a jour `metadata.json` avec la nouvelle adresse
- Mettre a jour le site web (`website/index.html`) avec le nouveau contract address
- Mettre a jour `README.md`

### Etape 5 (optionnelle) : Vanity address

Tu peux generer une adresse de token qui commence par des lettres specifiques :
```bash
# Generer un keypair dont l'adresse commence par "ROUQ"
# ATTENTION : ca peut prendre des heures/jours pour 4+ caracteres
solana-keygen grind --starts-with ROUQ:1
```
Puis utiliser ce keypair comme mint keypair. C'est cosmetique mais ca fait pro.

## Budget realiste pour un lancement mainnet

| Poste | Cout estime |
|-------|-------------|
| Creation token | 0.05 SOL |
| Pool liquidite Raydium | 0.4 SOL (frais) + liquidite |
| Liquidite initiale | 1-5 SOL (selon ambition) |
| Transactions diverses | 0.1 SOL |
| **Total minimum** | **~2 SOL ($260)** |
| **Recommande** | **5-10 SOL ($650-1300)** |

Avec plus de liquidite initiale, le token parait plus serieux et le prix est moins volatile aux premiers trades.

## Checklist avant mainnet

- [ ] Wallet mainnet cree et sauvegarde
- [ ] SOL achetes et transferes
- [ ] Metadata JSON sur une URL permanente (GitHub public ou IPFS)
- [ ] Image du logo sur URL permanente
- [ ] Site web a jour avec bon contract address
- [ ] Comptes sociaux crees (Twitter, Telegram)
- [ ] Plan de distribution des tokens pret
- [ ] Pool de liquidite planifiee
