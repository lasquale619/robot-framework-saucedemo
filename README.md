# Rb-Exo
 
Exercices d'apprentissage de **Robot Framework** avec **Browser Library** (Playwright), sur le site de démo [SauceDemo](https://www.saucedemo.com).
 
## Prérequis
 
- [Python](https://www.python.org/downloads/) (cocher "Add python.exe to PATH" à l'installation)
- [Node.js](https://nodejs.org) version LTS
- Microsoft Edge (utilisé comme navigateur pour les tests)
## Installation
 
```powershell
git clone https://github.com/lasquale619/Rb-Exo.git
cd Rb-Exo
python -m venv .venv
.venv\Scripts\Activate.ps1
pip install -r requirements.txt
rfbrowser init --skip-browsers
```
 
> `--skip-browsers` évite le téléchargement des navigateurs Playwright (bloqué sur certains réseaux d'entreprise). Les tests utilisent Edge, déjà installé sur Windows, via `channel=msedge`.
 
## Lancer les tests
 
```powershell
# Tous les tests d'un fichier
robot saucedemo.robot
 
# Un seul test
robot --test "Connexion réussie" saucedemo.robot
```
 
Les résultats sont générés dans `log.html` (détail pas à pas) et `report.html` (synthèse).
 
## Contenu
 
| Fichier | Description |
|---|---|
| `test_install.robot` | Vérifie que l'installation fonctionne |
| `saucedemo.robot` | Exercices sur SauceDemo |
 
## Progression des exercices
 
- [x] 1. Connexion réussie
- [x] 2. Connexion refusée (`locked_out_user`)
- [ ] 3. Keyword `Se connecter` avec arguments
- [ ] 4. Ajouter un produit au panier
- [ ] 5. Parcours d'achat complet
- [ ] 6. Tests data-driven avec `Test Template`
## Comptes de test SauceDemo
 
| Utilisateur | Mot de passe | Comportement |
|---|---|---|
| `standard_user` | `secret_sauce` | Connexion normale |
| `locked_out_user` | `secret_sauce` | Compte bloqué |
 
