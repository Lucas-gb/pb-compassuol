*** Settings ***
Library    RequestsLibrary
Library    Collections

*** Keywords ***
POST criando reserva
    &{bookingdates}    Create Dictionary
    ...    checkin=2024-01-01
    ...    checkout=2024-01-05
    
    &{payload}    Create Dictionary
    ...    firstname=Jim
    ...    lastname=Brown
    ...    totalprice=111
    ...    depositpaid=${true}
    ...    bookingdates=&{bookingdates}
    ...    additionalneeds=Breakfast

    ${session}    Create Session    temp_session    https://restful-booker.herokuapp.com
    ${response}    POST On Session    temp_session    /booking    json=${payload}
    Should Be Equal As Numbers    ${response.status_code}    200
    [Teardown]    Delete All Sessions