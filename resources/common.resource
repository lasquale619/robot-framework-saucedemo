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
Ouvrir Saucedemo
    [Documentation]    Ouvre le site SauceDemo dans un navigateur Chrome.
    New Browser    ${BROWSER}    channel=${CHANNEL}    headless=${HEADLESS}
    New Page    ${URL}