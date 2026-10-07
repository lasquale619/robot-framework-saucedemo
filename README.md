# Rb-Exo

Exercices d'apprentissage de **Robot Framework** avec **Browser Library** (Playwright), sur le site de démo [SauceDemo](https://www.saucedemo.com).

## Prérequis

- [Python](https://www.python.org/downloads/) (cocher "Add python.exe to PATH" à l'installation)
- [Node.js](https://nodejs.org) version LTS
- Google Chrome (utilisé comme navigateur pour les tests)
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

> `--skip-browsers` évite le téléchargement des navigateurs Playwright (bloqué sur certains réseaux d'entreprise à cause des certificats SSL). Les tests utilisent Chrome, déjà installé sur le PC, via `channel=chrome`.

### Activation automatique du venv dans VS Code

Le fichier `.vscode/settings.json` du projet configure VS Code pour activer le venv automatiquement à chaque ouverture de terminal. Il suffit d'ouvrir le dossier `Rb-Exo` dans VS Code : `(.venv)` doit apparaître au début de la ligne de commande.

## Lancer les tests

```powershell
# Tous les tests d'un fichier
robot saucedemo.robot

# Un seul test (guillemets doubles si le nom contient une apostrophe)
robot --test "Passer Une Commande" saucedemo.robot

# Plusieurs tests avec un joker
robot --test "Connexion*" saucedemo.robot
```

Les résultats sont générés dans `log.html` (détail pas à pas, à ouvrir en cas d'échec) et `report.html` (synthèse).

## Contenu

| Fichier | Description |
|---|---|
| `test_install.robot` | Vérifie que l'installation fonctionne |
| `saucedemo.robot` | Exercices sur SauceDemo (connexion, panier, commande) |
| `boucle.robot` | Entraînement sur les listes et les boucles `FOR`, sans navigateur |

## Progression des exercices

- [x] 1. Connexion réussie
- [x] 2. Connexion refusée (`locked_out_user`)
- [x] 3. Keyword `Se Connecter` avec arguments
- [x] 4. Ajouter un produit au panier
- [x] 5. Parcours d'achat complet
- [x] 5 bis. Keyword générique de vérification du panier (listes et boucle `FOR`)
- [x] 6. Tests data-driven avec `[Template]`
- [ ] 7. Découper le projet en fichiers `.resource`

## Notions vues

- Structure d'un fichier : Settings, Variables, Test Cases, Keywords
- Locators : `id`, `css`, `data-test`, `:text-is()`
- Assertions : `==`, `*=`, `Get Element Count`
- `Test Setup` / `Test Teardown`
- Keywords utilisateur avec `[Arguments]` et `[Documentation]`
- Listes (`@{}`, `Create List`, `VAR`), `Get Length`, boucles `FOR`
- Tests data-driven avec `[Template]` et `${EMPTY}`

## Idées pour plus tard

- Test avec des produits choisis aléatoirement (en enregistrant toujours les produits tirés dans le log)
- Associer l'identifiant et le nom de chaque produit avec un dictionnaire (`&{}`)

## Comptes de test SauceDemo

| Utilisateur | Mot de passe | Comportement |
| --- | --- | --- |
| `standard_user` | `secret_sauce` | Connexion normale |
| `locked_out_user` | `secret_sauce` | Compte bloqué |
