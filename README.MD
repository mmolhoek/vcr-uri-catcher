# vcr-uri-catcher

- ![Version](https://img.shields.io/gem/v/vcr-uri-catcher.svg?style=flat-square)
- ![Issues](https://img.shields.io/github/issues/mmolhoek/vcr-uri-catcher.svg)
- ![Forks] (https://img.shields.io/github/forks/mmolhoek/vcr-uri-catcher.svg)
- ![Licence](https://img.shields.io/badge/license-MIT-blue.svg)
- [![Code Climate](https://codeclimate.com/github/mmolhoek/vcr-uri-catcher/badges/gpa.svg)](https://codeclimate.com/github/mmolhoek/vcr-uri-catcher)

I have been using [cucumber](https://cukes.info/) and [VCR](https://github.com/vcr/vcr) for quite a while now and what I was missing was a way to test network failures depite of the fact that those URI's were already recorded by [VCR](https://github.com/vcr/vcr).
This little gem provides just that.

## usage

After requiring the gem in the features/support/vcr.rb somewhere

```ruby
require 'vcr-uri-catcher'
```

you can use it in the [cucumber](https://cukes.info/) test:

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
  URICatcher::execute {raise RestClient::RequestTimeout}
end
```
> Here I tell URICatcher which code block should be executed when we get to the configured uri.<br/>
> In this case we will raise an RestClient::RequestTimeout, that we want to test 

```ruby
When(/^I visit one of the following uris:$/) do |uris|
  uris.hashes.each do |row|
    URICatcher::when_visiting(row[:uri])
  end
end
```
> You can enter a string or a regular expression to describe your uri<br/>

```ruby
Given(/^I do:$/) do |code|
  begin
    eval code
  rescue => @error
  end
end
```
> Here we catch the raised RestClient::RequestTimeout and put it in @error, so we can check it in the next step (or any other).<br/>


```ruby
Then(/^I expect it to raise a (.*) error$/) do |error|
  expect(@error.class.to_s).to eq(error)
end
```
> And finally, here we have the step to see what error it was.


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

## what else

* checkout [Jeweler](https://github.com/technicalpickles/jeweler), which I use for this project. Perfect for making your project management (gem building, deployement, etc a breeze)

## Copyright

Copyright (c) 2015 Mischa Molhoek. See LICENSE.txt for further details.
