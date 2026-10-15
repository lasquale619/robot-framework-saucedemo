*** Settings ***
Documentation    Keywords et variables partagés pour les tests SauceDemo.
Library          Browser

*** Variables ***
${URL}            https://www.saucedemo.com
${USER}           standard_user
${LOCKED_USER}    locked_out_user
${PASSWORD}       secret_sauce

*** Keywords ***
Ouvrir Saucedemo
    [Documentation]    Ouvre le site SauceDemo dans un navigateur Chrome.
    New Browser    chromium    channel=chrome    headless=False
    New Page    ${URL}