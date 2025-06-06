*** Settings ***
Library    RequestsLibrary
Library    Collections
Library    String
Library    FakerLibrary

*** Variables ***
${BASE_URL}             http://98.81.214.7:3000
${PRODUCTS_ENDPOINT}     produtos
${CARTS_ENDPOINT}        carrinhos
${LOGIN_ENDPOINT}         login

*** Test Cases ***
Cenario: Validar Cadastro De Produto Com Sucesso
    # Login para obter token
    Create Session    ServeRestSession    ${BASE_URL}
    ${login_payload}=    Create Dictionary    email=fulano@qa.com    password=teste
    ${login_response}=    POST On Session    ServeRestSession    ${LOGIN_ENDPOINT}    json=${login_payload}
    ${token}=    Set Variable    ${login_response.json()['authorization']}
    
    # Cadastrar produto
    ${unique_product_name}=    Generate Random String    10    [NUMBERS][LETTERS]
    ${unique_product_name}=    Catenate    SEPARATOR=    Monitor Gamer    ${unique_product_name}
    
    ${headers}=    Create Dictionary    Authorization=${token}
    ${product_payload}=    Create Dictionary
    ...    nome=${unique_product_name}
    ...    preco=1499
    ...    descricao=Monitor gamer 27 polegadas, 144hz, 1ms, resolução Full HD.
    ...    quantidade=10
    
    ${response}=    POST On Session    ServeRestSession    ${PRODUCTS_ENDPOINT}    json=${product_payload}    headers=${headers}
    Should Be Equal As Strings    ${response.status_code}    201
    Should Be Equal As Strings    ${response.json()['message']}    Cadastro realizado com sucesso
    Should Contain    ${response.json()}    _id
    
    # Guardar ID e nome do produto para uso em outros testes
    Set Test Variable    ${PRODUTO_ID}    ${response.json()['_id']}
    Set Test Variable    ${PRODUTO_NOME}    ${unique_product_name}

Cenario: Cadastrar Produto Com Nome Duplicado
    # Login para obter token (caso não esteja na mesma sessão de teste)
    Create Session    ServeRestSession    ${BASE_URL}    verify=False
    ${login_payload}=    Create Dictionary    email=fulano@qa.com    password=teste
    ${login_response}=    POST On Session    ServeRestSession    ${LOGIN_ENDPOINT}    json=${login_payload}
    ${token}=    Set Variable    ${login_response.json()['authorization']}
    
    # Cadastrar primeiro produto com nome gerado pelo FakerLibrary
    ${nome_produto}=    FakerLibrary.Word
    ${headers}=    Create Dictionary    Authorization=${token}
    ${produto_payload}=    Create Dictionary
    ...    nome=${nome_produto}
    ...    preco=999
    ...    descricao=Produto teste para duplicação
    ...    quantidade=5
    
    ${response}=    POST On Session    ServeRestSession    ${PRODUCTS_ENDPOINT}    json=${produto_payload}    headers=${headers}
    Should Be Equal As Strings    ${response.status_code}    201
    
    # Tentar cadastrar produto com mesmo nome - esperamos erro 400
    ${response_duplicado}=    POST On Session    ServeRestSession    ${PRODUCTS_ENDPOINT}    json=${produto_payload}    headers=${headers}    expected_status=400
    Should Be Equal As Strings    ${response_duplicado.status_code}    400
    Should Be Equal As Strings    ${response_duplicado.json()['message']}    Já existe produto com esse nome

Cenario: Criar Carrinho Com Produto Valido
    # Login para obter token
    Create Session    ServeRestSession    ${BASE_URL}    verify=False
    ${login_payload}=    Create Dictionary    email=fulano@qa.com    password=teste
    ${login_response}=    POST On Session    ServeRestSession    ${LOGIN_ENDPOINT}    json=${login_payload}
    ${token}=    Set Variable    ${login_response.json()['authorization']}
    
    # Cadastrar um novo produto para o carrinho
    ${unique_product_name}=    Generate Random String    10    [NUMBERS][LETTERS]
    ${headers}=    Create Dictionary    Authorization=${token}
    ${product_payload}=    Create Dictionary
    ...    nome=Produto ${unique_product_name}
    ...    preco=100
    ...    descricao=Produto para teste de carrinho
    ...    quantidade=50
    
    ${response_product}=    POST On Session    ServeRestSession    ${PRODUCTS_ENDPOINT}    json=${product_payload}    headers=${headers}
    ${produto_id}=    Set Variable    ${response_product.json()['_id']}
    
    # Criar carrinho com o produto
    ${produto_dict}=    Create Dictionary    idProduto=${produto_id}    quantidade=1
    ${produtos_list}=    Create List    ${produto_dict}
    ${cart_payload}=    Create Dictionary    produtos=${produtos_list}
    
    # Excluir carrinho existente se houver
    Run Keyword And Ignore Error    DELETE On Session    ServeRestSession    ${CARTS_ENDPOINT}/cancelar-compra    headers=${headers}
    Sleep    1s
    
    ${response_cart}=    POST On Session    ServeRestSession    ${CARTS_ENDPOINT}    json=${cart_payload}    headers=${headers}    expected_status=anything
    Log    Resposta do carrinho: ${response_cart.text}
    Should Be Equal As Strings    ${response_cart.status_code}    201