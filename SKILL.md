# SKILL.md — Projet RouquinSol

## Description

### Objectif
Gestion complète du projet **Rouquin ($ROUQ)**, premier meme coin francophone sur Solana. Ce skill couvre :
- Publication simultanée sur Twitter/X et Telegram
- Déploiement du site web sur Vercel
- Gestion du token Solana (Token-2022)
- Communication communautaire (Twitter, Telegram, Discord)

### Cas d'usage
- Poster un message sur Twitter + Telegram en une commande
- Déployer/mettre à jour le site rouquin.site
- Vérifier l'état du token sur Solana Explorer
- Gérer les réseaux sociaux du projet

### Technologies clés
| Couche | Technologies |
|---|---|
| **Blockchain** | Solana (Devnet), Token-2022, SPL Token |
| **Site web** | HTML statique, Vercel, domaine rouquin.site |
| **Social** | Twitter/X API v2 (OAuth 1.0a), Telegram Bot API |
| **Outils** | Node.js, twitter-api-v2, dotenv |
| **Communauté** | Twitter @RouquinSol, Telegram t.me/RouquinSOL, Discord |

---

## Guide pour Claude

### Projet
- **Répertoire** : `/Users/cyp/Documents/work/Claude/solana-rouquin`
- **GitHub** : `magikcypress/solana-rouquin`
- **Site** : https://rouquin.site
- **Vercel project** : `magikcypress-projects/solana-rouquin`

### Structure du projet

```
solana-rouquin/
├── website/
│   ├── index.html          # Landing page du meme coin
│   ├── rouquin.jpg         # Logo/image du renard
│   └── .vercel/            # Config Vercel (lié au projet)
├── tools/
│   ├── post.js             # Script post Twitter + Telegram simultané
│   ├── package.json        # Dépendances (twitter-api-v2, dotenv)
│   ├── .env                # Clés API (NE JAMAIS COMMITTER)
│   └── .env.example        # Template des variables
├── assets/
│   ├── banner.jpg
│   └── emoji.png
├── docs/                   # Documentation (8 guides)
├── create_token.sh         # Script de création du token
├── token_info.json         # Infos du token (mint, authority, etc.)
├── metadata.json           # Metadata on-chain du token
└── README.md
```

### Fichiers clés

#### Token Solana
- **`token_info.json`** — Infos du token : mint address `4Ce6xE1B8AhQCjij4TMwzUBvQ3NBu1N9iQ3oXib3TZw6`, authority, token account, réseau devnet
- **`metadata.json`** — Metadata on-chain (nom, symbole, image)
- **`create_token.sh`** — Script bash de création du token via Solana CLI + Token-2022

#### Site web
- **`website/index.html`** — Landing page complète (nav, hero, about, tokenomics, roadmap, community, footer)
- **`website/.vercel/project.json`** — Lié au projet Vercel `solana-rouquin`

#### Outil de publication
- **`tools/post.js`** — Script ESM Node.js qui poste simultanément sur Twitter (API v2) et Telegram (Bot API)
- **`tools/.env`** — Contient `TWITTER_API_KEY`, `TWITTER_API_SECRET`, `TWITTER_ACCESS_TOKEN`, `TWITTER_ACCESS_SECRET`, `TELEGRAM_BOT_TOKEN`, `TELEGRAM_CHAT_ID`

### Commandes principales

| Action | Commande |
|---|---|
| **Poster sur Twitter + Telegram** | `cd tools && node post.js "message"` |
| **Déployer le site** | `cd website && script -q /dev/null vercel --prod --yes 2>&1 \| cat` |
| **Vérifier le token** | Ouvrir `https://explorer.solana.com/address/4Ce6xE1B8AhQCjij4TMwzUBvQ3NBu1N9iQ3oXib3TZw6?cluster=devnet` |
| **Vérifier DNS** | `dig rouquin.site NS @8.8.8.8 +short` |
| **Vérifier compte Twitter** | Via API v2 `client.v2.me()` |

### Comptes & réseaux sociaux

| Plateforme | Identifiant | Statut |
|---|---|---|
| **Twitter/X** | @RouquinSol | Compte protégé (privé) |
| **Telegram** | Bot RouquinSolBot | Actif, poste en DM (chat_id: 1566871292) |
| **Discord** | discord.gg/4vYawvMJ | Serveur créé |
| **Site** | rouquin.site | Déployé sur Vercel, DNS via Vercel |
| **Explorer** | Solana Devnet | Token actif |

### Token $ROUQ

