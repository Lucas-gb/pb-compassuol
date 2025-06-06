*** Settings ***
Library    RequestsLibrary
Library    Collections
Library    FakerLibrary

*** Variables ***
${BASE_URL}          http://98.81.214.7:3000
${PRODUTOS_ENDPOINT}  produtos
${LOGIN_ENDPOINT}     login

*** Test Cases ***
Cenario: Cadastrar Produto Com Sucesso
    # Login para obter token
    Create Session    ServeRestSession    ${BASE_URL}
    ${login_payload}=    Create Dictionary    email=fulano@qa.com    password=teste
    ${login_response}=    POST On Session    ServeRestSession    ${LOGIN_ENDPOINT}    json=${login_payload}
    ${token}=    Set Variable    ${login_response.json()['authorization']}
    
    # Cadastrar produto
    ${nome_produto}=    FakerLibrary.Word
    ${preco}=    FakerLibrary.Random Int    min=10    max=1000
    ${descricao}=    FakerLibrary.Sentence    nb_words=5
    ${quantidade}=    FakerLibrary.Random Int    min=1    max=100
    
    ${headers}=    Create Dictionary    Authorization=${token}
    ${produto_payload}=    Create Dictionary    nome=${nome_produto}    preco=${preco}    descricao=${descricao}    quantidade=${quantidade}
    
    ${response}=    POST On Session    ServeRestSession    ${PRODUTOS_ENDPOINT}    json=${produto_payload}    headers=${headers}
    Should Be Equal As Strings    ${response.status_code}    201
    Should Be Equal As Strings    ${response.json()['message']}    Cadastro realizado com sucesso
    
    # Guardar ID do produto para uso em outros testes
    Set Test Variable    ${PRODUTO_ID}    ${response.json()['_id']}
    Set Test Variable    ${PRODUTO_NOME}    ${nome_produto}

Cenario: Cadastrar Produto Com Nome Duplicado
    # Tentar cadastrar produto com mesmo nome
    ${preco}=    FakerLibrary.Random Int    min=10    max=1000
    ${descricao}=    FakerLibrary.Sentence    nb_words=5
    ${quantidade}=    FakerLibrary.Random Int    min=1    max=100
    
    ${headers}=    Create Dictionary    Authorization=${token}
    ${produto_payload}=    Create Dictionary    nome=${PRODUTO_NOME}    preco=${preco}    descricao=${descricao}    quantidade=${quantidade}
    
    ${response}=    POST On Session    ServeRestSession    ${PRODUTOS_ENDPOINT}    json=${produto_payload}    headers=${headers}
    Should Be Equal As Strings    ${response.status_code}    400
    Should Be Equal As Strings    ${response.json()['message']}    Já existe produto com esse nome

Cenario: Listar Produtos
    ${response}=    GET On Session    ServeRestSession    ${PRODUTOS_ENDPOINT}
    Should Be Equal As Strings    ${response.status_code}    200
    Should Contain    ${response.json()}    produtos
    Should Contain    ${response.json()}    quantidade

Cenario: Buscar Produto Por ID
    ${response}=    GET On Session    ServeRestSession    ${PRODUTOS_ENDPOINT}/${PRODUTO_ID}
    Should Be Equal As Strings    ${response.status_code}    200
    Should Be Equal As Strings    ${response.json()['nome']}    ${PRODUTO_NOME}