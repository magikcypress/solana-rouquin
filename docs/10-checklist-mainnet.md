# 10 — Checklist Migration Mainnet

Tout ce qu'il ne faut pas oublier avant, pendant et après le déploiement de $ROUQ sur Mainnet Beta.

---

## Avant de créer le token

- [ ] **Keypair mainnet généré** et seed phrase notée sur papier (support hors-ligne)
- [ ] **2+ SOL** sur ce wallet (coût réel ~0.06 SOL, mais marge nécessaire pour les frais)
- [ ] **Repo `solana-rouquin` public** sur GitHub — indispensable pour que les URLs metadata soient accessibles
- [ ] `metadata.json` accessible publiquement via l'URL GitHub raw
- [ ] Image IPFS accessible (`curl -I https://ipfs.io/ipfs/<CID>` retourne 200)

```bash
# Vérifier metadata.json
curl -s https://raw.githubusercontent.com/magikcypress/solana-rouquin/main/metadata.json | python3 -m json.tool

# Vérifier image IPFS
curl -I https://ipfs.io/ipfs/bafkreibg652gpbvyszxspgivibv344e57akwsee222md7p6m7xfsoupore
```

---

## Création du token

```bash
# 1. Pointer le CLI sur mainnet
solana config set --url mainnet-beta
solana config get  # vérifier

# 2. Vérifier le solde du wallet
solana balance <WALLET_MAINNET>

# 3. Créer le token (Token-2022 avec metadata)
spl-token create-token \
  --decimals 9 \
  --program-2022 \
  --enable-metadata \
  --fee-payer ~/.config/solana/rouquin-mainnet.json

# 4. Initialiser les métadonnées
spl-token initialize-metadata <NOUVEAU_MINT> \
  "Rouquin" "ROUQ" \
  "https://raw.githubusercontent.com/magikcypress/solana-rouquin/main/metadata.json" \
  --fee-payer ~/.config/solana/rouquin-mainnet.json

# 5. Créer un token account et minter 1 000 000 ROUQ
spl-token create-account <NOUVEAU_MINT> --fee-payer ~/.config/solana/rouquin-mainnet.json
spl-token mint <NOUVEAU_MINT> 1000000 --fee-payer ~/.config/solana/rouquin-mainnet.json

# 6. Vérifier
spl-token display <NOUVEAU_MINT>
```

> **Nota** : noter soigneusement l'adresse du nouveau mint mainnet — elle est définitive.

---

## Dashboard (fruit)

Modifier `src/app/api/solana/route.ts` :

```typescript
// Adresse du nouveau mint mainnet
const MINT_ADDRESS = "<NOUVELLE_ADRESSE_MAINNET>";

// RPC mainnet fiable (Helius recommandé)
const RPC = "https://mainnet.helius-rpc.com/?api-key=<CLE_HELIUS>";

// Chemin du keypair mainnet
const KEYPAIR_PATH = "/mnt/ssd/apps/rouquin-dashboard/keypair-mainnet.json";
```

Désactiver l'airdrop (pas de faucet sur mainnet) :

```typescript
case "airdrop": {
  return NextResponse.json(
    { error: "Airdrop non disponible sur mainnet" },
    { status: 400 }
  );
}
```

Copier le keypair et rebuilder :

```bash
cp ~/.config/solana/rouquin-mainnet.json /mnt/ssd/apps/rouquin-dashboard/keypair-mainnet.json
cd /mnt/ssd/apps/rouquin-dashboard
npm run build
sudo systemctl restart rouquin-dashboard
```

---

## Site web (website/index.html)

- [ ] Remplacer l'adresse du contrat devnet par l'adresse mainnet
- [ ] Supprimer `?cluster=devnet` sur les liens Solana Explorer
- [ ] Retirer le badge "Solana Devnet" du hero

---

## Après le déploiement

### Sécurité (optionnel mais recommandé)

```bash
# Brûler la mint authority — supply définitivement fixée à 1 000 000 ROUQ
# Rassure les acheteurs : impossible de minter plus
spl-token authorize <MINT> mint --disable
```

> ⚠️ Irréversible. Ne pas faire avant d'avoir minté tous les tokens nécessaires.

### Liquidité

- [ ] Créer un pool de liquidité sur **Raydium** (SOL + ROUQ)
- [ ] Verrouiller les LP tokens (augmente la confiance)
- Voir [03-liquidite.md](03-liquidite.md)

### Visibilité

- [ ] Soumettre sur **DexScreener** — apparaître dans les charts
- [ ] Soumettre sur **Jupiter** — être tradable en swap
- [ ] **CoinGecko** / CoinMarketCap (listing ultérieur)
- Voir [06-listing-visibilite.md](06-listing-visibilite.md)

### Communauté

- [ ] Annoncer le contract address officiel sur Twitter (@RouquinSol) et Telegram
- [ ] Premier airdrop communautaire
- Voir [04-airdrop-distribution.md](04-airdrop-distribution.md) et [05-communaute.md](05-communaute.md)

---

## Budget estimé

| Opération | Coût SOL | Coût USD (~$130/SOL) |
|-----------|----------|----------------------|
| Création token | ~0.050 SOL | ~$6.50 |
| Création token account | ~0.002 SOL | ~$0.26 |
| Init metadata | ~0.010 SOL | ~$1.30 |
| Mint 1M tokens | ~0.000 SOL | ~$0.00 |
| **Total minimum** | **~0.062 SOL** | **~$8** |
| **Recommandé** | **2+ SOL** | **~$260** |

---

## Points critiques

1. **L'adresse mint mainnet est définitive** — une erreur dans les metadata nécessite de recréer un token
2. **Le repo GitHub doit rester public** — si privé, les URLs metadata cassent
3. **La seed phrase ne doit jamais être numérique** — papier uniquement, en lieu sûr
4. **Tester end-to-end sur devnet** avant de dépenser de vrais SOL

---

## Outils de validation (Dashboard)

La page `/mainnet` du dashboard permet de vérifier avant de déployer :
- Status du cluster mainnet
- Accessibilité metadata.json et image IPFS
- Balance SOL du wallet de déploiement
- Estimation des frais
- Checklist interactive des 13 points