| Paramètre | Valeur |
|---|---|
| **Nom** | Rouquin |
| **Symbole** | ROUQ |
| **Réseau** | Solana Devnet |
| **Programme** | Token-2022 |
| **Mint** | `4Ce6xE1B8AhQCjij4TMwzUBvQ3NBu1N9iQ3oXib3TZw6` |
| **Token Account** | `2QR2AVZqQjmBLUJCpvmLaTs9Vanq5mKFPZ9avscacTxu` |
| **Authority** | `5hRvhwA74m8dnWg7BXoMRdcCRCEP3ATWnR9uhcmTeSu8` |
| **Supply** | 1,000,000 |
| **Decimals** | 9 |
| **Tax** | 0% |

### Conventions

- **Déploiement Vercel** : Toujours depuis `website/` (pas la racine du projet). Utiliser `script -q /dev/null` pour émuler un TTY car le CLI Vercel bloque en non-interactif.
- **Scope Vercel** : `magikcypress-projects`
- **Post social** : Toujours depuis `tools/` avec `node post.js "message"`
- **Git** : Ne jamais committer `.env`, `node_modules/`, `.vercel/`
- **Twitter API** : Plan "Pay Per Use", crédits prépayés ($5 min). OAuth 1.0a pour poster.
- **Telegram** : Bot API simple avec `fetch()`, pas de dépendance externe.

### Pièges et points d'attention

1. **Vercel TTY** : Le CLI Vercel refuse de fonctionner en mode non-interactif. Wrapper avec `script -q /dev/null ... 2>&1 | cat`
2. **Vercel scope** : Toujours spécifier `--scope magikcypress-projects` si le wrapper TTY ne fonctionne pas
3. **Twitter 402** : Si erreur 402, vérifier les crédits API sur developer.x.com > Facturation > Crédits
4. **Twitter 401** : Régénérer Access Token + Secret après changement de permissions (Read → Read+Write)
5. **Twitter 403** : Permissions de l'app pas en "Read and Write" (dans User authentication settings)
6. **DNS rouquin.site** : Nameservers Vercel (`ns1.vercel-dns.com`, `ns2.vercel-dns.com`), configurés chez Namecheap
7. **Boutons Buy** : Actuellement cachés (commentés en HTML), à réactiver quand le token sera sur un DEX
8. **Telegram chat_id** : Actuellement en DM perso (1566871292), à migrer vers un channel/groupe public
9. **Discord** : Lien d'invitation `discord.gg/4vYawvMJ` peut expirer, penser à le rendre permanent
10. **Token devnet** : Le token est sur devnet, pas encore mainnet. L'explorer link utilise `?cluster=devnet`

### TODO / Roadmap

- [ ] Passer Twitter @RouquinSol en public
- [ ] Configurer Discord (channels, rôles, bot modération, message bienvenue)
- [ ] Créer channel/groupe Telegram RouquinSOL public
- [ ] Migrer token vers Solana mainnet
- [ ] Pool de liquidité Raydium (SOL/ROUQ)
- [ ] Intégrer post.js dans n8n pour automatisation
- [ ] Lien Discord permanent (pas d'expiration)
- [ ] Réactiver boutons "Buy $ROUQ" quand token sur DEX
- [ ] Stratégie contenu : tweets réguliers, memes, engagement
- [ ] Listing Jupiter, Birdeye, DexScreener
- [ ] NFT collection "Rouquin Gang"

---

## Référence rapide

### Poster un message
```bash
cd /Users/cyp/Documents/work/Claude/solana-rouquin/tools
node post.js "Mon message 🦊 #ROUQ #Solana"
```

### Déployer le site
```bash
cd /Users/cyp/Documents/work/Claude/solana-rouquin/website
script -q /dev/null vercel --prod --yes 2>&1 | cat
```

### Vérifier l'état Twitter
```javascript
import { TwitterApi } from 'twitter-api-v2';
import 'dotenv/config';
const client = new TwitterApi({ appKey, appSecret, accessToken, accessSecret });
const me = await client.v2.me({ 'user.fields': 'protected,public_metrics,description' });
console.log(me.data);
```

### Variables d'environnement (tools/.env)

| Variable | Description |
|---|---|
| `TWITTER_API_KEY` | Consumer Key (OAuth 1.0a) |
| `TWITTER_API_SECRET` | Consumer Secret |
| `TWITTER_ACCESS_TOKEN` | Access Token (commence par un nombre) |
| `TWITTER_ACCESS_SECRET` | Access Token Secret |
| `TELEGRAM_BOT_TOKEN` | Token du bot @RouquinSolBot |
| `TELEGRAM_CHAT_ID` | ID du chat/channel cible |
