# vcr-uri-catcher

I have been using VCR for a while now and what I was missing was a way to test network failures depite of the fact that those URI's were already recorded by VCR.
This little gem provides just that.

## usage

After requiring the gem in the features/support/vcr.rb somewhere

```ruby
require 'vcr-uri-catcher'
```

you can use it in the cucmber test:

```cucumber
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
```

using step definition:

```ruby
Given(/^I get a network timeout$/) do
  URICatcher::execute lambda {raise RestClient::RequestTimeout}
end

When(/^I visit one of the following uris:$/) do |uris|
  uris.hashes.each do |row|
    URICatcher::when_visiting(row[:regexp] == 'true' ? %r{#{row[:uri]}} : row[:uri])
  end
end

Given(/^I do:$/) do |code|
  begin
    eval code
  rescue RestClient::RequestTimeout => @error
  rescue
    raise
  end
end

Then(/^I expect it to raise a (.*) error$/) do |error|
  expect(@error.class.to_s).to eq(error)
end
```

## testing

```bash
bundle
bundle exec cucumber
```

## Contributing to vcr-uri-catcher
 
* Check out the latest master to make sure the feature hasn't been implemented or the bug hasn't been fixed yet.
* Check out the issue tracker to make sure someone already hasn't requested it and/or contributed it.
* Fork the project.
* Start a feature/bugfix branch.
* Commit and push until you are happy with your contribution.
* Make sure to add tests for it. This is important so I don't break it in a future version unintentionally.
* Please try not to mess with the Rakefile, version, or history. If you want to have your own version, or is otherwise necessary, that is fine, but please isolate to its own commit so I can cherry-pick around it.

## Copyright

Copyright (c) 2015 Mischa Molhoek. See LICENSE.txt for further details.
