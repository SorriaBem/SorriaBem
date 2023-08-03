# features/dentist.feature
Feature: Busca de dentista
  As a Usuario do sistema
  I want to buscar um medico informando o seu nome
  So that eu visualize o paciente desejado

  Background: Dado que já existe o dentista "Joao Jose"
    Given que já existe o dentista "Joao Jose" com a especialidade "Cardio" e outros dados
    And estou na pagina de busca de dentistas

  Scenario: Pesquisar e visualizar detalhes do dentista
    When eu pesquiso por "Joao Jose" no campo "query"
    Then eu vejo resultados relacionados ao dentista "Joao Jose"
    When eu clico no botão escrito "Buscar"
    And eu vejo o link com o nome de "Joao Jose"
    When eu clico no link com o nome de  "Joao Jose"
    Then eu sou redirecionado para a página do dentista "Joao Jose"
    And vejo as informações do dentista:
      """
      Campo: nome
      Valor: Joao Jose
      Campo: especialidade
      Valor: Cardio
      Campo: cpf
      Valor: 11111111111
      Campo: email
      Valor: joao@example.com
      Campo: cro
      Valor: 123456
      Campo: inicio_horario_atendimento
      Valor: 13:00
      Campo: termino_horario_atendimento
      Valor: 19:00
      """

  Scenario: Busca sem resultados
    Given eu procuro por um dentista que não existe no sistema
    And estou na pagina de busca de dentistas
    When eu pesquiso por "Platão" no campo "query"
    And eu aperto o botão "Buscar"
    Then eu vejo a mensagem "Nenhum dentista encontrado" na nova tela, informando que não foram encontrados resultados


