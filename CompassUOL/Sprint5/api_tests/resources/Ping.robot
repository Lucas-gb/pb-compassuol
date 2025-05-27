*** Settings ***
Library    RequestsLibrary
Resource    Base.robot

*** Keywords ***
GET HealthCheck
    [Documentation]    Verifica se a API está online através do endpoint /ping
    ${session}    Criar Sessão API
    ${response}    GET On Session    restful-booker    /ping
    Validar Status Code    ${response}    201
    [Return]    ${response}