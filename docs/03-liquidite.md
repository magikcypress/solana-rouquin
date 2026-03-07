# 03 — Pool de liquidite : rendre $ROUQ tradable

## C'est quoi une pool de liquidite ?

Sans pool de liquidite, ton token existe mais **personne ne peut l'acheter ou le vendre**.
C'est juste des chiffres sur la blockchain.

Une pool de liquidite, c'est :
- Un contrat qui detient 2 tokens (ex: ROUQ + SOL)
- Un algorithme (AMM) qui calcule le prix automatiquement
- Quand quelqu'un achete du ROUQ, il envoie du SOL dans la pool
- Quand quelqu'un vend du ROUQ, il recupere du SOL

```
Pool ROUQ/SOL
┌──────────────────────────┐
│  100,000 ROUQ  +  2 SOL │
│                          │
│  Prix: 1 ROUQ = 0.00002 SOL
│         (~$0.0026)       │
└──────────────────────────┘

Quelqu'un achete 10,000 ROUQ :
→ Il envoie ~0.22 SOL dans la pool
→ Il recoit 10,000 ROUQ
→ Nouveau prix: 1 ROUQ = 0.0000244 SOL (le prix monte)
```

## Les DEX sur Solana

| DEX | Type | Utilisation |
|-----|------|------------|
| **Raydium** | AMM classique | Le plus utilise pour lancer des meme coins |
| **Orca** | Concentrated liquidity | Plus efficace mais plus complexe |
| **Jupiter** | Agregateur | Ne cree pas de pool, mais route les trades vers la meilleure pool |
| **Pump.fun** | Bonding curve | Plateforme de lancement simplifiee (voir section dediee) |
| **Meteora** | Dynamic AMM | Nouveau, pools dynamiques |

## Option A : Raydium (methode classique)

### Comment creer une pool sur Raydium

1. Aller sur https://raydium.io/liquidity/create-pool/
2. Connecter ton wallet (Phantom, Solflare)
3. Selectionner :
   - Token A : ROUQ (coller l'adresse du mint)
   - Token B : SOL
4. Definir le prix initial (combien de SOL pour 1 ROUQ)
5. Deposer la liquidite initiale
6. Confirmer la transaction

### Combien de liquidite mettre ?

| Scenario | ROUQ dans la pool | SOL dans la pool | Market Cap initial |
|----------|-------------------|------------------|--------------------|
| Minimum | 300,000 (30%) | 1 SOL | ~$430 |
| Correct | 300,000 (30%) | 3 SOL | ~$1,300 |
| Serieux | 300,000 (30%) | 10 SOL | ~$4,300 |

**Regle** : plus tu mets de SOL, plus le prix est stable au debut. Avec 1 SOL de liquidite, un seul achat de $50 peut faire bouger le prix de 20%.

### Prix initial : comment le calculer

```
Prix par ROUQ = SOL dans la pool / ROUQ dans la pool

Exemple avec 300,000 ROUQ + 3 SOL :
Prix = 3 / 300,000 = 0.00001 SOL par ROUQ
En dollars : 0.00001 * $130 = $0.0013 par ROUQ

Market Cap = Prix * Supply totale
= $0.0013 * 1,000,000 = $1,300
```

## Option B : Pump.fun (methode simplifiee)

Pump.fun est une plateforme qui simplifie tout :
- Tu uploades le logo, le nom, la description
- La plateforme cree le token ET la pool automatiquement
- Bonding curve : le prix monte avec les achats
- A $69k de market cap, migration automatique vers Raydium

**Avantage** : Zero config technique, tout est automatise
**Inconvenient** : Tu ne controles pas le token (Pump.fun le cree pour toi)

**Pour nous** : On a deja cree le token, donc Pump.fun n'est pas ideal.
On irait plutot sur Raydium.

## Strategie de liquidite recommandee

### Distribution des 1,000,000 ROUQ

```
1,000,000 ROUQ total
├── 300,000 (30%) → Pool de liquidite ROUQ/SOL
├── 400,000 (40%) → Airdrops communaute
├── 100,000 (10%) → Team (lock 6 mois)
├── 100,000 (10%) → Marketing / KOLs
└── 100,000 (10%) → Reserve burn
```

### Apres la creation de la pool

Une fois la pool creee :
1. Le token apparait sur **Jupiter** (agregateur) en quelques minutes
2. Il apparait sur **Birdeye** et **DexScreener** en quelques heures
3. N'importe qui peut acheter/vendre via Jupiter
4. Le prix bouge en fonction de l'offre et la demande

## Lock de liquidite

**CRUCIAL** : Si tu ne lock pas ta liquidite, n'importe qui peut voir que tu peux la retirer d'un coup (= rug pull). Personne ne fera confiance au token.

### Comment lock la liquidite

Utiliser un service de lock comme :
- **Raydium Lock** (integre)
- **Streamflow** (https://streamflow.finance)
- **Bonfida Vesting**

Lock la liquidite pour **6-12 mois minimum**.
Ca cree un smart contract qui empeche de retirer les LP tokens avant la date.

### Burn de liquidite (plus radical)

Au lieu de lock, tu peux **burn** les LP tokens :
```bash
# Envoyer les LP tokens a une adresse morte
spl-token transfer <LP_MINT> <amount> 1nc1nerator11111111111111111111111111111111 --fund-recipient
```
C'est irreversible. La liquidite reste dans la pool pour toujours.
C'est le signal le plus fort de confiance.
