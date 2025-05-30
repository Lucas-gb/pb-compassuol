*** Settings ***
Library    RequestsLibrary
Library    Collections
Resource    Base.robot

*** Keywords ***
DELETE Reserva por ID
    [Arguments]    ${booking_id}    ${token}
    [Documentation]    Exclui uma reserva pelo ID usando o token de autenticação
    
    ${session}    Criar Sessão API    verify_ssl=${False}
    ${headers}    Criar Headers Com Token    ${token}
    
    ${status}    ${response}    Run Keyword And Ignore Error
    ...    DELETE On Session    restful-booker    /booking/${booking_id}
    ...    headers=${headers}
    
    Run Keyword If    '${status}' == 'PASS'
    ...    Log    Reserva ${booking_id} excluída com sucesso
    ...    ELSE
    ...    Log    Falha ao excluir: ${response}    level=WARN
    
    [Return]    ${status}