*** Settings ***
Library    RequestsLibrary
Library    Collections
Resource    Base.robot

*** Keywords ***
GET Detalhes da Reserva
    [Arguments]    ${booking_id}
    [Documentation]    Obtém os detalhes completos de uma reserva pelo ID
    ${session}    Criar Sessão API
    ${headers}    Criar Headers Básicos
    
    ${response}    GET On Session    restful-booker    /booking/${booking_id}    headers=${headers}
    Validar Status Code    ${response}
    Log    Detalhes: ${response.json()}
    [Return]    ${response.json()}

GET Detalhes basicos da Reserva
    [Arguments]    ${booking_id}
    [Documentation]    Obtém os detalhes básicos de uma reserva pelo ID
    ${response}    GET Detalhes da Reserva    ${booking_id}
    Log    ID ${booking_id} retornado com sucesso
    [Return]    ${response}