*** Settings ***
Library    RequestsLibrary
Library    Collections
Resource    ../resources/Auth.robot
Resource    ../resources/GetBookingIds.robot
Resource    ../resources/GetBooking.robot
Resource    ../resources/CreateBooking.robot
Resource    ../resources/UpdateBooking.robot
Resource    ../resources/PartialUpdateBooking.robot
Resource    ../resources/DeleteBooking.robot
Resource    ../resources/Ping.robot


*** Test Cases ***
Gerar e validar token para usuário cadastrado
    ${token}    Obter token
    Should Not Be Empty    ${token}
    Log    Token obtido com sucesso: ${token}
Obter detalhes de reserva por ID
    ${booking_id}=    Set Variable    1  
    GET Detalhes da Reserva    ${booking_id}
Buscar livros por ID
    ${booking_id}=    Set Variable    1  
    GET Detalhes basicos da Reserva    ${booking_id}
Criando booking
    POST criando reserva
Atualizar a reserva atual
    ${token}    Obter token
    PUT Atualizar reserva    1    ${token}
Atualização parcial da reserva
    ${token}    Obter token
    PATCH Atualização parcial reserva    1    ${token}
Excluir reserva existente
    ${token}    Obter token
    DELETE Reserva por ID    1    ${token}
Verificar se API está online
    GET HealthCheck

    







