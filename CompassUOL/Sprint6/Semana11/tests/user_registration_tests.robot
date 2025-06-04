*** Settings ***
Library         RequestsLibrary
Library         Collections
Library         String

*** Variables ***
${BASE_URL}             http://35.168.12.153:3000
${USERS_ENDPOINT}       usuarios
${FULL_URL}             ${BASE_URL}/usuarios

*** Test Cases ***
Cenario: Validar Restricao De Cadastro Com Dominio Gmail
    [Documentation]    
    [Tags]             usuario    cadastro    negativo    restricao    email

    ${unique_user_name}=    Generate Random String    8    [LETTERS]
    ${unique_user_name}=    Catenate    SEPARATOR=    Usuario    ${unique_user_name}

    ${restricted_email}=    Catenate    SEPARATOR=    ${unique_user_name}    @gmail.com
    ${password}=            Generate Random String    8    [NUMBERS][LETTERS]

    &{user_payload}=    Create Dictionary
    ...    nome=${unique_user_name}
    ...    email=${restricted_email}
    ...    password=${password}
    ...    administrador=false

    Create Session    ServeRestUserSessionGmail    ${BASE_URL} # Garante que a sessão é criada corretamente

    ${response}=    POST On Session    ServeRestUserSessionGmail    ${FULL_URL}    json=${user_payload}

    Log To Console    Corpo da Resposta (Erro): ${response.json()}

    Should Be Equal As Strings    ${response.status_code}    400    msg=Status Code não foi 400 para email restrito (Gmail).
    Should Contain    ${response.json()['message']}    Email já cadastrado    msg=A mensagem de erro para email restrito (Gmail) está incorreta.


Cenario: Validar Restricao De Cadastro Com Dominio Hotmail
    [Documentation]    
    [Tags]             usuario    cadastro    negativo    restricao    email

    ${unique_user_name}=    Generate Random String    8    [LETTERS]
    ${unique_user_name}=    Catenate    SEPARATOR=    Usuario    ${unique_user_name}

    ${restricted_email}=    Catenate    SEPARATOR=    ${unique_user_name}    @hotmail.com
    ${password}=            Generate Random String    8    [NUMBERS][LETTERS]

    &{user_payload}=    Create Dictionary
    ...    nome=${unique_user_name}
    ...    email=${restricted_email}
    ...    password=${password}
    ...    administrador=false

    Create Session    ServeRestUserSessionHotmail    ${BASE_URL} # Garante que a sessão é criada corretamente

    ${response}=    POST On Session    ServeRestUserSessionHotmail    ${FULL_URL}    json=${user_payload}

    Log To Console    Corpo da Resposta (Erro): ${response.json()}

    Should Be Equal As Strings    ${response.status_code}    400    msg=Status Code não foi 400 para email restrito (Hotmail).
    Should Contain    ${response.json()['message']}    Email já cadastrado    msg=A mensagem de erro para email restrito (Hotmail) está incorreta.