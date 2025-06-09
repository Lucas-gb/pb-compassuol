*** Settings ***
Library    RequestsLibrary
Library    Collections
Library    String

*** Variables ***
${BASE_URL}    https://restful-booker.herokuapp.com
${USERNAME}    admin
${PASSWORD}    password123

*** Keywords ***
Criar Sessão API
    [Arguments]    ${verify_ssl}=${True}
    ${session}    Create Session    restful-booker    ${BASE_URL}    verify=${verify_ssl}
    [Return]    ${session}

Criar Headers Básicos
    ${headers}    Create Dictionary    Content-Type=application/json    Accept=application/json
    [Return]    ${headers}

Criar Headers Com Token
    [Arguments]    ${token}
    ${headers}    Criar Headers Básicos
    Set To Dictionary    ${headers}    Cookie=token=${token}
    [Return]    ${headers}

Validar Status Code
    [Arguments]    ${response}    ${expected_status}=200
    Should Be Equal As Numbers    ${response.status_code}    ${expected_status}
    
Validar Resposta Contém Campo
    [Arguments]    ${response}    ${field}
    Dictionary Should Contain Key    ${response.json()}    ${field}