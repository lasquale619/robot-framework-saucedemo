*** Settings ***
Documentation     Tests de connexion et de panier sur SauceDemo.
Library           Browser
Test Setup        Ouvrir SauceDemo
Test Teardown     Close Browser

*** Variables ***
${URL}              https://www.saucedemo.com
${USER}             standard_user
${LOCKED_USER}      locked_out_user
${PASSWORD}         secret_sauce

*** Test Cases ***
Connexion réussie
    Se connecter    ${USER}    ${PASSWORD}
    Get Text    css=.title    ==    Products

Connexion refusée
    Se connecter    ${LOCKED_USER}    ${PASSWORD}
    Get Text    css=[data-test="error"]    *=    locked out

Ajout d'un produit au panier
    Se connecter    ${USER}    ${PASSWORD}
    Ajouter au panier    sauce-labs-backpack
    Get Text    data-test=shopping-cart-badge  ==    1
    Ouvrir le panier
    Get Text    data-test=item-4-title-link    ==    Sauce Labs Backpack

Passer une commande
    Se connecter    ${USER}    ${PASSWORD}
    Ajouter au panier    sauce-labs-backpack
    Ajouter au panier    sauce-labs-fleece-jacket
    Get Text    data-test=shopping-cart-badge  ==    2
    Ouvrir le panier
    @{produits}    Create List    Sauce Labs Backpack    Sauce Labs Fleece Jacket
    Vérifier les produits du panier    ${produits}
    Click    id=checkout
    Remplir les informations de livraison    John    Doe    12345
    Get Text     data-test=title        ==    Checkout: Overview
    Vérifier les produits du panier    ${produits}
    Click        id=finish
    Get Text     data-test=complete-header        ==    Thank you for your order!      

*** Keywords ***
Ouvrir SauceDemo
    New Browser    chromium   channel=chrome     headless=False
    New Page       ${URL}

Se connecter
    [Arguments]    ${login}    ${mot_de_passe}
    Fill Text    id=user-name       ${login}
    Fill Text    id=password        ${mot_de_passe}
    Click        id=login-button

Ajouter au panier
    [Arguments]    ${product_id}
    Click    id=add-to-cart-${product_id}

Ouvrir le panier
    Click    id=shopping_cart_container    

Vérifier les produits du panier
    [Arguments]    ${produits}
    ${taille}=    Get Length    ${produits}
    Get Element Count    data-test=inventory-item-name    ==    ${taille}
    FOR    ${produit}    IN    @{produits}
        Get Element Count    css=[data-test="inventory-item-name"]:text-is("${produit}")    ==    1
    END

Remplir les informations de livraison
    [Arguments]    ${first_name}    ${last_name}    ${postal_code}
    Fill Text    id=first-name     ${first_name}
    Fill Text    id=last-name      ${last_name}
    Fill Text    id=postal-code     ${postal_code}
    Click        id=continue