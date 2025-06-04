*** Settings ***
Library    RequestsLibrary
Library    Collections
Library    String             
Resource   login_tests.robot  

*** Variables ***
${BASE_URL}             http://35.168.12.153:3000   
${PRODUCTS_ENDPOINT}    /produtos
${CARTS_ENDPOINT}       /carrinhos

${PRODUCT_LOGIN_EMAIL}      admin.teste@qa.com
${PRODUCT_LOGIN_PASSWORD}   senhaadmin

*** Test Cases ***
Cenario: Validar Cadastro De Produto Com Sucesso
    [Documentation]    
    [Tags]             produto    cadastro    positivo    api

    ${auth_token}=    Login Com Credenciais Validas    email=${PRODUCT_LOGIN_EMAIL}    password=${PRODUCT_LOGIN_PASSWORD}
    Log To Console    Obtido token: ${auth_token}

        Create Session    ServeRestProductSession    ${BASE_URL}
    ${headers}=       Create Dictionary    Authorization    ${auth_token}

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

Cenario: Criar Carrinho Com Produto Valido
    [Documentation]    Testa a criação de um carrinho com um produto válido.
    [Tags]             carrinho    cadastro    positivo    api

    ${auth_token}=     Login Com Credenciais Validas    email=${PRODUCT_LOGIN_EMAIL}    password=${PRODUCT_LOGIN_PASSWORD}
    
    Create Session    ServeRestSession    ${BASE_URL}
    ${headers}=    Create Dictionary    Authorization    ${auth_token}
    
    ${unique_product_name}=    Generate Random String    10    [NUMBERS][LETTERS]
    ${unique_product_name}=    Catenate    SEPARATOR=    Monitor Gamer    ${unique_product_name}

    ${product_payload}=    Create Dictionary
    ...    nome=${unique_product_name}
    ...    preco=1499
    ...    descricao=Monitor gamer 27 polegadas, 144hz, 1ms, resolução Full HD.
    ...    quantidade=2
    
    ${response_product_creation}=    POST On Session    ServeRestSession    ${PRODUCTS_ENDPOINT}
    ...    json=${product_payload}
    ...    headers=${headers}

    Should Be Equal As Strings    ${response_product_creation.status_code}    201
    ${product_id}=    Set Variable    ${response_product_creation.json()['_id']}
    Log To Console    Produto criado para carrinho com ID: ${product_id}

    ${produto_dict}=    Create Dictionary    idProduto=${product_id}    quantidade=1
    ${produtos_list}=    Create List    ${produto_dict}
    
    ${cart_payload}=    Create Dictionary    produtos=${produtos_list}

    ${response_cart_creation}=    POST On Session    ServeRestSession    ${CARTS_ENDPOINT}
    ...    json=${cart_payload}
    ...    headers=${headers}

    Log To Console    Corpo da Resposta do Carrinho: ${response_cart_creation.json()}

    Should Be Equal As Strings    ${response_cart_creation.status_code}    201    msg=Status Code para criação de carrinho não foi 201.
    Should Be Equal As Strings    ${response_cart_creation.json()['message']}    Cadastro realizado com sucesso    msg=Mensagem de sucesso para carrinho está incorreta.
    Should Contain    ${response_cart_creation.json()}    _id    msg=ID do carrinho não foi retornado.

    Log To Console    Carrinho criado com sucesso! ID: ${response_cart_creation.json()['_id']}