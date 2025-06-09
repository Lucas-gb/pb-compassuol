*** Settings ***
Documentation     Keywords para os passos de teste em linguagem natural
Resource          Auth.robot
Resource          GetBookingIds.robot
Resource          GetBooking.robot
Resource          CreateBooking.robot
Resource          UpdateBooking.robot
Resource          PartialUpdateBooking.robot
Resource          DeleteBooking.robot
Resource          Ping.robot

*** Keywords ***
# Cenário 01: Verificar se API está online
Verificar disponibilidade da API
    No Operation

Executar health check
    GET HealthCheck

Validar resposta positiva do servidor
    Log    API está online e funcionando

# Cenário 02: Gerar token de autenticação
Preparar credenciais de acesso
    No Operation

Solicitar geração de token
    ${token}    Obter token
    Set Test Variable    ${TOKEN}    ${token}

Validar token recebido
    Should Not Be Empty    ${TOKEN}
    Log    Token obtido com sucesso: ${TOKEN}

# Cenário 03: Criar uma nova reserva
Preparar dados da reserva
    No Operation

Enviar requisição de criação
    ${response}    POST criando reserva
    Set Test Variable    ${RESPONSE}    ${response}

Validar criação da reserva
    Dictionary Should Contain Key    ${RESPONSE}    bookingid

Armazenar ID da reserva criada
    ${id}    Set Variable    ${RESPONSE['bookingid']}
    Set Suite Variable    ${BOOKING_ID}    ${id}
    Log    Reserva criada com ID: ${id}

# Cenário 04: Consultar detalhes de uma reserva
Obter ID de reserva válido
    ${id}    Run Keyword If    '${BOOKING_ID}' == '${EMPTY}'    Set Variable    1
    ...    ELSE    Set Variable    ${BOOKING_ID}
    Set Test Variable    ${CURRENT_ID}    ${id}

Buscar detalhes da reserva
    ${details}    GET Detalhes da Reserva    ${CURRENT_ID}
    Set Test Variable    ${BOOKING_DETAILS}    ${details}

Validar dados completos retornados
    Dictionary Should Contain Key    ${BOOKING_DETAILS}    firstname
    Dictionary Should Contain Key    ${BOOKING_DETAILS}    lastname
    Dictionary Should Contain Key    ${BOOKING_DETAILS}    bookingdates

# Cenário 05: Atualizar uma reserva existente
Preparar dados e autenticação
    ${id}    Run Keyword If    '${BOOKING_ID}' == '${EMPTY}'    Set Variable    1
    ...    ELSE    Set Variable    ${BOOKING_ID}
    Set Test Variable    ${CURRENT_ID}    ${id}
    
    ${token}    Obter token
    Set Test Variable    ${TOKEN}    ${token}

Enviar requisição de atualização completa
    ${response}    PUT Atualizar reserva    ${CURRENT_ID}    ${TOKEN}
    Set Test Variable    ${UPDATE_RESPONSE}    ${response}

Validar dados atualizados
    Dictionary Should Contain Key    ${UPDATE_RESPONSE}    firstname
    Should Be Equal    ${UPDATE_RESPONSE['firstname']}    Maria

# Cenário 06: Atualizar parcialmente uma reserva
Preparar dados para atualização parcial
    ${id}    Run Keyword If    '${BOOKING_ID}' == '${EMPTY}'    Set Variable    1
    ...    ELSE    Set Variable    ${BOOKING_ID}
    Set Test Variable    ${CURRENT_ID}    ${id}
    
    ${token}    Obter token
    Set Test Variable    ${TOKEN}    ${token}

Enviar requisição de atualização parcial
    ${response}    PATCH Atualização parcial reserva    ${CURRENT_ID}    ${TOKEN}
    Set Test Variable    ${PATCH_RESPONSE}    ${response}

Validar campos específicos atualizados
    Dictionary Should Contain Key    ${PATCH_RESPONSE}    firstname
    Should Be Equal    ${PATCH_RESPONSE['firstname']}    James

# Cenário 07: Excluir uma reserva existente
Preparar ID e autenticação
    ${id}    Run Keyword If    '${BOOKING_ID}' == '${EMPTY}'    Set Variable    1
    ...    ELSE    Set Variable    ${BOOKING_ID}
    Set Test Variable    ${CURRENT_ID}    ${id}
    
    ${token}    Obter token
    Set Test Variable    ${TOKEN}    ${token}

Executar exclusão da reserva
    ${status}    DELETE Reserva por ID    ${CURRENT_ID}    ${TOKEN}
    Set Test Variable    ${DELETE_STATUS}    ${status}

Confirmar exclusão bem-sucedida
    Should Be Equal    ${DELETE_STATUS}    PASS