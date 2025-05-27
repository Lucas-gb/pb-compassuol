*** Settings ***
Library    RequestsLibrary
Resource    Base.robot

*** Keywords ***
PATCH Atualização parcial reserva
    [Arguments]    ${booking_id}    ${token}    ${firstname}=James    ${lastname}=Brown
    
    ${payload}    Create Dictionary
    ...    firstname=${firstname}
    ...    lastname=${lastname}

    ${session}    Criar Sessão API
    ${headers}    Criar Headers Com Token    ${token}
    
    ${response}    PATCH On Session    restful-booker    /booking/${booking_id}    
    ...    json=${payload}    headers=${headers}
    
    Validar Status Code    ${response}
    [Return]    ${response.json()}