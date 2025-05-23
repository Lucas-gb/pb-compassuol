*** Settings ***
Library    RequestsLibrary
Library    Collections

*** Keywords ***
GET Lista de IDs de Reserva
    [Arguments]    ${booking_id}
    ${session}    Create Session    temp_session    https://restful-booker.herokuapp.com
    ${response}    GET On Session    temp_session    /booking/${booking_id}
    Should Be Equal As Numbers    ${response.status_code}    200
    Log    Detalhes: ${response.json()}
    [Teardown]    Delete All Sessions

GET Detalhes basicos da Reserva
    [Arguments]    ${booking_id}
    ${session}    Create Session    temp_session    https://restful-booker.herokuapp.com
    ${response}    GET On Session    temp_session    /booking/${booking_id}
    Should Be Equal As Numbers    ${response.status_code}    200
    Log    ID ${booking_id} retornado com sucesso
    [Teardown]    Delete All Sessions