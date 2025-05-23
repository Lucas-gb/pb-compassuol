*** Settings ***
Library    RequestsLibrary
Library    Collections

*** Keywords ***
GET Detalhes da Reserva
    [Arguments]    ${booking_id}
    ${session}    Create Session    temp_session    https://restful-booker.herokuapp.com
    ${response}    GET On Session    temp_session    /booking/${booking_id}
    Should Be Equal As Numbers    ${response.status_code}    200
    Log    Detalhes: ${response.json()}
    [Teardown]    Delete All Sessions