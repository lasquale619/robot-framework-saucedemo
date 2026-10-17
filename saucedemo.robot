*** Settings ***
Documentation    Tests de connexion et de panier sur SauceDemo.

Resource         resources/common.resource
Resource         resources/login.resource
Resource         resources/panier.resource
Resource         resources/commande.resource

Suite Setup       Ouvrir Le Navigateur
Suite Teardown    Close Browser
Test Setup        Ouvrir Saucedemo
Test Teardown     Close Context

Test Tags        saucedemo


*** Test Cases ***
Connexion Réussie
    [Documentation]    Vérifie qu'un utilisateur valide peut se connecter avec succès.
    [Tags]    connexion  Smoke
    Se Connecter    ${USER}    ${PASSWORD}
    Get Text    css=.title    ==    Products

Connexion Refusée
    [Documentation]    Vérifie que les connexions avec des informations incorrectes sont refusées.
    [Tags]    connexion  negative
    [Template]    Vérifier Connexion Refusée
    ${LOCKED_USER}    ${PASSWORD}    locked out
    ${USER}    wrong_password    do not match
    ${EMPTY}    ${EMPTY}    Username is required
    ${USER}    ${EMPTY}    Password is required
    ${EMPTY}    ${PASSWORD}    Username is required

Ajout d'un Produit Au Panier
    [Documentation]    Vérifie qu'un produit peut être ajouté au panier.
    [Tags]    Panier
    Se Connecter    ${USER}    ${PASSWORD}
    Ajouter Au Panier    ${SAC}
    Get Text    data-test=shopping-cart-badge    ==    1
    Ouvrir Le Panier
    Get Text    data-test=item-4-title-link    ==    ${SAC}[name]

Passer Une Commande
    [Documentation]    Vérifie que la commande peut être passée avec succès.
    [Tags]    commande  Smoke
    Se Connecter    ${USER}    ${PASSWORD}
    Ajouter Au Panier    ${SAC}
    Ajouter Au Panier    ${VESTE}
    Get Text    data-test=shopping-cart-badge    ==    2
    VAR    @{produits}    ${SAC}    ${VESTE}
    Vérifier Le Panier Contient    ${produits}
    Click    id=checkout
    Remplir Les Informations De Livraison    John    Doe    12345
    Finaliser La Commande    ${produits}
