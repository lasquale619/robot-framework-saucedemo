*** Settings ***
Documentation    Keywords du parcours de commande : livraison et validation.
Resource         common.resource
Resource         panier.resource


*** Keywords ***
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