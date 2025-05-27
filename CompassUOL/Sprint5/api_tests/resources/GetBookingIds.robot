*** Settings ***
Library    RequestsLibrary
Library    Collections
Resource    Base.robot

*** Keywords ***
GET Listar IDs de Reservas
    [Documentation]    Obtém a lista de IDs de reservas disponíveis
    ${session}    Criar Sessão API
    ${headers}    Criar Headers Básicos
    
    ${response}    GET On Session    restful-booker    /booking    headers=${headers}
    Validar Status Code    ${response}
    
    [Return]    ${response.json()}

GET Filtrar IDs de Reservas
    [Arguments]    ${firstname}=None    ${lastname}=None    ${checkin}=None    ${checkout}=None
    [Documentation]    Filtra IDs de reservas por nome, sobrenome ou datas
    
    ${params}    Create Dictionary
    Run Keyword If    '${firstname}' != 'None'    Set To Dictionary    ${params}    firstname=${firstname}
    Run Keyword If    '${lastname}' != 'None'    Set To Dictionary    ${params}    lastname=${lastname}
    Run Keyword If    '${checkin}' != 'None'    Set To Dictionary    ${params}    checkin=${checkin}
    Run Keyword If    '${checkout}' != 'None'    Set To Dictionary    ${params}    checkout=${checkout}
    
    ${session}    Criar Sessão API
    ${headers}    Criar Headers Básicos
    
    ${response}    GET On Session    restful-booker    /booking    
    ...    params=${params}    headers=${headers}
    
    Validar Status Code    ${response}
    [Return]    ${response.json()}