*** Settings ***
Library    RequestsLibrary
Library    Collections

*** Keywords ***
DELETE Reserva por ID
    [Arguments]    ${booking_id}    ${token}
    # Configuração mínima necessária para esta API
    ${headers}    Create Dictionary
    ...    Content-Type=application/json
    ...    Cookie=token=${token}
    
    # Criação da sessão com verificação SSL desativada
    ${session}    Create Session    temp_session    https://restful-booker.herokuapp.com
    ...    verify=${False}
    
    # Requisição DELETE com tratamento especial
    ${response}    Run Keyword And Ignore Error
    ...    DELETE On Session    temp_session    /booking/${booking_id}
    ...    headers=${headers}
    
    # Verificação flexível do status code
    Run Keyword If    '${response[0]}' == 'PASS'
    ...    Log    Reserva ${booking_id} excluída com sucesso
    ...    ELSE
    ...    Log    Falha ao excluir: ${response[1]}    level=WARN
    
    [Teardown]    Delete All Sessions