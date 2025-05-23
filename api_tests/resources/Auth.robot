*** Settings ***
Library    RequestsLibrary
Library    String

*** Variables ***
${BASE_URL}    https://restful-booker.herokuapp.com
${USERNAME}    admin
${PASSWORD}    password123

*** Keywords ***
Autenticar usuário cadastrado e gerar token valido
    [Documentation]    autenticação na API de token válido
    ${body}    Create Dictionary    
    ...    username=${USERNAME}    
    ...    password=${PASSWORD}
        
    Create Session    restful-booker    ${BASE_URL}
    ${headers}    Create Dictionary    Content-Type=application/json
    
    ${resposta}    POST On Session    
    ...    restful-booker    /auth    
    ...    json=${body}    
    ...    headers=${headers}
    
    [Return]    ${resposta.json()}

Obter token
    [Documentation]    Retorna apenas o token sem fazer requisição adicional
    ${token_data}    Autenticar usuário cadastrado e gerar token valido
    [Return]    ${token_data['token']}

