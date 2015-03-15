require 'vcr'

VCR.configure do |c|
  c.hook_into :webmock
  c.cassette_library_dir = 'features/cassettes'
  c.default_cassette_options = { :record => :new_episodes, :decode_compressed_response => true, :match_requests_on => [:method, :uri, :body]}
end

VCR.cucumber_tags do |t|
  t.tag '@vcr', :use_scenario_name => false
end
