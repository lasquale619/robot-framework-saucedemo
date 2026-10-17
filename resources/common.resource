*** Settings ***
Documentation    Keywords et variables partagés pour les tests SauceDemo.
Library          Browser

*** Variables ***
${URL}            https://www.saucedemo.com
${USER}           standard_user
${LOCKED_USER}    locked_out_user
${PASSWORD}       secret_sauce
${HEADLESS}       False
${BROWSER}        chromium
${CHANNEL}        chrome

*** Keywords ***
Ouvrir Le Navigateur
    [Documentation]    Ouvre le navigateur défini par ${CHANNEL}, une seule fois pour la suite.
    New Browser    ${BROWSER}    channel=${CHANNEL}    headless=${HEADLESS}

Ouvrir Saucedemo
    [Documentation]    Crée une session vierge (contexte) et ouvre la page d'accueil de SauceDemo.
    New Context
    New Page    ${URL}
