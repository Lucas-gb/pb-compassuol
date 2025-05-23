*** Settings ***
Library    RequestsLibrary

*** Keywords ***
PATCH Atualização parcial reserva
    [Arguments]    ${booking_id}    ${token}
    ${headers}    Create Dictionary
    ...    Content-Type=application/json
    ...    Accept=application/json
    ...    Cookie=token=${token}

    ${payload}    Create Dictionary
    ...    firstname=James
    ...    lastname=Brown

    ${session}    Create Session    temp_session    https://restful-booker.herokuapp.com
    PATCH On Session    temp_session    /booking/${booking_id}    json=${payload}    headers=${headers}
    [Teardown]    Delete All Sessions