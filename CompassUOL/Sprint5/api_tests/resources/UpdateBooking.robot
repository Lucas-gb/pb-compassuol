*** Settings ***
Library    RequestsLibrary
Library    Collections
Resource    Base.robot
Resource    CreateBooking.robot

*** Keywords ***
PUT Atualizar reserva
    [Arguments]    ${booking_id}    ${token}    ${firstname}=Maria    ${lastname}=Silva    
    ...    ${totalprice}=200    ${depositpaid}=${true}    ${checkin}=2024-01-01    
    ...    ${checkout}=2024-01-10    ${additionalneeds}=Dinner
    
    ${payload}    Criar Payload de Reserva    ${firstname}    ${lastname}    ${totalprice}    
    ...    ${depositpaid}    ${checkin}    ${checkout}    ${additionalneeds}
    
    ${session}    Criar Sessão API
    ${headers}    Criar Headers Com Token    ${token}
    
    ${response}    PUT On Session    restful-booker    /booking/${booking_id}    
    ...    json=${payload}    headers=${headers}
    
    Validar Status Code    ${response}
    [Return]    ${response.json()}