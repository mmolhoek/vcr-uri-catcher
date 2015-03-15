Feature: Using vcr-uri-catcher to fake a network error
  @vcr
  Scenario: Getting an error when i get a network timeout
    Given I get a network timeout
    When I visit one of the following uris:
      | uri                         |
      | https://github.com/mmolhoek |
    When I do:
      """ruby
      require 'rest_client'
      resource = RestClient::Resource.new("http://github.com/mmolhoek")
      request = resource.get()
      """
    Then I expect it to raise a RestClient::RequestTimeout error
