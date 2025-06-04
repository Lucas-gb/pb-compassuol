*** Settings ***
Library    RequestsLibrary
Library    Collections
Library    OperatingSystem

*** Variables ***
${BASE_URL}             http://35.168.12.153:3000   
${LOGIN_ENDPOINT}       /login
${VALID_EMAIL}          admin.teste@qa.com
${VALID_PASSWORD}       senhaadmin

*** Keywords ***
Login Com Credenciais Validas
    [Documentation]    
    [Arguments]        ${email}    ${password}

    Create Session    ServeRestSession    ${BASE_URL}

    ${login_payload}=    Create Dictionary
    ...    email=${email}
    ...    password=${password}

    ${response}=    POST On Session    ServeRestSession    ${LOGIN_ENDPOINT}    json=${login_payload}

    Should Be Equal As Strings    ${response.status_code}    200    msg=O Status Code do Login não foi 200 OK.
    Should Be Equal As Strings    ${response.json()['message']}    Login realizado com sucesso    msg=A mensagem de sucesso do Login está incorreta.
    Should Contain                ${response.json()}    authorization    msg=O token de autenticação não foi retornado. # Removi o msg conforme última correção

    [Return]    ${response.json()['authorization']}