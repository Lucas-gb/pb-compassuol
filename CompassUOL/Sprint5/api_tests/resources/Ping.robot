*** Settings ***
Library    RequestsLibrary

*** Keywords ***
GET HealthCheck
    ${session}    Create Session    temp_session    https://restful-booker.herokuapp.com
    GET On Session    temp_session    /ping
    [Teardown]    Delete All Sessions