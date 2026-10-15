# Rb-Exo

Exercices d'apprentissage de **Robot Framework** avec **Browser Library** (Playwright), sur le site de démo [SauceDemo](https://www.saucedemo.com).

## Prérequis

- [Python](https://www.python.org/downloads/) (cocher "Add python.exe to PATH" à l'installation)
- [Node.js](https://nodejs.org) version LTS
- Google Chrome (navigateur par défaut des tests) ou Microsoft Edge
- [VS Code](https://code.visualstudio.com) avec l'extension **RobotCode** (recommandé)

## Installation

```powershell
git clone https://github.com/lasquale619/Rb-Exo.git
cd Rb-Exo
python -m venv .venv
.venv\Scripts\Activate.ps1
pip install -r requirements.txt
rfbrowser init --skip-browsers
```

> `--skip-browsers` évite le téléchargement des navigateurs Playwright (bloqué sur certains réseaux d'entreprise à cause des certificats SSL). Les tests utilisent le navigateur déjà installé sur le PC, via l'option `channel`.

### Activation automatique du venv dans VS Code

Le fichier `.vscode/settings.json` du projet configure VS Code pour activer le venv automatiquement à chaque ouverture de terminal. Il suffit d'ouvrir le dossier `Rb-Exo` dans VS Code : `(.venv)` doit apparaître au début de la ligne de commande.

## Lancer les tests

```powershell
# Tous les tests
robot saucedemo.robot

# Un seul test (guillemets doubles si le nom contient une apostrophe)
robot --test "Passer Une Commande" saucedemo.robot

# Par tag
robot --include smoke saucedemo.robot
robot --exclude connexion saucedemo.robot

# Sans afficher le navigateur
robot -v HEADLESS:True saucedemo.robot

# Avec Edge au lieu de Chrome
robot -v CHANNEL:msedge saucedemo.robot

# Ouvrir le rapport dans le navigateur
start log.html
```

Les résultats sont générés dans `log.html` (détail pas à pas, à ouvrir en cas d'échec) et `report.html` (synthèse et statistiques par tag).

### Variables configurables

| Variable | Défaut | Rôle |
|---|---|---|
| `HEADLESS` | `False` | `True` pour lancer sans fenêtre de navigateur |
| `CHANNEL` | `chrome` | Navigateur installé à utiliser (`chrome`, `msedge`) |

### Tags disponibles

| Tag | Tests concernés |
|---|---|
| `smoke` | Tests critiques, à lancer en priorité |
| `connexion` | Tests de connexion |
| `negatif` | Cas d'erreur |
| `panier` | Ajout au panier |
| `commande` | Parcours de commande |
| `saucedemo` | Tous les tests du fichier |

## Structure du projet

```
Rb-Exo/
├── saucedemo.robot          ← les tests (scénarios uniquement)
├── boucle.robot             ← entraînement listes et boucles FOR
├── test_install.robot       ← vérification de l'installation
└── resources/
    ├── common.resource      ← Browser, variables, ouverture du site
    ├── login.resource       ← keywords de la page de connexion
    ├── panier.resource      ← ajout et vérification du panier
    └── commande.resource    ← livraison et validation de la commande
```

## Progression des exercices

- [x] 1. Connexion réussie
- [x] 2. Connexion refusée (`locked_out_user`)
- [x] 3. Keyword `Se Connecter` avec arguments
- [x] 4. Ajouter un produit au panier
- [x] 5. Parcours d'achat complet
- [x] 5 bis. Keyword générique de vérification du panier (listes et boucle `FOR`)
- [x] 6. Tests data-driven avec `[Template]`
- [x] 7. Découpage du projet en fichiers `.resource` par page
- [x] 8. Tags
- [x] 9. Variables en ligne de commande
- [ ] 10. `Suite Setup` vs `Test Setup`

## Notions vues

- Structure d'un fichier : Settings, Variables, Test Cases, Keywords
- Locators : `id`, `css`, `data-test`, `:text-is()`
- Assertions : `==`, `*=`, `Get Element Count`
- `Test Setup` / `Test Teardown`
- Keywords utilisateur avec `[Arguments]` et `[Documentation]`
- Listes (`@{}`, `Create List`, `VAR`), `Get Length`, boucles `FOR`
- Tests data-driven avec `[Template]` et `${EMPTY}`
- Fichiers `.resource`, imports entre resources, organisation par page (Page Object)
- Tags : `[Tags]`, `Test Tags`, `--include`, `--exclude`, `AND` / `OR`
- Variables en ligne de commande : `-v NOM:valeur`

## Idées pour plus tard

- Test avec des produits choisis aléatoirement (en enregistrant toujours les produits tirés dans le log)
- Associer l'identifiant et le nom de chaque produit avec un dictionnaire (`&{}`)

## Comptes de test SauceDemo

| Utilisateur | Mot de passe | Comportement |
|---|---|---|
| `standard_user` | `secret_sauce` | Connexion normale |
| `locked_out_user` | `secret_sauce` | Compte bloqué |