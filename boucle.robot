*** Test Cases ***
Afficher des fruits 
    @{fruits}    Create List    pomme    banane    cerise
    afficher la liste    ${fruits}

Afficher des legumes
    @{legumes}    Create List    carotte    brocoli    épinard
    afficher la liste    ${legumes}

Afficher les Couleurs
    @{couleurs}    Create List    rouge    vert    bleu
    afficher la liste    ${couleurs}    

*** Keywords ***
afficher la liste
    [Arguments]    ${elements}
    ${taille}    Get Length    ${elements}
    log to console    La liste contient ${taille} éléments.
    FOR    ${element}    IN    @{elements}
        log to console    - ${element}
    END    



