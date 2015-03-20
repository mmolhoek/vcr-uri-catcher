Given(/^I get a network timeout$/) do
  URICatcher::execute {raise RestClient::RequestTimeout}
end

When(/^I visit one of the following uris:$/) do |uris|
  uris.hashes.each do |row|
    URICatcher::when_visiting(row[:regexp] == 'true' ? %r{#{row[:uri]}} : row[:uri])
  end
end

Given(/^I do:$/) do |code|
  begin
    eval code
  rescue => @error
  end
end

Then(/^I expect it to raise a (.*) error$/) do |error|
  expect(@error.class.to_s).to eq(error)
end
