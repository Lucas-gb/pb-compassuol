*** Settings ***
Library    RequestsLibrary
Library    Collections
Library    String             
Resource   login_tests.robot  

*** Variables ***
${BASE_URL}             http://35.168.12.153:3000   
${PRODUCTS_ENDPOINT}    /produtos

${PRODUCT_LOGIN_EMAIL}      admin.teste@qa.com
${PRODUCT_LOGIN_PASSWORD}   senhaadmin

*** Test Cases ***
Cenario: Validar Cadastro De Produto Com Sucesso
    [Documentation]    
    [Tags]             produto    cadastro    positivo    api

    ${auth_token}=    Login Com Credenciais Validas    email=${PRODUCT_LOGIN_EMAIL}    password=${PRODUCT_LOGIN_PASSWORD}
    Log To Console    Obtido token: ${auth_token}

        Create Session    ServeRestProductSession    ${BASE_URL}
    ${headers}=       Create Dictionary    Authorization=Bearer    ${auth_token}

    ${unique_product_name}=    Generate Random String    10    [NUMBERS][LETTERS]
    ${unique_product_name}=    Catenate    SEPARATOR=    Monitor Gamer    ${unique_product_name}

    ${product_payload}=    Create Dictionary
    ...    nome=${unique_product_name}
    ...    preco=1499
    ...    descricao=Monitor gamer 27 polegadas, 144hz, 1ms, resolução Full HD.
    ...    quantidade=10

    ${response}=    POST On Session    ServeRestProductSession    ${PRODUCTS_ENDPOINT}
    ...    json=${product_payload}
    ...    headers=${headers}
    
    Log To Console    Corpo da Resposta do Produto (Erro): ${response.json()}

        Should Be Equal As Strings    ${response.status_code}    201    msg=O Status Code não foi 201 Created para cadastro de produto.

    Should Be Equal As Strings    ${response.json()['message']}    Cadastro realizado com sucesso    msg=A mensagem de sucesso para cadastro de produto está incorreta.

    Should Contain    ${response.json()}    _id    msg=O ID do produto não foi retornado.

    Log To Console    Produto cadastrado com sucesso! ID: ${response.json()['_id']}