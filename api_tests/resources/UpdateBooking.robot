*** Settings ***
Library    RequestsLibrary
Library    Collections

*** Keywords ***
PUT Atualizar reserva
    [Arguments]    ${booking_id}    ${token}
    &{headers}    Create Dictionary
    ...    Content-Type=application/json
    ...    Accept=application/json
    ...    Cookie=token=${token}

    &{bookingdates}    Create Dictionary
    ...    checkin=2024-01-01
    ...    checkout=2024-01-10

    &{payload}    Create Dictionary
    ...    firstname=Maria
    ...    lastname=Silva
    ...    totalprice=200
    ...    depositpaid=${true}
    ...    bookingdates=&{bookingdates}
    ...    additionalneeds=Dinner

    ${session}    Create Session    temp_session    https://restful-booker.herokuapp.com
    PUT On Session    temp_session    /booking/${booking_id}    json=${payload}    headers=&{headers}
    [Teardown]    Delete All Sessions