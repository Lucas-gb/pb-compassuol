*** Settings ***
Documentation     Testes de API para o sistema Restful-Booker
Library           RequestsLibrary
Library           Collections
Resource          ../resources/Auth.robot
Resource          ../resources/GetBookingIds.robot
Resource          ../resources/GetBooking.robot
Resource          ../resources/CreateBooking.robot
Resource          ../resources/UpdateBooking.robot
Resource          ../resources/PartialUpdateBooking.robot
Resource          ../resources/DeleteBooking.robot
Resource          ../resources/Ping.robot
Resource          ../resources/TestSteps.robot

*** Variables ***
${BOOKING_ID}     ${EMPTY}

*** Test Cases ***
Cenário 01: Verificar se API está online
    Verificar disponibilidade da API
    Executar health check
    Validar resposta positiva do servidor

Cenário 02: Gerar token de autenticação
    Preparar credenciais de acesso
    Solicitar geração de token
    Validar token recebido

Cenário 03: Criar uma nova reserva
    Preparar dados da reserva
    Enviar requisição de criação
    Validar criação da reserva
    Armazenar ID da reserva criada

Cenário 04: Consultar detalhes de uma reserva
    Obter ID de reserva válido
    Buscar detalhes da reserva
    Validar dados completos retornados

Cenário 05: Atualizar uma reserva existente
    Preparar dados e autenticação
    Enviar requisição de atualização completa
    Validar dados atualizados

Cenário 06: Atualizar parcialmente uma reserva
    Preparar dados para atualização parcial
    Enviar requisição de atualização parcial
    Validar campos específicos atualizados

Cenário 07: Excluir uma reserva existente
    Preparar ID e autenticação
    Executar exclusão da reserva
    Confirmar exclusão bem-sucedida