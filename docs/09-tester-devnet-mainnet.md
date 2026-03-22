# 09 — Tester le Devnet et le Mainnet

Guide pratique pour tester $ROUQ sur le devnet et preparer les tests mainnet, en ligne de commande et via le dashboard.

## Prérequis

### Outils nécessaires

```bash
# Vérifier que les outils sont installés
solana --version          # Solana CLI
spl-token --version       # SPL Token CLI
node --version            # Node.js (pour les scripts)
```

### Adresses de référence ($ROUQ Devnet)

| Élément | Adresse |
|---------|---------|
| Mint | `4Ce6xE1B8AhQCjij4TMwzUBvQ3NBu1N9iQ3oXib3TZw6` |
| Token Account | `2QR2AVZqQjmBLUJCpvmLaTs9Vanq5mKFPZ9avscacTxu` |
| Authority | `5hRvhwA74m8dnWg7BXoMRdcCRCEP3ATWnR9uhcmTeSu8` |
| Program | Token-2022 |
| Explorer | [Voir sur Solana Explorer](https://explorer.solana.com/address/4Ce6xE1B8AhQCjij4TMwzUBvQ3NBu1N9iQ3oXib3TZw6?cluster=devnet) |

---

## 1. Tester sur Devnet

### 1.1 Configurer le CLI sur Devnet

```bash
solana config set --url devnet
solana config get  # Vérifier la configuration
```

### 1.2 Obtenir des SOL de test (faucet)

```bash
# Airdrop 1 SOL sur ton wallet
solana airdrop 1 <TON_WALLET>

# Ou directement sur le wallet authority du token
solana airdrop 2 5hRvhwA74m8dnWg7BXoMRdcCRCEP3ATWnR9uhcmTeSu8
```

**Limite** : 5 SOL par adresse par 24h sur le faucet public.
Si la limite est atteinte → utiliser [faucet.solana.com](https://faucet.solana.com) (jusqu'à 10 SOL).

### 1.3 Vérifier le solde

```bash
# Solde SOL
solana balance 5hRvhwA74m8dnWg7BXoMRdcCRCEP3ATWnR9uhcmTeSu8

# Solde ROUQ
spl-token balance 4Ce6xE1B8AhQCjij4TMwzUBvQ3NBu1N9iQ3oXib3TZw6 \
  --owner 5hRvhwA74m8dnWg7BXoMRdcCRCEP3ATWnR9uhcmTeSu8
```

### 1.4 Tester un transfert ROUQ

```bash
# Envoyer 100 ROUQ à une adresse de test
spl-token transfer \
  4Ce6xE1B8AhQCjij4TMwzUBvQ3NBu1N9iQ3oXib3TZw6 \
  100 \
  <WALLET_DESTINATAIRE> \
  --fund-recipient \
  --program-id TokenzQdBNbLqP5VEhdkAS6EPFLC1PHnBqCXEpPxuEb
```

`--fund-recipient` crée le token account du destinataire si besoin (~0.002 SOL).

### 1.5 Vérifier les métadonnées

```bash
# Afficher les infos du token
spl-token display 4Ce6xE1B8AhQCjij4TMwzUBvQ3NBu1N9iQ3oXib3TZw6 \
  --program-id TokenzQdBNbLqP5VEhdkAS6EPFLC1PHnBqCXEpPxuEb
```

### 1.6 Via le Dashboard (Rouquin Dashboard)

Le dashboard Next.js sur fruit (port 3000) expose une API `/api/solana` :

```bash
# Tester l'airdrop SOL (1 SOL vers une adresse)
curl -X POST http://localhost:3000/api/solana \
  -H "Content-Type: application/json" \
  -d '{"action":"airdrop","wallet":"<TON_WALLET>"}'

# Vérifier le solde
curl -X POST http://localhost:3000/api/solana \
  -H "Content-Type: application/json" \
  -d '{"action":"balance","wallet":"<TON_WALLET>"}'

# Transférer des ROUQ
curl -X POST http://localhost:3000/api/solana \
  -H "Content-Type: application/json" \
  -d '{"action":"transfer","to":"<WALLET_DESTINATAIRE>","amount":100}'

# Lire les métadonnées du token
curl -X POST http://localhost:3000/api/solana \
  -H "Content-Type: application/json" \
  -d '{"action":"metadata"}'
```

**Erreur "airdrop limit reached"** : la limite de 5 SOL/24h est atteinte sur `api.devnet.solana.com`.
Solutions : attendre 24h, utiliser [faucet.solana.com](https://faucet.solana.com), ou changer de RPC.

### 1.7 Changer de RPC Devnet (si limite atteinte)

Dans `src/app/api/solana/route.ts`, remplacer :

```typescript
// Avant
const RPC = "https://api.devnet.solana.com";

// Après (Helius - tier gratuit, limites plus souples)
const RPC = "https://devnet.helius-rpc.com/?api-key=<TA_CLE>";
```

Créer une clé gratuite sur [helius.dev](https://helius.dev).

---

## 2. Tester sur Mainnet (simulation sans risque)

Avant de déployer réellement sur mainnet, on peut simuler et valider sans dépenser de vrais SOL.

### 2.1 Configurer sur Mainnet (lecture seule)

```bash
solana config set --url mainnet-beta

# Vérifier que le CLI pointe sur mainnet
solana config get
```

### 2.2 Simuler une transaction (dry-run)

```bash
# Simuler un transfert sans l'exécuter
spl-token transfer \
  <MINT_MAINNET> \
  100 \
  <WALLET_DESTINATAIRE> \
  --simulate
```

Le flag `--simulate` envoie la transaction au nœud pour validation mais ne la soumet pas.

### 2.3 Estimer les frais

```bash
# Voir le coût d'une transaction
solana fees
solana rent <NOMBRE_OCTETS>  # Coût de stockage d'un compte
```

Frais typiques sur mainnet :
- Transaction simple : ~0.000005 SOL ($0.001)
- Création d'un token account : ~0.002 SOL ($0.26)
- Création d'un token : ~0.05 SOL ($6.50)

### 2.4 Valider les métadonnées avant déploiement

```bash
# Vérifier que l'URL du metadata JSON est accessible
curl -s https://raw.githubusercontent.com/magikcypress/solana-rouquin/main/metadata.json | python3 -m json.tool

# Vérifier que l'image IPFS est accessible
curl -I https://ipfs.io/ipfs/bafkreibg652gpbvyszxspgivibv344e57akwsee222md7p6m7xfsoupore
```

**Important** : sur mainnet, les URLs doivent être permanentes et publiques.
- Repo GitHub **public** (pas privé)
- IPFS recommandé pour l'image

### 2.5 Test complet sur Devnet avant mainnet

Simuler un lancement complet sur devnet :

```bash
# 1. Créer un wallet de test "mainnet-like"
solana-keygen new --outfile /tmp/test-mainnet.json --no-bip39-passphrase

# 2. Financer (devnet)
solana airdrop 2 $(solana-keygen pubkey /tmp/test-mainnet.json) --url devnet

# 3. Créer un token (Token-2022)
spl-token --url devnet create-token \
  --decimals 9 \
  --program-2022 \
  --enable-metadata \
  --fee-payer /tmp/test-mainnet.json

# 4. Initialiser les métadonnées
spl-token --url devnet initialize-metadata <NOUVEAU_MINT> \
  "Rouquin" "ROUQ" \
  "https://raw.githubusercontent.com/magikcypress/solana-rouquin/main/metadata.json" \
  --fee-payer /tmp/test-mainnet.json

# 5. Minter 1 000 000 tokens
spl-token --url devnet create-account <NOUVEAU_MINT> --fee-payer /tmp/test-mainnet.json
spl-token --url devnet mint <NOUVEAU_MINT> 1000000 --fee-payer /tmp/test-mainnet.json

# 6. Vérifier
spl-token --url devnet display <NOUVEAU_MINT>
```

Si tout fonctionne sans erreur → le même script fonctionnera sur mainnet.

---

## 3. Checklist de validation avant mainnet

### Token & Métadonnées

- [ ] Metadata JSON accessible publiquement (URL permanente)
- [ ] Image IPFS accessible (`curl -I https://ipfs.io/ipfs/<CID>` retourne 200)
- [ ] `metadata.json` valide (nom, symbole, description, image)
- [ ] Script `create_token.sh` testé end-to-end sur devnet avec un nouveau wallet

### Wallet & Sécurité

- [ ] Keypair mainnet généré et sauvegardé (fichier + seed phrase)
- [ ] Backup du keypair sur support hors-ligne (clé USB, papier)
- [ ] Solde SOL suffisant sur le wallet mainnet (minimum 2 SOL recommandés)

### Dashboard & API

- [ ] Route `/api/solana` testée pour chaque action (airdrop, balance, transfer, metadata)
- [ ] Variable `MINT_ADDRESS` dans `route.ts` mise à jour avec l'adresse mainnet
- [ ] Variable `RPC` dans `route.ts` pointant vers un RPC mainnet fiable
- [ ] `KEYPAIR_PATH` pointe vers le keypair mainnet

### Site web

- [ ] Contract address mis à jour dans `website/index.html`
- [ ] Lien Explorer mis à jour (enlever `?cluster=devnet`)
- [ ] Badge "Solana Devnet" retiré du hero

---

## 4. Passer le Dashboard en Mainnet

Modifier `src/app/api/solana/route.ts` :

```typescript
// Remplacer ces deux constantes
const RPC = "https://api.mainnet-beta.solana.com";
// Ou un RPC privé plus fiable :
// const RPC = "https://mainnet.helius-rpc.com/?api-key=<CLE>";

const MINT_ADDRESS = "<NOUVELLE_ADRESSE_MAINNET>";
```

Puis rebuild et restart :

```bash
# Sur fruit
cd /mnt/ssd/apps/rouquin-dashboard
npm run build
sudo systemctl restart rouquin-dashboard
```

**Note** : l'action `airdrop` n'a pas de sens sur mainnet (pas de faucet). Penser à la désactiver ou retourner une erreur explicite :

```typescript
case "airdrop": {
  return NextResponse.json(
    { error: "Airdrop non disponible sur mainnet" },
    { status: 400 }
  );
}
```

---

## 5. RPC recommandés

| Réseau | URL | Limite | Notes |
|--------|-----|--------|-------|
| Devnet (public) | `https://api.devnet.solana.com` | 5 SOL/24h | Suffisant pour tests basiques |
| Devnet (Helius) | `https://devnet.helius-rpc.com/?api-key=<CLE>` | 1M req/mois | Tier gratuit |
| Mainnet (public) | `https://api.mainnet-beta.solana.com` | Rate-limited | Déconseillé en prod |
| Mainnet (Helius) | `https://mainnet.helius-rpc.com/?api-key=<CLE>` | 1M req/mois | Recommandé |
| Mainnet (QuickNode) | `https://...quiknode.pro/...` | Selon plan | Alternative |

Pour un usage faible (dashboard perso), le tier gratuit Helius est largement suffisant.
