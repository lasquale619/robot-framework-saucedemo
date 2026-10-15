*** Settings ***
Documentation    Keywords de la page de connexion.
Resource         common.resource

*** Keywords ***
Se Connecter
    [Documentation]    Se connecte à SauceDemo avec les informations d'identification fournies.
    [Arguments]    ${login}    ${mot_de_passe}
    Fill Text    id=user-name    ${login}
    Fill Text    id=password    ${mot_de_passe}
    Click    id=login-button

Vérifier Connexion Refusée
    [Documentation]    Vérifie que la connexion est refusée avec le message attendu.
    [Arguments]    ${login}    ${mot_de_passe}    ${message_attendu}
    Se Connecter    ${login}    ${mot_de_passe}
    Get Text    css=[data-test="error"]    *=    ${message_attendu}
