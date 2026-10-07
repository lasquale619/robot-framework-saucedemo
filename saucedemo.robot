*** Settings ***
Documentation    Tests de connexion et de panier sur SauceDemo.

Library          Browser

Test Setup       Ouvrir Saucedemo
Test Teardown    Close Browser


*** Variables ***
${URL}            https://www.saucedemo.com
${USER}           standard_user
${LOCKED_USER}    locked_out_user
${PASSWORD}       secret_sauce


*** Test Cases ***
Connexion Réussie
    [Documentation]    Vérifie qu'un utilisateur valide peut se connecter avec succès.
    Se Connecter    ${USER}    ${PASSWORD}
    Get Text    css=.title    ==    Products

Connexion Refusée
    [Documentation]    Vérifie que les tentatives de connexion avec des informations d'identification incorrectes sont refusées.
    [Template]    Vérifier Connexion Refusée
    ${LOCKED_USER}    ${PASSWORD}    locked out
    ${USER}    wrong_password    do not match
    ${EMPTY}    ${EMPTY}    Username is required
    ${USER}    ${EMPTY}    Password is required
    ${EMPTY}    ${PASSWORD}    Username is required

Ajout d'un Produit Au Panier
    [Documentation]    Vérifie qu'un produit peut être ajouté au panier.
    Se Connecter    ${USER}    ${PASSWORD}
    Ajouter Au Panier    sauce-labs-backpack
    Get Text    data-test=shopping-cart-badge    ==    1
    Ouvrir Le Panier
    Get Text    data-test=item-4-title-link    ==    Sauce Labs Backpack

Passer Une Commande
    [Documentation]    Vérifie que la commande peut être passée avec succès.
    Se Connecter    ${USER}    ${PASSWORD}
    Ajouter Au Panier    sauce-labs-backpack
    Ajouter Au Panier    sauce-labs-fleece-jacket
    Get Text    data-test=shopping-cart-badge    ==    2
    VAR    @{produits}    Sauce Labs Backpack    Sauce Labs Fleece Jacket
    Vérifier Le Panier Contient    ${produits}
    Click    id=checkout
    Remplir Les Informations De Livraison    John    Doe    12345
    Finaliser La Commande    ${produits}


*** Keywords ***
Ouvrir Saucedemo
    [Documentation]    Ouvre le site SauceDemo dans un navigateur Chrome.
    New Browser    chromium    channel=chrome    headless=False
    New Page    ${URL}

Se Connecter
    [Documentation]    Se connecte à SauceDemo avec les informations d'identification fournies.
    [Arguments]    ${login}    ${mot_de_passe}
    Fill Text    id=user-name    ${login}
    Fill Text    id=password    ${mot_de_passe}
    Click    id=login-button

Ajouter Au Panier
    [Documentation]    Ajoute un produit au panier.
    [Arguments]    ${product_id}
    Click    id=add-to-cart-${product_id}

Vérifier Le Panier Contient
    [Documentation]    Vérifie le contenu du panier avant la validation.
    [Arguments]    ${produits}
    Ouvrir Le Panier
    Vérifier Les Produits Du Panier    ${produits}

Ouvrir Le Panier
    [Documentation]    Ouvre le panier.
    Click    id=shopping_cart_container

Vérifier Les Produits Du Panier
    [Documentation]    Vérifie que les produits dans le panier sont corrects.
    [Arguments]    ${produits}
    ${taille}    Get Length    ${produits}
    Get Element Count    data-test=inventory-item-name    ==    ${taille}
    FOR    ${produit}    IN    @{produits}
        Get Element Count    css=[data-test="inventory-item-name"]:text-is("${produit}")    ==    1
    END

Remplir Les Informations De Livraison
    [Documentation]    Remplit les informations de livraison du formulaire.
    [Arguments]    ${first_name}    ${last_name}    ${postal_code}
    Fill Text    id=first-name    ${first_name}
    Fill Text    id=last-name    ${last_name}
    Fill Text    id=postal-code    ${postal_code}
    Click    id=continue

Finaliser La Commande
    [Documentation]    Vérifie les produits lors de l'overview et confirme la commande.
    [Arguments]    ${produits}
    Get Text    data-test=title    ==    Checkout: Overview
    Vérifier Les Produits Du Panier    ${produits}
    Click    id=finish
    Get Text    data-test=complete-header    ==    Thank you for your order!

Vérifier Connexion Refusée
    [Documentation]    Vérifie que la connexion est refusée avec le message attendu.
    [Arguments]    ${login}    ${mot_de_passe}    ${message_attendu}
    Se Connecter    ${login}    ${mot_de_passe}
    Get Text    css=[data-test="error"]    *=    ${message_attendu}
