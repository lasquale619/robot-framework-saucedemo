*** Settings ***
Library           Browser
Test Setup        Ouvrir SauceDemo
Test Teardown     Close Browser

*** Keywords ***
Ouvrir SauceDemo
    New Browser    chromium    channel=msedge    headless=False
    New Page       ${URL}

*** Variables ***
${URL}            https://www.saucedemo.com
${USER}           standard_user
${LOCKED_USER}    locked_out_user
${PASSWORD}       secret_sauce



*** Test Cases ***
Connexion réussie
    Fill Text      id=user-name    ${USER}
    Fill Text      id=password     ${PASSWORD}
    Click          id=login-button
    Get Text       css=.title    ==    Products

Connexion refusée
    Fill Text      id=user-name    ${LOCKED_USER}
    Fill Text      id=password     ${PASSWORD}
    Click          id=login-button
    Get Text     css=[data-test="error"]    *=    locked out


