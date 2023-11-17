Feature: Testando API Pokemon.

Background: Executa antes de cada teste
    * def url_base = 'https://pokeapi.co/api/v2/'

Scenario: Testando retorno 
    Given url 'https://pokeapi.co/api/v2/pokemon/pikachu'
    When method get
    Then status 200

Scenario: Testando retorno com informações invalidas
    Given url 'https://pokeapi.co/api/v2/pokemon/chocolate'
    When method get
    Then status 404

Scenario: Testando retorno pikachu e verificando o JSON
    Given url url_base
    And path '/pokemon/pikachu'
    When method get
    Then status 200
    And match response.name == "pikachu"
    And match response.id == 25

Scenario: Testando retorno pokemon Rede entrando em um dos elementos do array de idiomas e testando retorno do json
    Given url url_base
    And path '/version/1/'
    When method get
    Then status 200
    And def idioma = $.names[5].language.url
    And print idioma
    And url idioma
    When method get
    Then status 200
    And match response.name == "es"
    And match response.id == 7

Scenario: Testando retorno pokemon Dito entrando em um dos elementos do array de habilidades e testando retorno do json
    Given url url_base
    And path 'pokemon/ditto'
    When method get
    Then status 200
    And def ability = $.abilities[1].ability.name
    And print ability
    And match ability == "imposter"

Scenario: Testando efeitos da habilidade[0] do pokemon Dito
    Given url url_base
    And path 'ability/150/'
    When method get
    Then status 200
    And def effects = $.effect_entries[0].effect
    And print effects


Scenario: Testando retorno pokemon Dito entrando em um dos elementos do array de localização e testando retorno do json
    Given url url_base
    And path 'pokemon/132/encounters'
    When method get
    Then status 200
    And def local = $.[4].location_area.url
    And print local
    And url local
    When method get
    Then status 200
    And match response.location.name == "kanto-route-13"
    And match response.id == 306