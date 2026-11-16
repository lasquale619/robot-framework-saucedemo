# Robot Framework — SauceDemo

[![Robot Framework Tests](https://github.com/lasquale619/robot-framework-saucedemo/actions/workflows/robot.yml/badge.svg)](https://github.com/lasquale619/robot-framework-saucedemo/actions/workflows/robot.yml)
![Robot Framework](https://img.shields.io/badge/Robot%20Framework-7.5-000000?logo=robotframework&logoColor=white)
![Browser Library](https://img.shields.io/badge/Browser%20Library-Playwright-2EAD33?logo=playwright&logoColor=white)

Automatisation des tests du site de démo [SauceDemo](https://www.saucedemo.com) avec **Robot Framework** et **Browser Library** (Playwright), construite exercice par exercice.

Les tests couvrent la connexion (réussie et refusée, en data-driven), l'ajout au panier et le parcours de commande complet. Ils sont organisés par page dans des fichiers `.resource`, filtrables par tags et exécutés à chaque push par GitHub Actions (rapport `log.html` / `report.html` disponible dans les artefacts du run).

## Prérequis

- [Python](https://www.python.org/downloads/) (cocher "Add python.exe to PATH" à l'installation)
- [Node.js](https://nodejs.org) version LTS
- Google Chrome (navigateur par défaut des tests) ou Microsoft Edge
- [VS Code](https://code.visualstudio.com) avec l'extension **RobotCode** (recommandé)

## Installation

```powershell
git clone https://github.com/lasquale619/robot-framework-saucedemo.git
cd robot-framework-saucedemo
python -m venv .venv
.venv\Scripts\Activate.ps1
pip install -r requirements.txt
rfbrowser init --skip-browsers
```

> `--skip-browsers` évite le téléchargement des navigateurs Playwright (bloqué sur certains réseaux d'entreprise à cause des certificats SSL). Les tests utilisent le navigateur déjà installé sur le PC, via l'option `channel`.

### Activation automatique du venv dans VS Code

Le fichier `.vscode/settings.json` du projet configure VS Code pour activer le venv automatiquement à chaque ouverture de terminal. Il suffit d'ouvrir le dossier `robot-framework-saucedemo` dans VS Code : `(.venv)` doit apparaître au début de la ligne de commande.

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
| `smoke` | Tests critiques, à lancer en priorité (connexion réussie, commande) |
| `connexion` | Tests de connexion |
| `negative` | Cas d'erreur |
| `panier` | Ajout au panier |
| `commande` | Parcours de commande |
| `saucedemo` | Tous les tests du fichier |

## Cycle de vie du navigateur

Les tests suivent le modèle recommandé avec Browser Library :

| Moment | Action | Pourquoi |
|---|---|---|
| `Suite Setup` | Ouvrir le navigateur (`New Browser`) | Une seule fois : c'est l'étape lente |
| `Test Setup` | Nouveau contexte + page (`New Context`, `New Page`) | Session vierge pour chaque test |
| `Test Teardown` | Fermer le contexte (`Close Context`) | Nettoyage après chaque test |
| `Suite Teardown` | Fermer le navigateur (`Close Browser`) | Une seule fois, à la fin |

Chaque test démarre ainsi déconnecté, avec un panier vide : les tests sont **indépendants** et peuvent s'exécuter seuls, dans n'importe quel ordre.

## Données de test

Chaque produit est décrit **une seule fois**, sous forme de dictionnaire, dans `resources/panier.resource` :

```robotframework
&{SAC}      id=sauce-labs-backpack         name=Sauce Labs Backpack
&{VESTE}    id=sauce-labs-fleece-jacket    name=Sauce Labs Fleece Jacket
```

- `id` sert à construire le locator du bouton d'ajout (`add-to-cart-<id>`)
- `name` sert à vérifier le produit dans le panier

Les keywords reçoivent la fiche complète du produit (`Ajouter Au Panier    ${SAC}`) et y lisent l'information dont ils ont besoin. Si le site renomme un produit, une seule ligne est à modifier.

## Structure du projet

```
robot-framework-saucedemo/
├── saucedemo.robot          ← les tests (scénarios uniquement)
├── test_install.robot       ← vérification de l'installation
├── .github/workflows/       ← exécution des tests sur GitHub Actions
└── resources/
    ├── common.resource      ← Browser, variables, ouverture du navigateur et du site
    ├── login.resource       ← keywords de la page de connexion
    ├── panier.resource      ← produits, ajout et vérification du panier
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
- [x] 10. `Suite Setup` vs `Test Setup`
- [x] 11. Dictionnaires (`&{}`)

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
- `Suite Setup` / `Suite Teardown`, hiérarchie Browser / Context / Page, indépendance des tests
- Dictionnaires : `&{}`, lecture avec `${dict}[clé]`, une seule source de vérité pour les données

## Idées pour plus tard

- Test avec des produits choisis aléatoirement (en enregistrant toujours les produits tirés dans le log)

## Comptes de test SauceDemo

| Utilisateur | Mot de passe | Comportement |
|---|---|---|
| `standard_user` | `secret_sauce` | Connexion normale |
| `locked_out_user` | `secret_sauce` | Compte bloqué |