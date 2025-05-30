*** Settings ***
Library    RequestsLibrary
Library    String
Resource    Base.robot

*** Keywords ***
Autenticar usuário cadastrado e gerar token valido
    [Documentation]    autenticação na API de token válido
    ${body}    Create Dictionary    
    ...    username=${USERNAME}    
    ...    password=${PASSWORD}
        
    ${session}    Criar Sessão API
    ${headers}    Criar Headers Básicos
    
    ${resposta}    POST On Session    
    ...    restful-booker    /auth    
    ...    json=${body}    
    ...    headers=${headers}
    
    Validar Status Code    ${resposta}
    [Return]    ${resposta.json()}

Obter token
    [Documentation]    Retorna apenas o token sem fazer requisição adicional
    ${token_data}    Autenticar usuário cadastrado e gerar token valido
    [Return]    ${token_data['token']}