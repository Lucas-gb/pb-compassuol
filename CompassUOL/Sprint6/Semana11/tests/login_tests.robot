*** Settings ***
Library     RequestsLibrary
Library     Collections

*** Variables ***
${BASE_URL}             http://98.81.214.7:3000
${LOGIN_ENDPOINT}       login

*** Test Cases ***
Cenario: Login Com Credenciais Validas
    Create Session      ServeRestSession    ${BASE_URL}
    ${payload}=         Create Dictionary   email=fulano@qa.com    password=teste
    ${response}=        POST On Session     ServeRestSession    ${LOGIN_ENDPOINT}    json=${payload}
    Should Be Equal As Strings      ${response.status_code}     200
    Should Contain                  ${response.json()}          authorization

Cenario: Login Com Email Invalido
    Create Session      ServeRestSession    ${BASE_URL}
    ${payload}=         Create Dictionary   email=email.invalido@qa.com    password=teste
    ${response}=        POST On Session     ServeRestSession    ${LOGIN_ENDPOINT}    json=${payload}    expected_status=401  
    Should Be Equal As Strings      ${response.status_code}     401
    Should Be Equal As Strings      ${response.json()['message']}       Email e/ou senha inválidos

Cenario: Login Com Senha Invalida
    Create Session      ServeRestSession    ${BASE_URL}
    ${payload}=         Create Dictionary   email=fulano@qa.com    password=senhaerrada
    ${response}=        POST On Session     ServeRestSession    ${LOGIN_ENDPOINT}    json=${payload}    expected_status=401  
    Should Be Equal As Strings      ${response.status_code}     401
    Should Be Equal As Strings      ${response.json()['message']}       Email e/ou senha inválidos