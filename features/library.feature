Feature: Testing the libraries consistancy
  Scenario: Getting an error when i don't pass anything to execute
    When I do:
      """ruby
      URICatcher::execute
      """
      Then I expect it to raise a URICatcher::NoBlockGiven error

  Scenario: Getting an error when i don't pass anything to when_visiting
    When I do:
      """ruby
      URICatcher::when_visiting
      """
      Then I expect it to raise a ArgumentError error

  Scenario: Getting an error when i don't pass a String or a RegExp to when_visiting
    When I do:
      """ruby
      URICatcher::when_visiting([1,2,3])
      """
      Then I expect it to raise a URICatcher::NotAString error
