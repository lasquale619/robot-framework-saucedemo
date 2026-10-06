*** Settings ***
Library    Browser

*** Test Cases ***
Vérification installation
    New Browser    chromium    channel=msedge    headless=False
    New Page       https://www.saucedemo.com
    Get Title      ==    Swag Labs