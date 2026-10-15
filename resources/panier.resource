*** Settings ***
Documentation    Keywords du panier : ajout et vérification des produits.
Resource         common.resource

*** Keywords ***

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