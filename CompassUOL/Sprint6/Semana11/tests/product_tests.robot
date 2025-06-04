*** Settings ***
Library    RequestsLibrary
Library    Collections
Library    String             # Adicionada para gerar nomes de produto únicos
Resource   login_tests.robot  # Importa as keywords do arquivo login_tests.robot

*** Variables ***
${BASE_URL}             http://35.153.207.138:3000   # << Sua URL da EC2 >>
${PRODUCTS_ENDPOINT}    /produtos

# Credenciais para Login - devem ser as mesmas que funcionam no login_tests.robot
${PRODUCT_LOGIN_EMAIL}      admin.teste@qa.com
${PRODUCT_LOGIN_PASSWORD}   senhaadmin

*** Test Cases ***
Cenario: Validar Cadastro De Produto Com Sucesso
    [Documentation]    Testa se é possível cadastrar um novo produto com dados válidos, após login.
    [Tags]             produto    cadastro    positivo    api

    # 1. Realizar login para obter o token de autenticação
    ${auth_token}=    Login Com Credenciais Validas    email=${PRODUCT_LOGIN_EMAIL}    password=${PRODUCT_LOGIN_PASSWORD}
    Log To Console    Obtido token: ${auth_token}

    # 2. Criar uma sessão HTTP com a API, incluindo o header de autenticação
    Create Session    ServeRestProductSession    ${BASE_URL}
    ${headers}=       Create Dictionary    Authorization    ${auth_token}

    # 3. Gerar um nome de produto único para evitar conflitos
    ${unique_product_name}=    Generate Random String    10    [NUMBERS][LETTERS]
    ${unique_product_name}=    Catenate    SEPARATOR=    Monitor Gamer    ${unique_product_name}

    # 4. Definir o payload da requisição de cadastro de produto
    ${product_payload}=    Create Dictionary
    ...    nome=${unique_product_name}
    ...    preco=1499
    ...    descricao=Monitor gamer 27 polegadas, 144hz, 1ms, resolução Full HD.
    ...    quantidade=10

    # 5. Enviar a requisição POST para o endpoint de produtos
    ${response}=    POST On Session    ServeRestProductSession    ${PRODUCTS_ENDPOINT}
    ...    json=${product_payload}
    ...    headers=${headers}
    
    Log To Console    Corpo da Resposta do Produto (Erro): ${response.json()}

    # 6. Validar o Status Code da resposta (esperado: 201 Created)
    Should Be Equal As Strings    ${response.status_code}    201    msg=O Status Code não foi 201 Created para cadastro de produto.

    # 7. Validar a mensagem de sucesso no corpo da resposta
    Should Be Equal As Strings    ${response.json()['message']}    Cadastro realizado com sucesso    msg=A mensagem de sucesso para cadastro de produto está incorreta.

    # 8. Validar que um ID único foi retornado para o produto
    Should Contain    ${response.json()}    _id    msg=O ID do produto não foi retornado.

    Log To Console    Produto cadastrado com sucesso! ID: ${response.json()['_id']}