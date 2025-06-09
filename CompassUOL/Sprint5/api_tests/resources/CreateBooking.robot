*** Settings ***
Library    RequestsLibrary
Library    Collections
Resource    Base.robot

*** Keywords ***
Criar Payload de Reserva
    [Arguments]    ${firstname}=Jim    ${lastname}=Brown    ${totalprice}=111    
    ...    ${depositpaid}=${true}    ${checkin}=2024-01-01    ${checkout}=2024-01-05    
    ...    ${additionalneeds}=Breakfast
    
    &{bookingdates}    Create Dictionary
    ...    checkin=${checkin}
    ...    checkout=${checkout}
    
    &{payload}    Create Dictionary
    ...    firstname=${firstname}
    ...    lastname=${lastname}
    ...    totalprice=${totalprice}
    ...    depositpaid=${depositpaid}
    ...    bookingdates=&{bookingdates}
    ...    additionalneeds=${additionalneeds}
    
    [Return]    ${payload}

POST criando reserva
    [Arguments]    ${firstname}=Jim    ${lastname}=Brown    ${totalprice}=111    
    ...    ${depositpaid}=${true}    ${checkin}=2024-01-01    ${checkout}=2024-01-05    
    ...    ${additionalneeds}=Breakfast
    
    ${payload}    Criar Payload de Reserva    ${firstname}    ${lastname}    ${totalprice}    
    ...    ${depositpaid}    ${checkin}    ${checkout}    ${additionalneeds}

    ${session}    Criar Sessão API
    ${headers}    Criar Headers Básicos
    
    ${response}    POST On Session    restful-booker    /booking    json=${payload}    headers=${headers}
    Validar Status Code    ${response}
    Validar Resposta Contém Campo    ${response}    bookingid
    
    [Return]    ${response.json()}